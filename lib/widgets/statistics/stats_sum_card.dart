import 'package:flutter/material.dart';

class StatsSumCard extends StatelessWidget {
  final int avgCaffeine; //caffeine amount in the body
  final int avgSleepScore; //limit input from user

  const StatsSumCard({
    super.key,
    required this.avgCaffeine,
    required this.avgSleepScore,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(6),
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: _sumbox(title: "AVG CAFFEINE", value: "$avgCaffeine mg"),
          ),
          const SizedBox(width: 17),
           Expanded(
            child: _sumbox(title: "AVG SLEEP SCORE", value: "$avgSleepScore"),
          ),
        ],
      ),
    );
  }

  Widget _sumbox({required String title, required String value}) {
    return Container(
      height: 80,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xFF3A291F),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 3),

            Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),

        ],
      ),
    );
  }
}
