import 'package:brewclock/navigation/main_navigation.dart';
import 'package:flutter/material.dart';
// import 'screens/home/home_screen.dart';

void main() {
  runApp(const BrewClockApp());
}

class BrewClockApp extends StatelessWidget {
  const BrewClockApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BrewClock',
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFF1A1411)),
      home: const MainNavigation(),
    );
  }
}
