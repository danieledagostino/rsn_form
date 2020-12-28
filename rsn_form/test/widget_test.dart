import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';

import 'dart:convert';

import 'package:rsn_form/utility/make_step.dart';
import 'package:flutter/services.dart' show rootBundle;

void main() {
  var logger = Logger();

  Future<String> getFileAsString(String path) async {
    return await rootBundle.loadString(path);
  }

  test('make widgets from json configuration', () {
    getFileAsString('test_resources/widget_conf.json').then((value) {
      final restJson = json.decode(value);

      MakeStep makeStep = MakeStep.test(restJson);

      List<Step> steps = makeStep.steps(null, 0);
      logger.d(steps);

      expect(12, steps.length);
    });
  });
}
