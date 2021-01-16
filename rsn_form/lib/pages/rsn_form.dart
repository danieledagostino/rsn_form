import 'dart:io';
import 'dart:math';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rsn_form/dao/answer_dao.dart';
import 'package:rsn_form/dao/i_answer_dao.dart';
import 'package:rsn_form/form_widget/short_text_field.dart';
import 'package:rsn_form/json/json_step.dart';
import 'package:rsn_form/model/answer.dart';
import 'package:rsn_form/utility/gsheet_utils.dart';
import 'package:rsn_form/utility/make_step.dart';
import 'package:rsn_form/utility/notify.dart';
import 'package:http/http.dart';

class RsnForm extends StatefulWidget {
  final List<JsonStep> jsonSteps;

  RsnForm(this.jsonSteps);

  @override
  _RsnFormState createState() => _RsnFormState();
}

class _RsnFormState extends State<RsnForm> {
  MakeStep makeStep;
  List<Step> steps;
  IAnswerDao _dao;
  Answer _answer;
  BuildContext _context;

  int currentStep = 0;
  bool complete = false;

  @override
  void initState() {
    super.initState();
    _dao = GetIt.I.get();
    makeStep = MakeStep(widget.jsonSteps);
    //AndroidAlarmManager.initialize();
  }

  void init() async {
    await AndroidAlarmManager.oneShot(const Duration(seconds: 10),
        Random().nextInt(pow(2, 31)), Notify.setAlarm,
        exact: true, wakeup: true);
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    steps = makeStep.steps(currentStep);
    return new Scaffold(
        appBar: AppBar(
          title: Text('RSN Form'),
        ),
        body: Stepper(
          steps: steps,
          currentStep: currentStep,
          onStepContinue: next,
          //onStepTapped: (step) => goTo(step),
          onStepCancel: cancel,
          controlsBuilder: (BuildContext context,
              {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
            return Row(children: getButtons());
          },
        ));
  }

  List<Widget> getButtons() {
    List<Widget> list = List<Widget>();

    if ((currentStep + 1) == steps.length) {
      list.add(TextButton(
        onPressed: end,
        child: const Text('SUBMIT'),
      ));
    } else {
      list.add(TextButton(
        onPressed: next,
        child: const Text('NEXT'),
      ));
    }

    if (currentStep != 0) {
      list.add(TextButton(
        onPressed: cancel,
        child: const Text('CANCEL'),
      ));
    }

    return list;
  }

  void end() {
    saveData();
    GsheetUtils gsheet = GsheetUtils();

    _dao.findAll().then((List<Answer> list) {
      gsheet.sendData(list).then((Response res) {
        if (res.statusCode == GsheetUtils.STATUS_SUCCESS) {
          showAlert('Form submitted', 'Thanks to have shared your experience');
          _dao.deleteAll();
        } else {
          stderr.writeln(
              "Got some errors. Status code: " + res.statusCode.toString());
          showAlert('Form not submitted',
              'Oh no! Some issues occurred. Please retry');
        }
      }).catchError((e) => showAlert(
          'Form not submitted', 'Oh no! Some issues occurred. Please retry'));
    });
  }

  showAlert(String title, String content) {
    showDialog(
        context: _context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
          );
        });
  }

  void saveData() {
    Column col = steps[currentStep].content;
    col.children.forEach((e) {
      if (e is RsnShortTextField) {
        RsnShortTextField field = e;
        _answer = Answer(field.step, field.question, field.controller.text);
        _dao.insertOrUpdate(_answer);
      }
    });
  }

  void next() {
    saveData();
    //Provider.of<DateField>(context).update(null);
    goTo(currentStep + 1);
    FocusScope.of(context).unfocus();
  }

  void cancel() {
    //if (currentStep > 0) {
    goTo(currentStep - 1);
    //}
  }

  void goTo(int step) {
    setState(() => currentStep = step);
  }
}
