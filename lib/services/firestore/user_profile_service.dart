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

  //when caffeine limit changes
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
  static Future<void> updateCaffeineLimit(int limit) async {
    await userDocument.set({
      'caffeineLimit': limit,
      'updateAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  //
}
