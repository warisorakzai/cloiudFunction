import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudfunction/Model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SignnupProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? get user => _auth.currentUser;
  User? _user;

  SignnupProvider();

  Future SignupwithEmailandPassword(
    String email,
    String password,
    String name,
  ) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // await credential.user?.updateDisplayName(name);
      // await credential.user?.reload();

      _user = credential.user;
      String? token = await FirebaseMessaging.instance.getToken();

      if (_user != null && token != null) {
        await _firestore.collection('users').doc(_user!.uid).set({
          'email': _user!.email,
          'token': token,
        }, SetOptions(merge: true));
      }
      notifyListeners();
      return null;
    } on FirebaseAuthException catch (e) {
      print(e);
      return e.message;
    }
  }

  Future<void> saveUserData({required AppUser user}) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .set(user.toMap());
    } catch (e) {
      print('Error saving user data: $e');
    }
  }
}
