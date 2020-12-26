import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'dart:convert';
import 'dart:io';

import 'package:rsn_form/utility/make_step.dart';

void main() {
  test('make widgets from json configuration', () {
    final file = new File('./test_resources/widget_conf.json');
    Future<String> decodedJson = file.readAsString();
    decodedJson.then((value) {
      final restJson = json.decode(value);

      MakeStep makeStep = MakeStep.test(restJson);

      List<Step> steps = makeStep.steps(null);
    });
  });
}
