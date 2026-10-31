import 'package:flutter/material.dart';

class DoneLogScreen extends StatelessWidget {
  final int caffeineMg;
  final String drinkName;

  const DoneLogScreen({
    super.key,
    required this.caffeineMg,
    required this.drinkName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1411),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            children: [
              const Spacer(),

              // Celebration icon
              Container(
                width: 95,
                height: 95,
                decoration: BoxDecoration(
                  color: const Color(0xFF3B2A20),
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFD8A15B), width: 2),
                ),
                child: const Center(
                  child: Text("🎉", style: TextStyle(fontSize: 50)),
                ),
              ),

              const SizedBox(height: 24),

              const Text(
                "Coffee Logged!",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                "$drinkName successfully logged",
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),

              const SizedBox(height: 6),

              Text(
                "$caffeineMg mg caffeine",
                style: const TextStyle(
                  color: Color(0xFFD8A15B),
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 35),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFFD8A15B),
                    side: const BorderSide(color: Color(0xFFD8A15B)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: const Text(
                    "Back to Home",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
