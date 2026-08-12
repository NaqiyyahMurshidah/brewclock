import '../models/sleep_log.dart';

class SleepLogStore {
  static final List<SleepLog> _logs = [];

  static List<SleepLog> get logs => _logs;

  static void add(SleepLog log) {
    _logs.add(log);
  }

  static void clear() {
    _logs.clear();
  }
}
