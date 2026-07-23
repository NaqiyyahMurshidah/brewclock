import 'package:flutter/material.dart';

class CafeLogCoffee extends StatelessWidget {
  const CafeLogCoffee({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1411),
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text("Log Coffee", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF1A1411),
      ),
      body: const Center(
        child: Text("cafe add Coffee Page", style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
