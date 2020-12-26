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
    return new Scaffold(
        appBar: AppBar(
          title: Text('RSN Form'),
        ),
        body: FutureBuilder<String>(
            future: makeStep.getResources(), // function where you call your api
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              // AsyncSnapshot<Your object type>
              if (snapshot.connectionState == ConnectionState.waiting) {
                return FutureBuilder<String>(
                    future: rootBundle.loadString('resources/disclaimer.txt'),
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      if (snapshot.hasError) {
                        return Text(snapshot.error);
                      } else {
                        if (snapshot.hasData) {
                          return Text(snapshot.data);
                        } else {
                          return Container(
                            child: Text('Loading'),
                          );
                        }
                      }
                    });
              } else {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  steps = makeStep.steps(context);
                  return Column(children: <Widget>[
                    Expanded(
                      child: Stepper(
                        steps: steps,
                        currentStep: currentStep,
                        onStepContinue: next,
                        onStepTapped: (step) => goTo(step),
                        onStepCancel: cancel,
                      ),
                    ),
                  ]);
                }
              } // snapshot.data  :- get your object which is pass from your downloadData() function
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
