import '../models/coffee_log.dart';
import '../models/sleep_log.dart';

class StatisticsService {
  static List<CaffeineLog> filterLogs({
    required List<CaffeineLog> logs,
    required DateTime now,
    required String period,
  }) {
    if (period == "today") {
      return logs.where((log) {
        return log.consumedAt.year == now.year &&
            log.consumedAt.month == now.month &&
            log.consumedAt.day == now.day;
      }).toList();
    }

    if (period == "week") {
      final startOfWeek = now.subtract(Duration(days: now.weekday - 1));

      return logs.where((log) {
        return log.consumedAt.isAfter(
          DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day),
        );
      }).toList();
    }

    if (period == "month") {
      return logs.where((log) {
        return log.consumedAt.year == now.year &&
            log.consumedAt.month == now.month;
      }).toList();
    }
    return logs;
  }

  static double averageCaffeine(List<CaffeineLog> logs) {
    if (logs.isEmpty) return 0;
    final total = logs.fold<int>(0, (sum, log) => sum + log.caffeineMg);
    return total / logs.length;
  }

  static String topDrink(List<CaffeineLog> logs) {
    if (logs.isEmpty) return "No data";

    final Map<String, int> counts = {};

    for (final log in logs) {
      final String name = log.drinkName ?? log.brand ?? "Coffee";
      counts[name] = (counts[name] ?? 0) + 1;
    }

    String top = counts.keys.first;

    for (final entry in counts.entries) {
      if (entry.value > counts[top]!) {
        top = entry.key;
      }
    }

    return top;
  }

  static int topDrinkCaffeine(List<CaffeineLog> logs, String topDrink) {
    final matching = logs.where((log) {
      final name = log.drinkName ?? log.brand ?? "Coffee";

      return name == topDrink;
    }).toList();

    if (matching.isEmpty) return 0;

    return matching.first.caffeineMg;
  }

  //sleep log
  static List<SleepLog> filtersSleepLogs({
    required List<SleepLog> logs,
    required DateTime now,
    required String period,
  }) {
    if (period == "today") {
      return logs.where((log) {
        return log.wakeTime.year == now.year &&
            log.wakeTime.month == now.month &&
            log.wakeTime.day == now.day;
      }).toList();
    }

    if (period == "week") {
      final DateTime startOfWeek = DateTime(
        now.year,
        now.month,
        now.day,
      ).subtract(Duration(days: now.weekday - 1));

      return logs.where((log) {
        return !log.wakeTime.isBefore(startOfWeek);
      }).toList();
    }

    if (period == "month") {
      return logs.where((log) {
        return log.wakeTime.year == now.year && log.wakeTime.month == now.month;
      }).toList();
    }

    return logs;
  }
}
