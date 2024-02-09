import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app/pages/main_screen.dart';
import 'package:my_app/pages/welcomepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () async {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        var userId = user.uid;
        print(userId);
        saveUserLoggedInStatus(true);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Mainpage(user: user),
          ),
        );
      } else {
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

  Future<void> saveUserLoggedInStatus(bool isLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', isLoggedIn);
  }
}
