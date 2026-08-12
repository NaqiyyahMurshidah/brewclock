import 'package:brewclock/models/sleep_log.dart';
import 'package:brewclock/widgets/statistics/period_selector.dart';
import 'package:flutter/material.dart';
import '../../widgets/statistics/top_drink_card.dart';
import '../../widgets/statistics/caff_sleep_chart_card.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../widgets/common/page_header.dart';
import '../../widgets/statistics/sleep_score_card.dart';
import '../../services/caffeine_log_store.dart';
import '../../services/statistics_service.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  final sleepSpots = [
    FlSpot(0, 90),
    FlSpot(1, 92),
    FlSpot(2, 94),
    FlSpot(3, 89),
    FlSpot(4, 91),
    FlSpot(5, 93),
    FlSpot(6, 90),
  ];

  StatsPeriod _selectedPeriod = StatsPeriod.today;
  @override
  Widget build(BuildContext context) {
    final coffeeLogs = CoffeeLogStore.logs;

    final String periodName = switch (_selectedPeriod) {
      StatsPeriod.today => "today",
      StatsPeriod.week => "week",
      StatsPeriod.month => "month",
    };

    //the filter for period
    final filteredLogs = StatisticsService.filterLogs(
      logs: coffeeLogs,
      now: DateTime.now(),
      period: periodName,
    );

    final List<FlSpot> caffeineSpots = List.generate(7, (index) {
      final day = DateTime.now().subtract(Duration(days: 6 - index));

      final total = filteredLogs
          .where(
            (log) =>
                log.consumedAt.year == day.year &&
                log.consumedAt.month == day.month &&
                log.consumedAt.day == day.day,
          )
          .fold<int>(0, (sum, log) => sum + log.caffeineMg);

      return FlSpot(index.toDouble(), total.toDouble());
    });

    final double avgCaffeine = StatisticsService.averageCaffeine(filteredLogs);

    final String topDrink = StatisticsService.topDrink(filteredLogs);

    final int topDrinkMg = StatisticsService.topDrinkCaffeine(
      filteredLogs,
      topDrink,
    );

    return Scaffold(
      backgroundColor: const Color(0xFF1A1411),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: ListView(
            children: [
              //start all items in the page
              //the top title
              PageHeader(
                label: "STATISTICS",
                title: "Sleep and Caffeine statistic",
                icon: Icons.bar_chart_outlined,
              ),

              const SizedBox(height: 10),

              //button period widget/statistics/period_selector.dart
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
              // StatsSumCard(avgCaffeine: 12, avgSleepScore: 65),

              // quality score card widget/
              const SizedBox(height: 22),
              SleepScoreCard(
                score: 98,
                quality: "Deeply Restful",
                bedtime: "11:00 PM",
                wakeTime: "7:00 AM",
                duration: "8h",
                isExpanded: true,
              ),

              //caffeine average card
              const SizedBox(height: 20),

              //top_drink_card
              TopDrinkCard(
                topDrinkMg: topDrinkMg,
                caffeineType: topDrink,
                maxCaffeine: 200,
                avgCaffeine: avgCaffeine.round(),
              ),

              const SizedBox(height: 22),

              //caff_sleep_card.dart
              CaffSleepChartCard(
                caffeineSpots: caffeineSpots,
                sleepSpots: sleepSpots,
              ),

              const SizedBox(height: 22),
            ],
          ),
        ),
      ),
    );
  }
}
