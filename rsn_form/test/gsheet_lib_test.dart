import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:rsn_form/utility/gsheet_utils.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

void main() {
  var logger = Logger();
  //TestWidgetsFlutterBinding.ensureInitialized();
  const String URL =
      "https://script.google.com/macros/s/AKfycbx3KTL9YJhxUVMyU0X1UJ-ErU40B60shIlJRaCsFncJuXZvN0aJ6lhAkQ/exec";

  test('sendData to Google spreadsheet', () async {
    Map jsonAnswers = {
      "step1": "Kevin2",
      "step2": "Mohammad2",
      "step3": "2021-01-20",
      "step4": "Yes - as planned2",
      "step5": "Telephone2"
    };
    await http
        .post(Uri.parse(URL),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(jsonAnswers))
        .then((r) async {
      print(r.body);
      expect(r.statusCode, 200);
    });
  });
}
