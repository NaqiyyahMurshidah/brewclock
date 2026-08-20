import 'package:flutter/material.dart';
import '../../models/coffee_log.dart';


class TodayIntakeCard extends StatelessWidget {
  final List<CaffeineLog> logs;

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
            style: TextStyle(color: Colors.white, fontSize: 22),
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
                  contentPadding: EdgeInsets.zero,

                  //cafe = drink name
                  //home = brand
                  title: Text(
                    log.drinkName ?? log.brand ?? "Coffee",
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    TimeOfDay.fromDateTime(log.consumedAt).format(context),
                    style: const TextStyle(color: Colors.white60),
                  ),
                  trailing: Text(
                    "${log.caffeineMg} mg",
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }
}
