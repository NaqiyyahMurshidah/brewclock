import 'package:brewclock/widgets/statistics/period_selector.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../models/coffee_log.dart';
import '../../models/sleep_log.dart';

import '../../widgets/statistics/top_drink_card.dart';
import '../../widgets/statistics/caff_sleep_chart_card.dart';
import '../../widgets/common/page_header.dart';
import '../../widgets/statistics/sleep_score_card.dart';

import '../../services/statistics_service.dart';
import '../../services/sleep/sleep_log_store.dart';
import '../../services/firestore/coffee_firestore_service.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  StatsPeriod _selectedPeriod = StatsPeriod.today;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<CaffeineLog>>(
      stream: CoffeeFirestoreService.getCoffeeLogs(),

      builder: (context, coffeeSnapshot) {
        if (coffeeSnapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            backgroundColor: Color(0xFF1A1411),
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (coffeeSnapshot.hasError) {
          return const Scaffold(
            backgroundColor: Color(0xFF1A1411),
            body: Center(
              child: Text(
                "Failed to load statistics",
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        }

        // =========================================
        // COFFEE LOGS FROM FIRESTORE
        // =========================================

        final List<CaffeineLog> coffeeLogs = coffeeSnapshot.data ?? [];

        // Sleep is still local for now
        final List<SleepLog> sleepLogs = SleepLogStore.logs;

        final DateTime now = DateTime.now();

        // =========================================
        // SELECTED PERIOD
        // =========================================

        final String periodName = switch (_selectedPeriod) {
          StatsPeriod.today => "today",
          StatsPeriod.week => "week",
          StatsPeriod.month => "month",
        };

        // =========================================
        // FILTER COFFEE LOGS
        // =========================================

        final filteredCoffeeLogs = StatisticsService.filterLogs(
          logs: coffeeLogs,
          now: now,
          period: periodName,
        );

        // =========================================
        // FILTER SLEEP LOGS
        // =========================================

        final filteredSleepLogs = StatisticsService.filtersSleepLogs(
          logs: sleepLogs,
          now: now,
          period: periodName,
        );

        // =========================================
        // LATEST SLEEP
        // =========================================

        final SleepLog? latestSleep = filteredSleepLogs.isEmpty
            ? null
            : filteredSleepLogs.last;

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
          final int hours = latestSleep.duration.inHours;

          final int minutes = latestSleep.duration.inMinutes % 60;

          durationText = "${hours}h ${minutes}m";
        }

        // =========================================
        // CAFFEINE CHART
        // =========================================

        final List<FlSpot> caffeineSpots = List.generate(7, (index) {
          final DateTime day = now.subtract(Duration(days: 6 - index));

          final int total = filteredCoffeeLogs
              .where(
                (log) =>
                    log.consumedAt.year == day.year &&
                    log.consumedAt.month == day.month &&
                    log.consumedAt.day == day.day,
              )
              .fold<int>(0, (sum, log) => sum + log.caffeineMg);

          return FlSpot(index.toDouble(), total.toDouble());
        });

        // =========================================
        // AVERAGE CAFFEINE
        // =========================================

        final double avgCaffeine = StatisticsService.averageCaffeine(
          filteredCoffeeLogs,
        );

        // =========================================
        // TOP DRINK
        // =========================================

        final String topDrink = StatisticsService.topDrink(filteredCoffeeLogs);

        final int topDrinkMg = StatisticsService.topDrinkCaffeine(
          filteredCoffeeLogs,
          topDrink,
        );

        // =========================================
        // SLEEP CHART
        // =========================================

        final List<FlSpot> sleepSpots = List.generate(7, (index) {
          final DateTime day = now.subtract(Duration(days: 6 - index));

          final daySleepLogs = filteredSleepLogs.where((log) {
            return log.wakeTime.year == day.year &&
                log.wakeTime.month == day.month &&
                log.wakeTime.day == day.day;
          }).toList();

          if (daySleepLogs.isEmpty) {
            return FlSpot(index.toDouble(), 0);
          }

          final SleepLog sleepLog = daySleepLogs.last;

          final double sleepHours = sleepLog.duration.inMinutes / 60.0;

          return FlSpot(index.toDouble(), sleepHours);
        });

        // =========================================
        // UI
        // =========================================

        return Scaffold(
          backgroundColor: const Color(0xFF1A1411),

          body: SafeArea(
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(
                context,
              ).copyWith(overscroll: false),

              child: ListView(
                padding: const EdgeInsets.all(24),

                physics: const ClampingScrollPhysics(),

                children: [
                  const PageHeader(
                    label: "STATISTICS",
                    title: "Sleep and Caffeine statistic",
                    icon: Icons.bar_chart_outlined,
                  ),

                  const SizedBox(height: 10),

                  PeriodSelector(
                    selectedPeriod: _selectedPeriod,

                    onChanged: (period) {
                      setState(() {
                        _selectedPeriod = period;
                      });
                    },
                  ),

                  const SizedBox(height: 20),

                  const SizedBox(height: 22),

                  SleepScoreCard(
                    score: 98,
                    quality: "Deeply Restful",

                    bedtime: bedtimeText,

                    wakeTime: wakeTimeText,

                    duration: durationText,

                    isExpanded: true,
                  ),

                  const SizedBox(height: 20),

                  TopDrinkCard(
                    topDrinkMg: topDrinkMg,

                    caffeineType: topDrink,

                    maxCaffeine: 200,

                    avgCaffeine: avgCaffeine.round(),
                  ),

                  const SizedBox(height: 22),

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
      },
    );
  }
}
