import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:rsn_form/model/answer.dart';
import 'package:rsn_form/utility/gsheet_utils.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:path/path.dart';
import 'package:rsn_form/environment_config.dart';

void main() {
  //TestWidgetsFlutterBinding.ensureInitialized();

  test('sendData to Google spreadsheet', () async {
    String URL = EnvironmentConfig.GSHEET_URL;
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
      debugPrint(r.body);
      expect(r.statusCode, 200);
    });
  });

  test('GsheetUtil test', () async {
    TestWidgetsFlutterBinding.ensureInitialized();

    rootBundle
        .loadString(join('test_resources', 'widget_form_test.json'))
        .then((value) {
      List<Answer> list = json.decode(value).map((e) {
        final answer = Answer.fromMap(e.value);
        return answer;
      }).toList();
      GsheetUtils util = GsheetUtils();

      util.sendData(list).then((value) {
        if (value.statusCode == GsheetUtils.STATUS_SUCCESS) {
          debugPrint('data sent');
        }
      });
    });
  });
}
