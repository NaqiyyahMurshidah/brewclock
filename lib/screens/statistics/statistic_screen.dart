import 'package:brewclock/widgets/statistics/period_selector.dart';
import 'package:flutter/material.dart';
import '../../widgets/statistics/stats_sum_card.dart';
import '../../widgets/statistics/top_drink_card.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  StatsPeriod _selectedPeriod = StatsPeriod.today;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1411),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: ListView(
            children: [
              //start all items in the page
              //the top title
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Statistics",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Thisss week",
                        style: TextStyle(color: Colors.white70, fontSize: 18),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.bar_chart,
                      color: Colors.white,
                      size: 80,
                    ),
                    onPressed: () {
                      // Handle settings button press
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),

              //button period cars
              PeriodSelector(
                selectedPeriod: _selectedPeriod,
                onChanged: (period) {
                  setState(() {
                    _selectedPeriod = period;
                  });
                },
              ),

              const SizedBox(height: 20),

              //stat_cum_card
              StatsSumCard(avgCaffeine: 12, avgSleepScore: 65),

              const SizedBox(height: 22),

              //caff_sleep_card.dart
              Container(height: 250, color: Colors.red.shade200),

              const SizedBox(height: 22),

              //top_drink_card
              TopDrinkCard(topDrinkMg: 78, caffeineType: "Latte", maxCaffeine: 200),
            ],
          ),
        ),
      ),
    );
  }
}
