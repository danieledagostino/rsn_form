import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:rsn_form/form_widget/full_text_field.dart';
import 'package:rsn_form/form_widget/radio_form.dart';
import 'package:rsn_form/form_widget/short_text_field.dart';
import 'package:rsn_form/json/json_step.dart';

class MakeStep {
  List<JsonStep> jsonSteps;
  int currentStep = 0;
  BuildContext context;

  MakeStep.test(final restJson) {
    try {
      jsonSteps = restJson.map<JsonStep>((m) => JsonStep.fromMap(m)).toList();
    } catch (err) {}
  }

  MakeStep();

  Future<String> getResources() async {
    final String url =
        'https://drive.google.com/uc?id=1NVLzrw72fD02AmumzTzKkg410bbs84Pt';
    var res = await http.get(url);
    if (res.statusCode == 200) {
      final restJson = json.decode(res.body);
      jsonSteps = restJson.map<JsonStep>((m) => JsonStep.fromMap(m)).toList();
      return Future.value("Data download successfully");
    } else {
      print("resource not available: " + res.statusCode.toString());
      exit(1);
    }
  }

  Step nextStep(JsonStep jsonStep, BuildContext context) {
    this.context = context;

    Step step = Step(
      title: Text(jsonStep.title),
      isActive: true,
      state: (currentStep > 1 ? StepState.disabled : StepState.editing),
      content: Column(children: _makeWidgets(jsonStep)),
    );

    this.currentStep++;
    return step;
  }

  List<Widget> _makeWidgets(JsonStep jsonStep) {
    List<Widget> widgets = List<Widget>();
    if (jsonStep.answerType == AnswerType.full) {
      FullTextField field = FullTextField(question: jsonStep.question);
      widgets.addAll(field.getWidgets());
    } else if (jsonStep.answerType == AnswerType.short) {
      ShortTextField field = ShortTextField(question: jsonStep.question);
      widgets.addAll(field.getWidgets());
    } else if (jsonStep.answerType == AnswerType.radio) {
      RadioForm radio = RadioForm(
          context: context,
          question: jsonStep.question,
          values: jsonStep.possibileAnswers);
      widgets.addAll(radio.getWidgets());
    }
    /*
    else if (jsonStep.answerType == AnswerType.check) {
      widgets.addAll(Text(''));
    } else if (jsonStep.answerType == AnswerType.combo) {
      widgets.addAll(Text(''));
    } else if (jsonStep.answerType == AnswerType.date) {
      widgets.addAll(Text(''));
    } else if (jsonStep.answerType == AnswerType.datetime) {
      widgets.addAll(Text(''));
    }
    */

    return widgets;
  }

  List<Step> steps(BuildContext context) {
    List<Step> steps = List<Step>();

    jsonSteps.forEach((e) => {steps.add(nextStep(e, context))});
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
