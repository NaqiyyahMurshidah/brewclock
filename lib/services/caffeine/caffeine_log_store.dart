import '../../models/coffee_log.dart';

class CoffeeLogStore {
  static final List<CaffeineLog> logs = [];

  static void add(CaffeineLog log) {
    logs.add(log);
  }

  static void remove(CaffeineLog log) {
    logs.remove(log);
  }

  static void clear() {
    logs.clear();
  }
}
