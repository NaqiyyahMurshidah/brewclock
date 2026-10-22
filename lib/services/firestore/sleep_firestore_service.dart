import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/sleep_log.dart';

class SleepFirestoreService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static User? get currentUser => FirebaseAuth.instance.currentUser;

  static CollectionReference<Map<String, dynamic>> get sleepLogsCollection {
    final user = currentUser;

    if (user == null) {
      throw Exception('No user is currently signed in');
    }

    return _firestore
        .collection('users')
        .doc(user.uid)
        .collection('sleep_logs');
  }

  static Future<void> addSleepLog(SleepLog log) async {
    await sleepLogsCollection.add(log.toMap());
  }

  static Stream<List<SleepLog>> getSleepLogs() {
    final user = currentUser;

    if (user == null) {
      return Stream.value([]);
    }

    return sleepLogsCollection
        .orderBy('wakeTime', descending: false)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return SleepLog.fromMap(doc.data());
          }).toList();
        });
  }
}
