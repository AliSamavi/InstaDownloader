import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LoginDialog extends StatefulWidget {
  const LoginDialog({super.key});

  @override
  State<LoginDialog> createState() => _LoginDialogState();
}

class _LoginDialogState extends State<LoginDialog> {
  final WebViewController controller = WebViewController()
    ..loadRequest(Uri.parse("https://www.instagram.com/accounts/login/"))
    ..setJavaScriptMode(JavaScriptMode.unrestricted);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    controller.setNavigationDelegate(
      NavigationDelegate(
        onPageFinished: (url) async {
          if (url == "https://www.instagram.com/") {
            Navigator.of(context).pop();
          }
        },
      ),
    );

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: SizedBox(
        height: size.height * 0.6,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: WebViewWidget(controller: controller),
        ),
      ),
    );
  }
}
