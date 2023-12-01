import 'package:InstaDownloader/bloc/switch_bloc.dart';
import 'package:InstaDownloader/views/screens/download.dart';
import 'package:InstaDownloader/views/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SwitchBloc(),
        ),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.mulishTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: Scaffold(
        backgroundColor: const Color(0xFF140F2D),
        appBar: AppBar(
          backgroundColor: const Color(0xFF140F2D),
          elevation: 0,
        ),
        body: const Stack(
          children: [
            HomeScreen(),
            DownloadsScreen(),
          ],
        ),
      ),
    );
  }
}
