import 'package:flutter/material.dart';
import '../../widgets/tracker/active_caffeine_card.dart';
import '../../widgets/home/caffeine_limit_card.dart';
import '../../widgets/home/today_intake_card.dart';
import '../../widgets/home/drink_loc_card.dart';
import '../../models/coffee_log.dart';
import '../../services/caffeine_log_store.dart';
import '../../services/active_caffeine_calc.dart';
import '../../services/caffeine_log_store.dart';
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

    final double activeCaffeine =
        ActiveCaffeineCalc.calculateTotalActivateCaffeine(
          logs: logs,
          now: DateTime.now(),
        );

    return Scaffold(
      backgroundColor: const Color(0xFF1A1411),

      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
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
                  limit: 400,
                ),

                // drink_loc.dart card at /widget/common
                const SizedBox(height: 20),
                DrinkLocation(),

                //sleep score card
                // const SleepScoreCard(
                //   score: 98,
                //   quality: "Deeply Restful",
                //   bedtime: "11:00 PM",
                //   wakeTime: "7:00 AM",
                //   duration: "8h",
                // ),
                const SizedBox(height: 20),
                const CaffeineLimitCard(caffeine: 23, limit: 400),

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
