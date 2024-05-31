import 'dart:convert';
import 'dart:io';

class Services {
  static Future<Map<String, dynamic>> get(
    String url,
    List<Cookie> cookies,
  ) async {
    HttpClient client = HttpClient();

    try {
      HttpClientRequest req = await client.getUrl(Uri.parse(url));
      req.cookies.addAll(cookies);
      HttpClientResponse res = await req.close();

      String json = await res.transform(utf8.decoder).join();
      return jsonDecode(json);
    } on SocketException {
      return {"error": "connection"};
    } catch (e) {
      return {"error": "login"};
    }
  }
}
