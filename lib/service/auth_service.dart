import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_setup_g3/login_page.dart';
import 'package:flutter/material.dart';

class AuthService {
  static final _auth = FirebaseAuth.instance;

  static bool isLoggedIn() {
    final User? firebaseUser = _auth.currentUser;
    return firebaseUser != null;
  }

  static Future<User?> loginUser(String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
    final User firebaseUser = _auth.currentUser!;
    return firebaseUser;
  }

  static Future<User?> signUp(String email, String password) async {
    var result = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final User firebaseUser = result.user!;
    return firebaseUser;
  }

  static void logOut(BuildContext context) {
    _auth.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) {
          return LoginPage();
        },
      ),
    );
  }
}
