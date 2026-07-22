import 'package:flutter/material.dart';
import '../../widgets/profile/profile_page.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, 
      home: Scaffold(
        appBar: AppBar(
          title: const Text('My Profile'),
          backgroundColor: const Color(0xFF3B2A20),
          elevation: 0,
        ),
        body: const ProfilePage(),
        ),
      );
  }
}
