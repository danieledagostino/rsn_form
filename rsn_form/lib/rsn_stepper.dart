import 'package:flutter/material.dart';
import 'package:rsn_form/utility/make_step.dart';

class RsnStepper extends StatefulWidget {
  static _RsnStepperState of(BuildContext context) =>
      context.findAncestorStateOfType<_RsnStepperState>();

  @override
  _RsnStepperState createState() => _RsnStepperState();
}

class _RsnStepperState extends State<RsnStepper> with WidgetsBindingObserver {
  MakeStep makeStep;
  List<Step> steps;

  int currentStep = 0;
  bool complete = false;

  @override
  void initState() {
    makeStep = MakeStep();

    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached) {}
  }

  @override
  Widget build(BuildContext context) {
    steps = makeStep.steps(context);
    return new Scaffold(
        appBar: AppBar(
          title: Text('RSN Form'),
        ),
        body: Column(children: <Widget>[
          Expanded(
            child: Stepper(
              steps: steps,
              currentStep: currentStep,
              onStepContinue: next,
              onStepTapped: (step) => goTo(step),
              onStepCancel: cancel,
            ),
          ),
        ]));
  }

  next() {
    currentStep + 1 != steps.length
        ? goTo(currentStep + 1)
        : setState(() => complete = true);
  }

  cancel() {
    if (currentStep > 0) {
      goTo(currentStep - 1);
    }
  }

  goTo(int step) {
    setState(() => currentStep = step);
  }
}
