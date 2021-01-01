import 'package:flutter/material.dart';
import 'package:rsn_form/json/json_step.dart';
import 'package:rsn_form/pages/rsn_form.dart';
import 'package:rsn_form/utility/make_step.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/foundation.dart';

class RsnStepper extends StatefulWidget {
  @override
  _RsnStepperState createState() => _RsnStepperState();
}

class _RsnStepperState extends State<RsnStepper> {
  bool _isButtonDisabled = true;
  MakeStep makeStep;
  List<JsonStep> jsonSteps;

  @override
  void initState() {
    super.initState();
    MakeStep.getResources(isDebug: kDebugMode)
        .then((value) => {
              setState(() {
                _isButtonDisabled = false;
                jsonSteps = value;
              })
            })
        .catchError((err) {
      /*
      final snackBar = SnackBar(
        content: Text('Error while retrieving form!'),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {},
        ),
      );
      Scaffold.of(context).showSnackBar(snackBar);
      */
    });
  }

  void _continueNavigation() {
    setState(() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => RsnForm(jsonSteps)));
    });
  }

  @override
  Widget build(BuildContext context) {
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
                    ElevatedButton(
                      child: Text('Continue'),
                      onPressed: _isButtonDisabled ? null : _continueNavigation,
                    )
                  ]);
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.lightBlueAccent,
                    ),
                  );
                }
              }
            }));
  }
}
