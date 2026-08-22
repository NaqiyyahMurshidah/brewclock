import 'package:flutter/material.dart';

class ActiveCaffeineCard extends StatelessWidget {
  final int caffeine;
  final int limit;

  const ActiveCaffeineCard({
    super.key,
    required this.caffeine,
    required this.limit,
  });

  @override
  Widget build(BuildContext context) {
    final double progress = (caffeine / limit).clamp(0.0, 1.0);

    final String level;

    if (caffeine <= limit * 0.25) {
      level = "LOW";
    } else if (caffeine <= limit * 0.60) {
      level = "MODERATE";
    } else {
      level = "HIGH";
    }

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF30261F),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Active Caffeine",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 6),

                    Text(
                      "Estimated caffeine remaining",
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    border: Border.fromBorderSide(
                      BorderSide(color: Colors.white24),
                    ),
                  ),
                  child: Text(level, style: TextStyle(color: Colors.white70)),
                ),
              ],
            ),

            const SizedBox(height: 30),

            Center(
              child: SizedBox(
                width: 190,
                height: 190,

                child: Stack(
                  alignment: Alignment.center,

                  children: [
                    SizedBox(
                      width: 180,
                      height: 180,

                      child: CircularProgressIndicator(
                        value: progress,
                        strokeWidth: 12,
                        backgroundColor: Colors.white12,
                        valueColor: AlwaysStoppedAnimation(Color(0xFFD8A15B)),
                      ),
                    ),

                    Column(
                      mainAxisSize: MainAxisSize.min,

                      children:  [
                        Text(
                          "$caffeine",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 42,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 6),

                        Text(
                          "MG ACTIVE",
                          style: TextStyle(
                            color: Colors.white70,
                            letterSpacing: 2,
                          ),
                        ),

                        SizedBox(height: 8),

                        Text(
                          level,
                          style: TextStyle(
                            color: Color(0xFFD8A15B),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
