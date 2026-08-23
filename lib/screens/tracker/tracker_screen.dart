import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../models/coffee_log.dart';

import '../../widgets/tracker/active_caffeine_card.dart';
import '../../widgets/tracker/decay_curve_card.dart';
import '../../widgets/tracker/bedtime_forecast_card.dart';
import '../../widgets/common/page_header.dart';

import '../../services/caffeine/active_caffeine_calc.dart';
import '../../services/firestore/coffee_firestore_service.dart';
import '../../services/firestore/user_profile_service.dart';

class TrackerScreen extends StatelessWidget {
  const TrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<CaffeineLog>>(
      // Get coffee logs from Firestore
      stream: CoffeeFirestoreService.getCoffeeLogs(),

      builder: (context, coffeeSnapshot) {
        // While Firestore is loading
        if (coffeeSnapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            backgroundColor: Color(0xFF1A1411),
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // If Firestore has an error
        if (coffeeSnapshot.hasError) {
          return const Scaffold(
            backgroundColor: Color(0xFF1A1411),
            body: Center(
              child: Text(
                "Failed to load coffee logs",
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        }

        // These logs now come from Firestore
        final List<CaffeineLog> logs = coffeeSnapshot.data ?? [];

        final DateTime now = DateTime.now();

        // Calculate active caffeine
        final double activeCaffeine =
            ActiveCaffeineCalc.calculateTotalActivateCaffeine(
              logs: logs,
              now: now,
            );

        // Generate decay curve
        final List<FlSpot> decaySpots = ActiveCaffeineCalc.generateDecayCurve(
          logs: logs,
          startTime: now,
          hoursToShow: 12,
        );

        // Get user's caffeine limit from Firestore
        return StreamBuilder<int>(
          stream: UserProfileService.getCaffeineLimitStream(),

          initialData: 400,

          builder: (context, limitSnapshot) {
            final int caffeineLimit = limitSnapshot.data ?? 400;

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
                        label: "TRACKER",
                        title: "Active Caffeine",
                        icon: Icons.local_cafe,
                      ),

                      const SizedBox(height: 24),

                      // Active caffeine
                      ActiveCaffeineCard(
                        caffeine: activeCaffeine.round(),
                        limit: caffeineLimit,
                      ),

                      const SizedBox(height: 24),

                      // Decay curve
                      DecayCurveCard(spots: decaySpots, startTime: now),

                      const SizedBox(height: 24),

                      // Still dummy for now
                      const BedtimeForecastCard(
                        caffeineLeft: 12,
                        bedTime: "10:30 PM",
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
