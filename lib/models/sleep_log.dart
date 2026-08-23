import 'package:cloud_firestore/cloud_firestore.dart';

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
      'bedtime': Timestamp.fromDate(bedtime),
      'wakeTime': Timestamp.fromDate(wakeTime),
      'durationMinutes': duration.inMinutes,
    };
  }

  factory SleepLog.fromMap(Map<String, dynamic> map) {
    return SleepLog(
      bedtime: (map['bedtime'] as Timestamp).toDate(),
      wakeTime: (map['wakeTime'] as Timestamp).toDate(),
      duration: Duration(minutes: map['durationMinutes'] as int),
    );
  }
}
