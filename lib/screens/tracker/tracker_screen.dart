import 'package:flutter/material.dart';
import '../../widgets/tracker/active_caffeine_card.dart';
import '../../widgets/tracker/decay_curve_card.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../widgets/tracker/bedtime_forecast_card.dart';
import '../../widgets/common/page_header.dart';
import '../../services/caffeine/active_caffeine_calc.dart';
import '../../services/caffeine/caffeine_log_store.dart';

class TrackerScreen extends StatelessWidget {
  const TrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final logs = CoffeeLogStore.logs;

    final DateTime now = DateTime.now();

    final double activeCaffeine =
        ActiveCaffeineCalc.calculateTotalActivateCaffeine(logs: logs, now: now);

    final List<FlSpot> decaySpots = ActiveCaffeineCalc.generateDecayCurve(
      logs: logs,
      startTime: now,
      hoursToShow: 12,
    );

    return Scaffold(
      backgroundColor: const Color(0xFF1A1411),
      body: SafeArea(
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(overscroll: false),
          child: ListView(
            padding: const EdgeInsets.all(24),
            physics: ClampingScrollPhysics(),

            children: [
              PageHeader(
                label: "TRACKER",
                title: "Active Caffeine",
                icon: Icons.local_cafe,
              ),

              const SizedBox(height: 24),

              //active caffeine card
              ActiveCaffeineCard(caffeine: activeCaffeine.round(), limit: 400),

              const SizedBox(height: 24),

              //decay curve chart  widgets/tracker
              DecayCurveCard(spots: decaySpots, startTime: now),
              const SizedBox(height: 24),

              //bedtime forecast card widgets/tracker
              BedtimeForecastCard(caffeineLeft: 12, bedTime: "10:30 PM"),
            ],
          ),
        ),
      ),
    );
  }
}
