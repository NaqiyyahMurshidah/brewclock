// import 'package:brewclock/navigation/main_navigation.dart';
import 'package:flutter/material.dart';
import 'screens/auth/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/auth/auth_gate.dart';
// import 'screens/home/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
      home: const AuthGate(),
    );
  }
}
