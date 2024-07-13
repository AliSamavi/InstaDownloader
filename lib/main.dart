import 'package:InstaDownloader/Core/Themes/themes.dart';
import 'package:InstaDownloader/Core/Utils/data_keeper.dart';
import 'package:InstaDownloader/Features/Model/downloaded_model.dart';
import 'package:InstaDownloader/Features/View/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(DownloadedModelAdapter());
  await FlutterDownloader.initialize();
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
      title: "Insta Downloader",
      home: const HomeView(),
    );
  }
}
