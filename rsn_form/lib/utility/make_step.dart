import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:rsn_form/form_widget/date_field.dart';
import 'package:rsn_form/form_widget/full_text_field.dart';
import 'package:rsn_form/form_widget/radio_form.dart';
import 'package:rsn_form/form_widget/short_text_field.dart';
import 'package:rsn_form/json/json_step.dart';
import 'package:logger/logger.dart';

class MakeStep {
  List<JsonStep> jsonSteps;
  int currentStep = 0;
  DateTimeField dateTimeField;

  static var logger = Logger();

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
          .loadString('resources/widget_conf.json')
          .then((value) => jsonContent = value)
          .catchError(
              (error) => {logger.e('Exception during widget_conf.json')});
    } else {
      final String url =
          'https://drive.google.com/uc?id=1NVLzrw72fD02AmumzTzKkg410bbs84Pt';
      var res = await http.get(url);
      if (res.statusCode == 200) {
        jsonContent = res.body;
      } else {
        print("resource not available: " + res.statusCode.toString());
        exit(1);
      }
    }

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

    this.currentStep++;
    return step;
  }

  StepState getSepState(JsonStep jsonStep, int currentStep) {
    if (jsonStep.step - 1 < currentStep) {
      return StepState.complete;
    } else if (jsonStep.step == currentStep) {
      return StepState.editing;
    } else {
      return StepState.disabled;
    }
  }

  List<Widget> _makeWidget(JsonStep jsonStep) {
    List<Widget> field = List<Widget>();
    if (jsonStep.answerType == AnswerType.full) {
      field.add(FullTextField(question: jsonStep.question));
    } else if (jsonStep.answerType == AnswerType.short) {
      field.add(ShortTextField(question: jsonStep.question));
    } else if (jsonStep.answerType == AnswerType.radio) {
      field.add(RadioForm(
          question: jsonStep.question, values: jsonStep.possibileAnswers));
    } else if (jsonStep.answerType == AnswerType.date) {
      field.add(DateField(question: jsonStep.question));
    }
    /*
    else if (jsonStep.answerType == AnswerType.check) {
      widget Text(''));
    } else if (jsonStep.answerType == AnswerType.combo) {
      widget Text(''));
    } else if (jsonStep.answerType == AnswerType.datetime) {
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
