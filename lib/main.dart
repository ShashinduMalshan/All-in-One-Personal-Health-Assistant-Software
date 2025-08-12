import 'package:first_01/pages/frontPage.dart';
import 'package:first_01/pages/home_Page.dart';
import 'package:first_01/pages/setting_Page.dart';
import 'package:first_01/pages/PulseWellPage.dart';
import 'package:first_01/pages/MedicalHistoryStorage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(), // <-- start here
    );
  }
}



