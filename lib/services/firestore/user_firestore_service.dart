import 'package:cloud_firestore/cloud_firestore.dart';

class UserFirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createUserProfile({
    required String uid,
    required String name,
    required String email,
  }) async {
    await _firestore.collection('users').doc(uid).set({
      'name': name,
      'email': email,
      'caffeineLimit':null,
      'preferredBedTime' : null,
      'sleepGoal' : null,
      'createdAt' : FieldValue.serverTimestamp(),
    });
  }
}
