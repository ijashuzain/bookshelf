import 'package:book_shelf/data/userdata.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;
  AuthenticationService(this._firebaseAuth);

  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<String> logIn(AuthCredential credential) async {
    try {
      await _firebaseAuth.signInWithCredential(credential);
      return "SUCCESS";
    } on PlatformException catch (e) {
      return "${e.message.toString()}";
    }
  }

  Future signOut() async {
    await _firebaseAuth.signOut();
  }
}
