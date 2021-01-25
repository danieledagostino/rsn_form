import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rsn_form/dao/init.dart';
import 'package:rsn_form/json/json_step.dart';
import 'package:rsn_form/pages/rsn_app_bar.dart';
import 'package:rsn_form/pages/rsn_drawer.dart';
import 'package:rsn_form/pages/rsn_form.dart';
import 'package:rsn_form/utility/make_step.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';

class RsnStepper extends StatefulWidget {
  @override
  _RsnStepperState createState() => _RsnStepperState();
}

class _RsnStepperState extends State<RsnStepper> {
  bool _isButtonDisabled = true;
  MakeStep makeStep;
  List<JsonStep> jsonSteps;
  BuildContext buildContext;
  String _infoText;

  @override
  void initState() {
    super.initState();
    _infoText = 'Form loading...';
    MakeStep.getResources(isDebug: kDebugMode)
        .then((value) => {
              setState(() {
                _isButtonDisabled = false;
                jsonSteps = value;
              })
            })
        .catchError((err) {
      _infoText = err.toString();
      stderr.writeln(err.toString());
    });
  }

  void _continueNavigation() {
    setState(() {
      Navigator.push(buildContext, MaterialPageRoute(builder: (context) {
        return FutureBuilder<dynamic>(
            future: Init.initialize(), //dao.findByStep(this.step),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return RsnForm(jsonSteps);
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.lightBlueAccent,
                  ),
                );
              }
            });
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    buildContext = context;
    return new Scaffold(
        appBar: RsnAppBar('RSN disclaimer'),
        body: FutureBuilder<String>(
            future: rootBundle.loadString(join('resources', 'disclaimer.txt')),
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
                    (_isButtonDisabled
                        ? Text(_infoText)
                        : ElevatedButton(
                            child: Text('Continue'),
                            onPressed: _continueNavigation,
                          ))
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
