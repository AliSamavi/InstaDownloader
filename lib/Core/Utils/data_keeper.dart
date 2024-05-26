import 'dart:io';

import 'package:webview_cookie_manager/webview_cookie_manager.dart';

class DataKeeper {
  static final DataKeeper _instance = DataKeeper._internal();
  factory DataKeeper() => _instance;
  DataKeeper._internal();

  final List<Cookie> _cookies = [];
  List<Cookie> get cookies => _cookies;

  void loadCookies() async {
    WebviewCookieManager manager = WebviewCookieManager();
    final cookie = await manager.getCookies("https://www.instagram.com");

    for (Cookie element in cookie) {
      _cookies.add(Cookie(element.name, element.value));
    }
  }
}
