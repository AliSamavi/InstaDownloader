import 'dart:convert';
import 'dart:io';

class Services {
  static Future<Map<String, dynamic>?> get(
    String url,
    List<Cookie> cookies,
  ) async {
    try {
      HttpClient client = HttpClient();
      HttpClientRequest req = await client.getUrl(Uri.parse(url));

      req.cookies.addAll(cookies);

      HttpClientResponse res = await req.close();

      if (res.statusCode == 200) {
        String json = await res.transform(utf8.decoder).join();
        return jsonDecode(json);
      }
    } catch (e) {
      return null;
    }

    return null;
  }
}
