import 'package:flutter/material.dart';
import 'package:toonflix/toon/screen/home_screen.dart';
import 'package:toonflix/toon/services/ApiService.dart';

void main() {
  ApiService().getTodaysToons();
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
