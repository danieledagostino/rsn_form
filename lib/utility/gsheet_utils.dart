import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rsn_form/model/answer.dart';
import 'package:rsn_form/environment_config.dart';

class GsheetUtils {
  String _URL;

  // Success Status Message
  static const STATUS_SUCCESS = "SUCCESS";

  GsheetUtils() {
    _URL = EnvironmentConfig.GSHEET_URL;
  }

  Future<http.Response> sendData(List<Answer> data) async {
    final jsonBody = data.map((Answer e) => e.toMap()).toList();

    return await http.post(Uri.parse(_URL),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(jsonBody));
  }
}
