import 'package:flutter/material.dart';
import 'package:rsn_form/utility/make_step.dart';
import 'package:flutter/services.dart' show rootBundle;

class RsnStepper extends StatefulWidget {
  static _RsnStepperState of(BuildContext context) =>
      context.findAncestorStateOfType<_RsnStepperState>();

  @override
  _RsnStepperState createState() => _RsnStepperState();
}

class _RsnStepperState extends State<RsnStepper> with WidgetsBindingObserver {
  MakeStep makeStep;
  List<Step> steps;
  bool _isButtonDisabled = true;

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

  void _continueNavigation() {
    setState(() {
      steps = makeStep.steps(context);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Column(children: <Widget>[
                    Expanded(
                      child: Stepper(
                        steps: steps,
                        currentStep: currentStep,
                        onStepContinue: next,
                        onStepTapped: (step) => goTo(step),
                        onStepCancel: cancel,
                      ),
                    ),
                  ])));
    });
  }

  @override
  Widget build(BuildContext context) {
    makeStep
        .getResources()
        .then((value) => {setState(() => _isButtonDisabled = false)});

    return new Scaffold(
        appBar: AppBar(
          title: Text('RSN Form'),
        ),
        body: FutureBuilder<String>(
            future: rootBundle.loadString('resources/disclaimer.txt'),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.hasError) {
                return Text(snapshot.error);
              } else {
                if (snapshot.hasData) {
                  return Column(children: [
                    Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(snapshot.data,
                            style: TextStyle(fontSize: 18))),
                    FlatButton(
                      child: Text('Continue'),
                      onPressed: _isButtonDisabled ? null : _continueNavigation,
                    )
                  ]);
                }
              }
            }));
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
