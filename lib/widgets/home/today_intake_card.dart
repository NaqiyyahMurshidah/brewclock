import 'package:flutter/material.dart';

class TodayIntakeCard extends StatelessWidget {
  final List<CoffeeLog> logs;

  const TodayIntakeCard({super.key, required this.logs});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Today's Intake", 
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 2),

          if (logs.isEmpty)
            // const EmptyState() //bila dah ada empty state nanti 
            const Text("No caffeine")
          else
            // CoffeeList(logs: logs),
            Column(
              children: logs.map((log) {
                return ListTile(
                  title: Text(
                    log.drinkName, style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  subtitle: Text(log.time),
                  trailing: Text("${log.caffeine} mg"),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }
}

class CoffeeLog {
  final String drinkName;
  final int caffeine;
  final String time;

  CoffeeLog({
    required this.drinkName,
    required this.caffeine,
    required this.time,
  });
}
