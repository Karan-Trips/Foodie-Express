// ignore_for_file: library_private_types_in_public_api

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app/Funtionnalities/Funtions_navigation/auth/login_controller.dart';
import 'package:my_app/pages/main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Sharedpref sp = Sharedpref();
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () async {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        var userId = user.uid;
        print(userId);
        sp.saveUserLoggedInStatus(true);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Mainpage(user: user),
          ),
        );
      } else {
        sp.saveUserLoggedInStatus(false);
        Navigator.pushReplacementNamed(context, '/home');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.blue,
                Colors.pink,
              ],
            ),
          ),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'InstaFood',
                  style: TextStyle(
                      color: Color.fromARGB(255, 46, 210, 41),
                      fontSize: 35,
                      fontWeight: FontWeight.bold),
                ),
                Image.asset(
                  "images/Burger.png",
                ),
                const Text(
                  "Food at Door step",
                  style: TextStyle(
                    color: Color.fromARGB(255, 44, 210, 41),
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
