// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_app/screen/loginpages/login_page.dart';

class SignUpHandler {
  final BuildContext context;
  final String name;
  final String email;
  final String password;

  SignUpHandler({
    required this.context,
    required this.name,
    required this.email,
    required this.password,
  });

  Future<void> performSignUp() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'name': name,
        'email': email,
        'street': "",
        'city': "",
        'nearby': "",
      });

      await userCredential.user!.updateDisplayName(name);

      print('Sign up successful: ${userCredential.user!.email}');
      print('Name: ${userCredential.user!.displayName}');

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Sign up failed. Please try again.'),
        ),
      );
    }
  }
  
}
