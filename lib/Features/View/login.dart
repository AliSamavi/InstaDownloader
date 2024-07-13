import 'package:InstaDownloader/Core/Utils/data_keeper.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final WebViewController _controller = WebViewController()
    ..loadRequest(Uri.parse("https://www.instagram.com/accounts/login/"))
    ..setJavaScriptMode(JavaScriptMode.unrestricted);

  @override
  void initState() {
    _controller.setNavigationDelegate(
      NavigationDelegate(
        onPageStarted: (url) {
          if (url == "https://www.instagram.com/" ||
              url.startsWith("https://www.instagram.com/accounts/onetap/")) {
            DataKeeper().loadCookies();
            Navigator.of(context).pop();
          }
        },
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.clearCache();
    _controller.clearLocalStorage();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: WebViewWidget(controller: _controller),
      ),
    );
  }
}
