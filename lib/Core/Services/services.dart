import 'dart:convert';

import 'package:http/http.dart' as http;

class Services {
  static Future<Map<String, dynamic>?> get(
    String url,
    Map<String, String> headers,
  ) async {
    http.Response re = await http.get(Uri.parse(url), headers: headers);

    if (re.statusCode == 200) {
      return jsonDecode(re.body);
    }

    return null;
  }
}
