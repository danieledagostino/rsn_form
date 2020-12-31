import 'package:flutter/material.dart';
import 'package:rsn_form/json/json_step.dart';
import 'package:rsn_form/utility/make_step.dart';

class RsnForm extends StatefulWidget {
  final List<JsonStep> jsonSteps;

  RsnForm(this.jsonSteps);

  @override
  _RsnFormState createState() => _RsnFormState();
}

class _RsnFormState extends State<RsnForm> {
  MakeStep makeStep;
  List<Step> steps;

  int currentStep = 0;
  bool complete = false;

  @override
  void initState() {
    makeStep = MakeStep(widget.jsonSteps);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    steps = makeStep.steps(currentStep);
    return new Scaffold(
        appBar: AppBar(
          title: Text('RSN Form'),
        ),
        body: Expanded(
          child: Stepper(
            steps: steps,
            currentStep: currentStep,
            onStepContinue: next,
            //onStepTapped: (step) => goTo(step),
            onStepCancel: cancel,
            controlsBuilder: (BuildContext context,
                {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
              return Row(children: getButtons());
            },
          ),
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

  void end() {}

  void next() {
    //steps[currentStep].content
    //Provider.of<DateField>(context).update(null);
    goTo(currentStep + 1);
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
