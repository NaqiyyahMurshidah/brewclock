import 'package:flutter/material.dart';

import '../../models/coffee_log.dart';

import '../../widgets/tracker/active_caffeine_card.dart';
import '../../widgets/home/caffeine_limit_card.dart';
import '../../widgets/home/today_intake_card.dart';
import '../../widgets/home/drink_loc_card.dart';
import '../../widgets/home/sleep_log_card.dart';

import '../../services/caffeine/active_caffeine_calc.dart';
import '../../services/firestore/user_profile_service.dart';
import '../../services/firestore/coffee_firestore_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // ==========================================
    // 1. LISTEN TO COFFEE LOGS FROM FIRESTORE
    // ==========================================

    return StreamBuilder<List<CaffeineLog>>(
      stream: CoffeeFirestoreService.getCoffeeLogs(),

      builder: (context, coffeeSnapshot) {
        // While coffee logs are loading
        if (coffeeSnapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            backgroundColor: Color(0xFF1A1411),
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // If Firestore gives an error
        if (coffeeSnapshot.hasError) {
          return Scaffold(
            backgroundColor: const Color(0xFF1A1411),
            body: Center(
              child: Text(
                "Failed to load coffee logs",
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
        }

        // ==========================================
        //  LOGS FROM FIRESTORE
        final List<CaffeineLog> logs = coffeeSnapshot.data ?? [];
        final DateTime now = DateTime.now();

        // ==========================================
        // GET TODAY'S LOGS
        final List<CaffeineLog> todayLogs = logs.where((log) {
          return log.consumedAt.year == now.year &&
              log.consumedAt.month == now.month &&
              log.consumedAt.day == now.day;
        }).toList();

        // ==========================================
        // TOTAL CAFFEINE CONSUMED TODAY
        final int todayCaffeine = todayLogs.fold<int>(
          0,
          (total, log) => total + log.caffeineMg,
        );

        // ==========================================
        // ACTIVE CAFFEINE
        final double activeCaffeine =
            ActiveCaffeineCalc.calculateTotalActivateCaffeine(
              logs: logs,
              now: now,
            );

        // ==========================================
        // LISTEN TO CAFFEINE LIMIT
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
                    physics: const ClampingScrollPhysics(),

                    padding: const EdgeInsets.all(24),

                    children: [
                      // =====================
                      // HEADER
                      // =====================
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              // User name
                              StreamBuilder<String>(
                                stream: UserProfileService.getName(),

                                builder: (context, snapshot) {
                                  final String name = snapshot.data ?? "User";

                                  return Text(
                                    "Hello $name!",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                },
                              ),

                              const SizedBox(height: 8),

                              const Text(
                                'Tuesday, 19th May',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),

                          const CircleAvatar(
                            radius: 28,
                            child: Icon(Icons.person),
                          ),
                        ],
                      ),

                      // =====================
                      // ACTIVE CAFFEINE
                      // =====================
                      const SizedBox(height: 30),

                      ActiveCaffeineCard(
                        caffeine: activeCaffeine.round(),
                        limit: caffeineLimit,
                      ),

                      // =====================
                      // LOG COFFEE
                      // =====================
                      const SizedBox(height: 20),

                      const DrinkLocation(),

                      // =====================
                      // SLEEP LOG
                      // =====================
                      const SizedBox(height: 20),

                      const SleepLogCard(),

                      // =====================
                      // CAFFEINE LIMIT
                      // =====================
                      const SizedBox(height: 20),

                      CaffeineLimitCard(
                        caffeine: todayCaffeine,
                        limit: caffeineLimit,
                      ),

                      // =====================
                      // TODAY'S INTAKE
                      // =====================
                      const SizedBox(height: 14),

                      TodayIntakeCard(logs: todayLogs),

                      const SizedBox(height: 20),
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
