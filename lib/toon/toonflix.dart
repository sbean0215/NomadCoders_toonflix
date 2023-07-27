import 'dart:io';

import 'package:flutter/material.dart';
import 'package:toonflix/toon/screen/home_screen.dart';
import 'package:toonflix/toon/services/MyHttpOverrides.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}
