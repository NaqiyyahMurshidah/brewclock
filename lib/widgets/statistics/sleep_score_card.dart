import 'package:flutter/material.dart';

class SleepScoreCard extends StatelessWidget {
  final int score;
  final String quality;
  final String bedtime;
  final String wakeTime;
  final String duration;
  final bool isExpanded;

  const SleepScoreCard({
    super.key,
    required this.score,
    required this.quality,
    required this.bedtime,
    required this.wakeTime,
    required this.duration,
    this.isExpanded = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: const Color(0xFF3B2A20),
        borderRadius: BorderRadius.circular(24),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //title
          const Text(
            "Quality Score",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 5),

          // score + icon
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "$score",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(width: 6),

                        const Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text(
                            "/100",
                            style: TextStyle(color: Colors.grey, fontSize: 26),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                  color: Color(0xFF4A3528),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Icon(Icons.bed, color: Color(0xFFD8B17B), size: 32),
              ),
            ],
          ),

          //expanded mode
          if (isExpanded) ...[
            //star
            const SizedBox(height: 8),

            const Row(
              children: [
                Icon(Icons.star, color: Color(0xFFD8B17B), size: 24),
                Icon(Icons.star, color: Color(0xFFD8B17B), size: 24),
                Icon(Icons.star, color: Color(0xFFD8B17B), size: 24),
                Icon(Icons.star, color: Color(0xFFD8B17B), size: 24),
                Icon(Icons.star_half, color: Color(0xFFD8B17B), size: 24),
              ],
            ),

            const SizedBox(height: 10),

            Text(
              quality,
              style: const TextStyle(color: Colors.white70, fontSize: 18),
            ),

            const SizedBox(height: 28),

            Row(
              children: [
                Expanded(
                  child: _InfoBox(title: "BEDTIME", value: bedtime),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _InfoBox(title: "WAKE", value: wakeTime),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _InfoBox(title: "DURATION", value: duration),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _InfoBox extends StatelessWidget {
  final String title;
  final String value;

  const _InfoBox({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 82,
      decoration: BoxDecoration(
        color: const Color(0xFF4A3528),
        borderRadius: BorderRadius.circular(18),
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.white54, fontSize: 11),
          ),

          const SizedBox(height: 6),

          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
