import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class SignnupProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  User? get user => _user;

  SignnupProvider() {
    _user = _auth.currentUser;
  }

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
