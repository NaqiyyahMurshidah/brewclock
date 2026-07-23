import 'package:flutter/material.dart';
import '../../widgets/caffeine/active_caffeine_card.dart';
import '../../widgets/sleep/sleep_score_card.dart';
import '../../widgets/caffeine/caffeine_limit_card.dart';
import '../../widgets/caffeine/today_intake_card.dart';
import '../log_coffee/drink_loc.dart';
//crossAxisAllignment.start = make it aligns text to the left (start)

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final logs = [
      CoffeeLog(drinkName: "Espresso", caffeine: 64, time: "1:38 AM"),
    ];

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

                const SizedBox(height: 30),
                const ActiveCaffeineCard(),

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
