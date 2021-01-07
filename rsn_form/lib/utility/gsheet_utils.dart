import 'package:flutter_config/flutter_config.dart';
import 'package:http/http.dart' as http;
import 'package:rsn_form/model/answer.dart';

class GsheetUtils {
  String _URL;

  // Success Status Message
  static const STATUS_SUCCESS = "SUCCESS";

  GsheetUtils() {
    _URL = FlutterConfig.get('gsheet_url');
  }

  Future<http.Response> sendData(List<Answer> data) async {
    final jsonBody = data.map((Answer e) => e.toMap()).toList();

    return await http.post(Uri.parse(_URL),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonBody);
  }
}
