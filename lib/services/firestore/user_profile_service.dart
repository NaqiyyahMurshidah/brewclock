import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProfileService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static User? get currentUser => FirebaseAuth.instance.currentUser;

  static DocumentReference<Map<String, dynamic>> get userDocument {
    final user = currentUser;
    if (user == null) {
      throw Exception('No user is currently signed in');
    }
    return _firestore.collection('users').doc(user.uid);
  }

  //============================
  // when caffeine limit changes
  static Stream<int> getCaffeineLimitStream() {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Stream.value(400);
    }

    return FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .snapshots()
        .map((document) {
          final data = document.data();

          return (data?['caffeineLimit'] as num?)?.toInt() ?? 400;
        });
  }

  //update caffeine limit from settings
  Future<void> updateCaffeineLimit(int newLimit) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return;

    await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
      'caffeineLimit': newLimit,
    }, SetOptions(merge: true));
  }

  // ===========
  // sleep goal
  static Stream<int> getSleepGoalStream() {
    final user = currentUser;

    if (user == null) {
      return Stream.value(480); //default 8 hours
    }

    return userDocument.snapshots().map((document) {
      final data = document.data();

      return (data?['sleepGoal'] as num?)?.toInt() ?? 480;
    });
  }

  static Future<void> updateSleepGoal(int sleepGoal) async {
    //await userDocument.set({'sleepGoal': sleepGoal}, SetOptions(merge: true));

    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return;

    await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
      'sleepGoal': sleepGoal,
    }, SetOptions(merge: true));
  }

  //=================
  //preferred bedtime
  static Stream<int> getPreferredBedtimesStream() {
    final user = currentUser;

    if (user == null) {
      return Stream.value(1380); //default 11:00 PM
    }

    return userDocument.snapshots().map((document) {
      final data = document.data();
      return (data?['preferredBedtime'] as num?)?.toInt() ?? 1380;
    });
  }

  static Future<void> updatePreferredBedtime(int preferredBedTime) async {
    // await userDocument.set(
    //   {
    //     'preferredBedtime': preferredBedTime
    //   },
    //   SetOptions(merge: true),
    // );

    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return;

    await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
      'preferredBedtime': preferredBedTime,
    }, SetOptions(merge: true));
  }

  //=========
  //get name

  static Stream<String> getName() {
    final user = currentUser;

    if (user == null) {
      return Stream.value("User");
    }

    return userDocument.snapshots().map((document) {
      final data = document.data();

      return data?['name'] as String? ?? "User";
    });
  }

  //===========
  //get email
   static Stream<String> getEmail() {
    final user = currentUser;

    if (user == null) {
      return Stream.value("User");
    }

    return userDocument.snapshots().map((document) {
      final data = document.data();

      return data?['email'] as String? ?? "User";
    });
  }
}
