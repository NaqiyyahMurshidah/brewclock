import 'package:flutter/material.dart';

class BedtimeForecastCard extends StatelessWidget {
  final int caffeineLeft; //caffeine amount left in the body
  final String bedTime;

  const BedtimeForecastCard({
    super.key,
    required this.caffeineLeft,
    required this.bedTime,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF3A291F),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Bedtime Forecast",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                "$caffeineLeft mg",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 34,
                  fontWeight: FontWeight(30),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                "still active at $bedTime",
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          // icon
          Container(
            width: 60,
            height: 60,
            decoration: const BoxDecoration(
              color: Color(0xFF4A3528),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.bed, color: Color(0xFFD8B17B), size: 34),
          ),
        ],
      ),
    );
  }
}
