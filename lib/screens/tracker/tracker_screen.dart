import 'package:flutter/material.dart';
import '../../widgets/tracker/active_caffeine_card.dart';
import '../../widgets/tracker/decay_curve_card.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../widgets/tracker/bedtime_forecast_card.dart';
import '../../widgets/common/page_header.dart';

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
              PageHeader(
                label: "TRACKER",
                title: "Active Caffeine",
                icon: Icons.local_cafe,
              ),

              const SizedBox(height: 24),

              //active caffeine card
              const ActiveCaffeineCard(),

              const SizedBox(height: 24),

              //decay curve chart  widgets/
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
