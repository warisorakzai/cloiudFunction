import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class SignnupProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? get user => _auth.currentUser;

  SignnupProvider() {}

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
      notifyListeners();
      return null;
    } on FirebaseAuthException catch (e) {
      print(e);
      return e.message;
    }
  }
}
