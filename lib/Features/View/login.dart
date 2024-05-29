import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final WebViewController _controller = WebViewController()
    ..loadRequest(Uri.parse("https://www.instagram.com/accounts/login/"))
    ..setJavaScriptMode(JavaScriptMode.unrestricted);

  @override
  Widget build(BuildContext context) {
    _controller.setNavigationDelegate(
      NavigationDelegate(
        onPageStarted: (url) async {
          if (url == "https://www.instagram.com/" ||
              url.contains("accounts/onetap/")) {
            await _controller.clearCache();
            await _controller.clearLocalStorage();
            Navigator.of(context).pop();
          }
        },
      ),
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: WebViewWidget(controller: _controller),
      ),
    );
  }
}
