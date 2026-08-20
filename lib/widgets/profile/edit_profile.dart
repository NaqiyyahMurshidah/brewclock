import 'package:flutter/material.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        backgroundColor: const Color(0xFF3B2A20),
      ),
      body: const Center(
        child: Text(
          'This is the edit profile screen. You can add form fields here to edit user information.',
          style: TextStyle(fontSize: 18),
         ),
        ),
      );
  }
}