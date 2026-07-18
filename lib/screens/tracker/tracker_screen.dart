import 'package:flutter/material.dart';
import '../../widgets/caffeine/active_caffeine_card.dart';
import '../../widgets/caffeine/decay_curve_card.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../widgets/caffeine/bedtime_forecast_card.dart';

class TrackerScreen extends StatelessWidget {
  const TrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1411),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Tracker",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Active Cafeine",
                        style: TextStyle(color: Colors.white70, fontSize: 18),
                      ),
                    ],
                  ),

                  IconButton(
                    icon: const Icon(
                      Icons.local_cafe,
                      color: Colors.white,
                      size: 80,
                    ),
                    onPressed: () {
                      // Handle settings button press
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),

              //active caffeine card
              const ActiveCaffeineCard(),

              const SizedBox(height: 24),

              //decay curve chart dummy
              DecayCurveCard(
                spots: [
                  FlSpot(0, 65),
                  FlSpot(1, 55),
                  FlSpot(2, 42),
                  FlSpot(3, 30),
                  FlSpot(4, 20),
                  FlSpot(5, 12),
                  FlSpot(6, 6),
                ],
              ),
              const SizedBox(height: 24),

              //bedtime forecast card
              BedtimeForecastCard(caffeineLeft: 12, bedTime: "10:30 PM"),
            ],
          ),
        ),
      ),
    );
  }
}
