import 'package:InstaDownloader/Core/Themes/themes.dart';
import 'package:InstaDownloader/Core/Utils/data_keeper.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DataKeeper().loadCookies();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Themes.primary,
      home: const Scaffold(
        body: Center(
          child: Text("Hello World!"),
        ),
      ),
    );
  }
}
