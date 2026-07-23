import 'package:flutter/material.dart';

class TopDrinkCard extends StatelessWidget {
  final int topDrinkMg;
  final String caffeineType;
  final int maxCaffeine;
  final int avgCaffeine;

  const TopDrinkCard({
    super.key,
    required this.topDrinkMg,
    required this.caffeineType,
    required this.maxCaffeine,
    required this.avgCaffeine,
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
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Avg Caffeine : ",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 23),
                Text(
                  "$avgCaffeine",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const Text(
              "Top Drink",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 22),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  caffeineType,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "$topDrinkMg mg",
                  style: const TextStyle(color: Colors.white70),
                ),
              ],
            ),
            const SizedBox(height: 5),

            LinearProgressIndicator(
              value: topDrinkMg / maxCaffeine,
              minHeight: 8,
              backgroundColor: Color(0xFF5B4A3E),
              valueColor: AlwaysStoppedAnimation(Color(0xFFD9B88C)),
              borderRadius: BorderRadius.circular(20),
            ),
          ],
        ),
      ),
    );
  }
}
