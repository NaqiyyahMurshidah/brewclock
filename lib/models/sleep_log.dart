class SleepLog {
  final DateTime bedtime;
  final DateTime wakeTime;
  final Duration duration;

  const SleepLog({
    required this.bedtime,
    required this.wakeTime,
    required this.duration,
  });

  Map<String, dynamic> toMap() {
    return {
      'bedtime': bedtime.toIso8601String(),
      'wakeTime': wakeTime.toIso8601String(),
      'durationMinutes': duration.inMinutes,
    };
  }

  factory SleepLog.fromMap(Map<String, dynamic> map) {
    return SleepLog(
      bedtime: DateTime.parse(map['bedtime']),
      wakeTime: DateTime.parse(map['wakeTime']),
      duration: Duration(minutes: map['durationMinutes']),
    );
  }
}
