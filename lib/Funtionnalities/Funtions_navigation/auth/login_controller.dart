// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_app/pages/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginLogic {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late BuildContext _context;

  LoginLogic(BuildContext context) {
    _context = context;
  }

  Future<void> performLogin(String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;

      print('Login successful: ${user!.email}');
      Navigator.pushReplacement(
        _context,
        MaterialPageRoute(
          builder: (BuildContext context) => Mainpage(user: user),
        ),
      );
    } catch (e) {
      print('Login failed: $e');
      
    }
  }

  Future<void> googleLogin() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        print('User signed in successfully: ${user.email}');
        Navigator.push(
          _context,
          MaterialPageRoute(
            builder: (BuildContext context) => Mainpage(user: user),
          ),
        );
      } else {
        print('Sign in failed');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}

class Sharedpref {
  Future<void> saveUserLoggedInStatus(bool isLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (isLoggedIn) {
      prefs.setBool('save', true);
    } else {
      prefs.remove('save');
    }
  }
}
