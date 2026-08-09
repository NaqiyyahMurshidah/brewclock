// calculate how much caffeine remains based on how log ago it was consumed
import 'dart:math';
import '../models/coffee_log.dart';

class ActiveCaffeineCalc {
  static double calculateTotalActivateCaffeine({
    required List<CaffeineLog> logs,
    required DateTime now,
    double halfLifeHours = 5.0,
  }) {
    double total = 0;

    for (final log in logs) {
      final double hoursPassed =
          now.difference(log.consumedAt).inMinutes / 60.0;

      if (hoursPassed < 0) {
        continue;
      }

      final double remaining =
          (log.caffeineMg * pow(0.5, hoursPassed / halfLifeHours)).toDouble();

      total += remaining;
    }

    return total;
  }
}
