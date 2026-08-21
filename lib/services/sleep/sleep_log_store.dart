import '../../models/sleep_log.dart';

class SleepLogStore {
  static final List<SleepLog> _logs = [];

  static List<SleepLog> get logs => List.unmodifiable(_logs);

  static SleepLog? get latest => _logs.isEmpty ? null : _logs.last;

  static void add(SleepLog log) {
    _logs.add(log);
  }

  static void clear() {
    _logs.clear();
  }
}
