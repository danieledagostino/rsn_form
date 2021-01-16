import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';

import 'package:rsn_form/.env.dart';

import 'package:http/http.dart' as http;
import 'package:rsn_form/form_widget/date_field.dart';
import 'package:rsn_form/form_widget/full_text_field.dart';
import 'package:rsn_form/form_widget/radio_form.dart';
import 'package:rsn_form/form_widget/rsn_date_time.dart';
import 'package:rsn_form/form_widget/short_text_field.dart';
import 'package:rsn_form/json/json_step.dart';

class MakeStep {
  List<JsonStep> jsonSteps;
  int currentStep = 0;
  DateTimeField dateTimeField;

  MakeStep.test(final restJson) {
    try {
      jsonSteps = restJson.map<JsonStep>((m) => JsonStep.fromMap(m)).toList();
    } catch (err) {}
  }

  MakeStep(this.jsonSteps);

  static Future<List<JsonStep>> getResources({bool isDebug: false}) async {
    String jsonContent;
    if (isDebug) {
      await rootBundle
          .loadString(join('test_resources', 'widget_conf.json'))
          .then((value) => jsonContent = value)
          .catchError((error) {
        stderr.writeln('Exception during widget_conf.json');
        throw ('file not found');
      });
    } else {
      final String url = rsn_env['JSON_FORM_CONF'];
      print('sto passando da qua: ' + url);
      var res = await http.get(url).catchError((e) {
        stderr.writeln('Exception during widget_conf.json\n' + e.toString());
      });
      if (res.statusCode == 200) {
        jsonContent = res.body;
      } else {
        stderr.writeln('resource not available: ' + res.statusCode.toString());
        exit(1);
      }
    }

    return await jsonDecode(jsonContent);
  }

  static Future jsonDecode(String jsonContent) async {
    final restJson = json.decode(jsonContent);
    return restJson.map<JsonStep>((m) => JsonStep.fromMap(m)).toList();
  }

  Step nextStep(JsonStep jsonStep) {
    Step step = Step(
      title: Text(jsonStep.title),
      isActive: true,
      state: getSepState(jsonStep, currentStep),
      content: Column(children: _makeWidget(jsonStep)),
    );

    return step;
  }

  StepState getSepState(JsonStep jsonStep, int currentStep) {
    final cmp = currentStep + 1;
    if (jsonStep.step < cmp) {
      return StepState.complete;
    } else if (jsonStep.step == cmp) {
      return StepState.editing;
    } else {
      return StepState.disabled;
    }
  }

  List<Widget> _makeWidget(JsonStep jsonStep) {
    List<Widget> field = List<Widget>();
    /*
    if (dao == null) {
      dao = AnswerDao();
    }
    Answer answer = Answer(0, '', '');
    if (jsonStep.step == (currentStep + 1)) {
      dao.findByStep(jsonStep.step).then((Answer value) => {answer = value});
    }
    */

    if (jsonStep.answerType == AnswerType.full) {
      field.add(
          RsnFullTextField(step: jsonStep.step, question: jsonStep.question));
    } else if (jsonStep.answerType == AnswerType.short) {
      field.add(
          RsnShortTextField(step: jsonStep.step, question: jsonStep.question));
    } else if (jsonStep.answerType == AnswerType.radio) {
      field.add(RsnRadioField(
          step: jsonStep.step,
          question: jsonStep.question,
          values: jsonStep.possibileAnswers));
    } else if (jsonStep.answerType == AnswerType.date) {
      field.add(RsnDateField(step: jsonStep.step, question: jsonStep.question));
    } else if (jsonStep.answerType == AnswerType.datetime) {
      field.add(
          RsnDateTimeField(step: jsonStep.step, question: jsonStep.question));
    }
    /*
    else if (jsonStep.answerType == AnswerType.check) {
      widget Text(''));
    } else if (jsonStep.answerType == AnswerType.combo) {
      widget Text(''));
    } 
    */

    return field;
  }

  List<Step> steps(int currentStep) {
    List<Step> steps = List<Step>();
    this.currentStep = currentStep;

    jsonSteps.forEach((e) => {steps.add(nextStep(e))});
    return steps;
  }
}

class AnswerType {
  static String radio = 'radio';
  static String check = 'check';
  static String combo = 'combo';
  static String full = 'full';
  static String short = 'short';
  static String datetime = 'datetime';
  static String date = 'date';
}
