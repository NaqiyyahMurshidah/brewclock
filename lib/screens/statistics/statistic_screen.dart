import 'package:brewclock/widgets/statistics/period_selector.dart';
import 'package:flutter/material.dart';
import '../../widgets/statistics/top_drink_card.dart';
import '../../widgets/statistics/caff_sleep_chart_card.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../widgets/common/page_header.dart';
import '../../widgets/statistics/sleep_score_card.dart';
import '../../services/caffeine_log_store.dart';
import '../../services/statistics_service.dart';
import '../../services/sleep_log_store.dart';
import '../../models/sleep_log.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  // final sleepSpots = [
  //   FlSpot(0, 90),
  //   FlSpot(1, 92),
  //   FlSpot(2, 94),
  //   FlSpot(3, 89),
  //   FlSpot(4, 91),
  //   FlSpot(5, 93),
  //   FlSpot(6, 90),
  // ];

  StatsPeriod _selectedPeriod = StatsPeriod.today;
  @override
  Widget build(BuildContext context) {
    //get data from logs
    final coffeeLogs = CoffeeLogStore.logs;
    final sleepLogs = SleepLogStore.logs;

    //determine selected period
    final String periodName = switch (_selectedPeriod) {
      StatsPeriod.today => "today",
      StatsPeriod.week => "week",
      StatsPeriod.month => "month",
    };

    //the filter coffee logs for period
    final filteredCoffeeLogs = StatisticsService.filterLogs(
      logs: coffeeLogs,
      now: DateTime.now(),
      period: periodName,
    );
    //filter sleep log period
    final filteredSleepLogs = StatisticsService.filtersSleepLogs(
      logs: sleepLogs,
      now: DateTime.now(),
      period: periodName,
    );

    //get latest sleep log
    final SleepLog? latestSleep = filteredSleepLogs.isEmpty
        ? null
        : filteredSleepLogs.last;

    //convert latest sleep data to text
    final String bedtimeText = latestSleep == null
        ? "--"
        : TimeOfDay.fromDateTime(latestSleep.bedtime).format(context);

    final String wakeTimeText = latestSleep == null
        ? "--"
        : TimeOfDay.fromDateTime(latestSleep.wakeTime).format(context);

    final String durationText;

    if (latestSleep == null) {
      durationText = "--";
    } else {
      final hours = latestSleep.duration.inHours;

      final minutes = latestSleep.duration.inMinutes % 60;

      durationText = "${hours}h ${minutes}m";
    }

    //caffeine statistic
    final List<FlSpot> caffeineSpots = List.generate(7, (index) {
      final day = DateTime.now().subtract(Duration(days: 6 - index));

      final total = filteredCoffeeLogs
          .where(
            (log) =>
                log.consumedAt.year == day.year &&
                log.consumedAt.month == day.month &&
                log.consumedAt.day == day.day,
          )
          .fold<int>(0, (sum, log) => sum + log.caffeineMg);

      return FlSpot(index.toDouble(), total.toDouble());
    });

    final double avgCaffeine = StatisticsService.averageCaffeine(
      filteredCoffeeLogs,
    );

    final String topDrink = StatisticsService.topDrink(filteredCoffeeLogs);

    final int topDrinkMg = StatisticsService.topDrinkCaffeine(
      filteredCoffeeLogs,
      topDrink,
    );

    //sleepspot for statistic chart
    final List<FlSpot> sleepSpots = List.generate(7, (index) {
      final DateTime day = DateTime.now().subtract(Duration(days: 6 - index));

      final daySleepLogs = filteredSleepLogs.where((log) {
        return log.wakeTime.year == day.year &&
            log.wakeTime.month == day.month &&
            log.wakeTime.day == day.day;
      }).toList();

      // No sleep log for this day
      if (daySleepLogs.isEmpty) {
        return FlSpot(index.toDouble(), 0);
      }

      final sleepLog = daySleepLogs.last;

      final double sleepHours = sleepLog.duration.inMinutes / 60.0;

      return FlSpot(index.toDouble(), sleepHours);
    });

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
                score: 98, //need ML
                quality: "Deeply Restful", // need ML
                bedtime: bedtimeText,
                wakeTime: wakeTimeText,
                duration: durationText,
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
