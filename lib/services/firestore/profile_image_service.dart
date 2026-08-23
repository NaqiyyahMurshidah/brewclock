import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProfileImageService {
  static final FirebaseStorage _storage = FirebaseStorage.instance;

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static User? get currentUser => FirebaseAuth.instance.currentUser;

  static Future<String> uploadProfileImage(File imageFile) async {
    final user = currentUser;

    if (user == null) {
      throw Exception('No user is currently signed in');
    }

    // Storage path:
    // profile_images/{uid}/profile.jpg
    final Reference imageRef = _storage
        .ref()
        .child('profile_images')
        .child(user.uid)
        .child('profile.jpg');

    // Upload image
    await imageRef.putFile(imageFile);

    // Get Firebase Storage URL
    final String downloadUrl = await imageRef.getDownloadURL();

    // Save URL inside same user Firestore document
    await _firestore.collection('users').doc(user.uid).set({
      'profileImageUrl': downloadUrl,
    }, SetOptions(merge: true));

    return downloadUrl;
  }

  static Stream<String?> getProfileImageStream() {
    final user = currentUser;

    if (user == null) {
      return Stream.value(null);
    }

    return _firestore.collection('users').doc(user.uid).snapshots().map((
      document,
    ) {
      final data = document.data();

      return data?['profileImageUrl'] as String?;
    });
  }

  static Future<void> deleteProfileImage() async {
    final user = currentUser;

    if (user == null) {
      throw Exception('No user is currently signed in');
    }

    final Reference imageRef = _storage
        .ref()
        .child('profile_images')
        .child(user.uid)
        .child('profile.jpg');

    try {
      await imageRef.delete();
    } on FirebaseException catch (error) {
      // Ignore if there is no existing image
      if (error.code != 'object-not-found') {
        rethrow;
      }
    }

    await _firestore.collection('users').doc(user.uid).set({
      'profileImageUrl': null,
    }, SetOptions(merge: true));
  }
}
