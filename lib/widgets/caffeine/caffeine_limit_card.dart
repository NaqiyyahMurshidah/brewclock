import 'package:flutter/material.dart';

class CaffeineLimitCard extends StatelessWidget {
  final int caffeine; //caffeine amount in the body
  final int limit; //limit input from user

  const CaffeineLimitCard({
    super.key,
    required this.caffeine,
    required this.limit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF3A291F),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Caffeine Limit",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "${caffeine.toInt()}/${limit.toInt()} mg",
                  style: const TextStyle(color: Colors.white70),
                ),
              ],
            ),
            const SizedBox(height: 14),

            LinearProgressIndicator(
              value: caffeine / limit,
              minHeight: 8,
              backgroundColor: Color(0xFF5B4A3E),
              valueColor: AlwaysStoppedAnimation(Color(0xFFD9B88C)),
              borderRadius: BorderRadius.circular(20),
            ),

            const SizedBox(height: 14),

            const Text(
              "Reminder: Stop caffeine 8h before bedtime for best sleep.",
              style: TextStyle(color: Colors.white54, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
