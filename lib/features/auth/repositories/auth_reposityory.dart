import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;
  final FirebaseStorage _firebaseStorage;

  AuthRepository({
    FirebaseAuth? firebaseAuth,
    FirebaseFirestore? firestore,
    FirebaseStorage? firebaseStorage,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
       _firestore = firestore ?? FirebaseFirestore.instance,
       _firebaseStorage = firebaseStorage ?? FirebaseStorage.instance;

  Future<User?> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = userCredential.user;
    await user?.sendEmailVerification();
    await user?.updateDisplayName(name);
    await user?.reload();
    if (user != null) {
      await _firestore.collection("users").doc(user.uid).set({
        "uid": user.uid,
        "name": name,
        "email": email,
        "createAt": FieldValue.serverTimestamp(),
      });
    }
    return _firebaseAuth.currentUser;
  }

  Future<User?> login({required String email, required String password}) async {
    final credential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = credential.user;
    return user;
  }

  Future<void> updateUserProfile({
    required String uid,
    String? phone,
    String? address,
  }) async {
    Map<String, dynamic> data = {};
    if (phone != null) data['phone'] = phone;
    if (address != null) data['address'] = address;
    await _firestore.collection("users").doc(uid).update(data);
  }

  Future<void> uploadProfileImage(File imageFile) async {
    final user = _firebaseAuth.currentUser;
    if (user == null) throw Exception("User not logged in");
    final ref = _firebaseStorage.ref().child("user_profile/${user.uid}.jpg");
    await ref.putFile(imageFile);
    final imageUrl = await ref.getDownloadURL();
    await user.updatePhotoURL(imageUrl);
    await _firestore.collection("users").doc(user.uid).update({
      "profileImage": imageUrl,
    });
    await user.reload();
  }
}
