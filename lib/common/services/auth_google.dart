import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthUser {
  static Future<User?> loginGoogle() async {
    final GoogleSignInAccount? accountGoogle = await GoogleSignIn().signIn();
    if (accountGoogle == null) {
      return null;
    }
    final GoogleSignInAuthentication googleAuth =
        await accountGoogle.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isAuthenticated', true);

    return userCredential.user;
  }
}
