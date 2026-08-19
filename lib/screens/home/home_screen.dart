import 'package:flutter/material.dart';
import '../../widgets/tracker/active_caffeine_card.dart';
import '../../widgets/home/caffeine_limit_card.dart';
import '../../widgets/home/today_intake_card.dart';
import '../../widgets/home/drink_loc_card.dart';
import '../../services/caffeine_log_store.dart';
import '../../services/active_caffeine_calc.dart';
import '../../widgets/home/sleep_log_card.dart';
//crossAxisAllignment.start = make it aligns text to the left (start)

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    //take data from caffeelogstore
    final logs = CoffeeLogStore.logs;

    final DateTime now = DateTime.now();

    //total caffeine consumed today
    final int todayCaffeine = logs
        .where(
          (log) =>
              log.consumedAt.year == now.year &&
              log.consumedAt.month == now.month &&
              log.consumedAt.day == now.day,
        )
        .fold(0, (total, log) => total + log.caffeineMg);

    //its from user profile / settings
    const int caffeineLimit = 400;

    final double activeCaffeine =
        ActiveCaffeineCalc.calculateTotalActivateCaffeine(
          logs: logs,
          now: DateTime.now(),
        );

    return Scaffold(
      backgroundColor: const Color(0xFF1A1411),

      body: SafeArea(
        child: SingleChildScrollView(
          physics: FixedExtentScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(24.0),

            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Hello shida !",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Tuesday, 19th may",
                          style: TextStyle(color: Colors.white70, fontSize: 18),
                        ),
                      ],
                    ),

                    const CircleAvatar(radius: 28, child: Icon(Icons.person)),
                  ],
                ),

                //widgets/active_caffeine_card.dart
                const SizedBox(height: 30),
                ActiveCaffeineCard(
                  caffeine: activeCaffeine.round(),
                  limit: caffeineLimit,
                ),

                // drink_loc.dart card at /widget/common
                const SizedBox(height: 20),
                DrinkLocation(),

                //sleep_log_card.dart widgets/home
                const SizedBox(height: 20),
                SleepLogCard(),

                const SizedBox(height: 20),
                CaffeineLimitCard(
                  caffeine: todayCaffeine,
                  limit: caffeineLimit,
                ),

                // today's intake
                const SizedBox(height: 14),
                TodayIntakeCard(logs: logs),

                const SizedBox(height: 20),
              ],
            ), //arrange item vertically
          ),
        ),
      ),
    ); //Scaffold skelaton of the screen
  }
}
