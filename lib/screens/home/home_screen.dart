import 'package:flutter/material.dart';
import '../../widgets/tracker/active_caffeine_card.dart';
import '../../widgets/home/caffeine_limit_card.dart';
import '../../widgets/home/today_intake_card.dart';
import '../../widgets/home/drink_loc_card.dart';
import '../../widgets/home/sleep_log_card.dart';
import '../../services/caffeine/caffeine_log_store.dart';
import '../../services/caffeine/active_caffeine_calc.dart';
import '../../services/firestore/user_profile_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // Get coffee logs from the local coffee store
    final logs = CoffeeLogStore.logs;

    final DateTime now = DateTime.now();

    // Calculate the total caffeine consumed today
    final int todayCaffeine = logs
        .where(
          (log) =>
              log.consumedAt.year == now.year &&
              log.consumedAt.month == now.month &&
              log.consumedAt.day == now.day,
        )
        .fold<int>(0, (total, log) => total + log.caffeineMg);

    // Calculate caffeine that is currently active in the body
    final double activeCaffeine =
        ActiveCaffeineCalc.calculateTotalActivateCaffeine(logs: logs, now: now);

    // Listen to the user's caffeine limit from Firestore
    return StreamBuilder<int>(
      stream: UserProfileService.getCaffeineLimitStream(),

      // Used while Firestore is still loading
      initialData: 400,

      builder: (context, snapshot) {
        // Use the Firestore value or 400 if it is unavailable
        final int caffeineLimit = snapshot.data ?? 400;

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
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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

                          SizedBox(height: 8),

                          Text(
                            'Tuesday, 19th May',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),

                      const CircleAvatar(radius: 28, child: Icon(Icons.person)),
                    ],
                  ),

                  // Active caffeine card
                  const SizedBox(height: 30),

                  ActiveCaffeineCard(
                    caffeine: activeCaffeine.round(),
                    limit: caffeineLimit,
                  ),

                  // Choose Home or Cafe
                  const SizedBox(height: 20),

                  const DrinkLocation(),

                  // Sleep log card
                  const SizedBox(height: 20),

                  const SleepLogCard(),

                  // Daily caffeine limit card
                  const SizedBox(height: 20),

                  CaffeineLimitCard(
                    caffeine: todayCaffeine,
                    limit: caffeineLimit,
                  ),

                  // Today's coffee intake
                  const SizedBox(height: 14),

                  TodayIntakeCard(logs: logs),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
