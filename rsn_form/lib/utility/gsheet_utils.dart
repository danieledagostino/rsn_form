import 'package:http/http.dart' as http;

class GsheetUtils {
  String _credentials;
  final String URL =
      "https://script.google.com/macros/s/AKfycbx3KTL9YJhxUVMyU0X1UJ-ErU40B60shIlJRaCsFncJuXZvN0aJ6lhAkQ/exec";

  // Success Status Message
  static const STATUS_SUCCESS = "SUCCESS";

  GsheetUtils() {}

  Future<http.Response> sendData(final data) async {
    return await http.post(URL, body: data);
  }
}
