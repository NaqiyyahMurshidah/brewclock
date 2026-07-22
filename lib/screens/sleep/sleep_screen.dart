import 'package:flutter/material.dart';
import '../../widgets/sleep/sleep_score_card.dart';
import '../../widgets/sleep/sleep_chart_card.dart';
import '../../widgets/common/page_header.dart';

class SleepScreen extends StatelessWidget {
  const SleepScreen({super.key});

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
                label: "SLEEP INSIGHTS",
                title: "Tonight's Forecast",
                icon: Icons.bedtime,
              ),

              const SizedBox(height: 24),

              // Sleep Score Card
              SleepScoreCard(
                score: 98,
                quality: "Deeply Restful",
                bedtime: "11:00 PM",
                wakeTime: "7:00 AM",
                duration: "8h",
                isExpanded: true,
              ),

              const SizedBox(height: 20),

              // Chart card
              SleepChartCard(),

              const SizedBox(height: 20),

              // Another Card
              Container(height: 250, color: Colors.green),

              const SizedBox(height: 20),

              // Another Card
              Container(height: 250, color: Colors.green),

              const SizedBox(height: 20),

              // Another Card
              Container(height: 250, color: Colors.green),
            ],
          ),
        ),
      ),
    );
  }
}
