import 'package:flutter/material.dart';
import 'package:rsn_form/json/json_step.dart';
import 'package:rsn_form/utility/make_step.dart';

class RsnForm extends StatefulWidget {
  final List<JsonStep> jsonSteps;

  RsnForm(this.jsonSteps);

  @override
  _RsnFormState createState() => _RsnFormState();
}

class _RsnFormState extends State<RsnForm> with WidgetsBindingObserver {
  MakeStep makeStep;
  List<Step> steps;

  int currentStep = 0;
  bool complete = false;

  @override
  void initState() {
    makeStep = MakeStep(widget.jsonSteps);
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
    steps = makeStep.steps(context, currentStep);
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
              //onStepTapped: (step) => goTo(step),
              onStepCancel: cancel,
              //controlsBuilder: _controller(context),
            ),
          ),
        ]));
  }

/*
  ControlsWidgetBuilder _controller(BuildContext context) {
    return ControlsWidgetBuilder(context, onStepCancel: () {
      return Row(
        children: <Widget>[
          TextButton(
            onPressed: next,
            child: const Text('NEXT'),
          ),
          TextButton(
            onPressed: cancel,
            child: const Text('CANCEL'),
          ),
        ],
      );
    });
  }
*/
  void next() {
    if (currentStep + 1 > steps.length) {
      setState(() => {});
    } else {
      goTo(currentStep + 1);
    }
    //: setState(() => step.state = StepState.complete);
  }

  void cancel() {
    if (currentStep > 0) {
      goTo(currentStep - 1);
    }
  }

  void goTo(int step) {
    setState(() => currentStep = step);
  }
}
