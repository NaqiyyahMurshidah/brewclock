import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:brewclock/models/coffee_log.dart';

class CoffeeFirestoreService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static User? get currentUser => FirebaseAuth.instance.currentUser;

  static CollectionReference<Map<String, dynamic>> get coffeeLogsCollection {
    final user = currentUser;

    if (user == null) {
      throw Exception('No user is currently signed in');
    }

    return _firestore
        .collection('users')
        .doc(user.uid)
        .collection('coffee_logs');
  }

  static Future<void> addCoffeeLog(CaffeineLog log) async {
    await coffeeLogsCollection.add(log.toMap());
  }
}
