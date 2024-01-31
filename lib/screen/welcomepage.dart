import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  Widget _button({
    required String name,
    required Color bg,
    required BuildContext context,
  }) {
    return SizedBox(
      height: 60,
      width: 250,
      child: ElevatedButton(
        onPressed: () {
          if (name == 'Login') {
            // Navigate to the login page
            Navigator.pushNamed(context, '/login');
          } else {
            Navigator.pushNamed(context, '/signup');
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: bg,
          shape: const StadiumBorder(side: BorderSide(color: Colors.green)),
        ),
        child: Center(
          child: Text(
            name,
            style: const TextStyle(
              fontStyle: FontStyle.italic,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFECEFF1),
        body: Container(
          padding: const EdgeInsets.all(14.0),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 242, 225, 137),
                Color(0xFF2196F3),
              ],
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    child: Image.asset('images/logo.jpg', fit: BoxFit.cover),
                  ),
                  const SizedBox(height: 20),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Let's Eat, Guys",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Food Delivery",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(height: 50),
                      _button(
                          name: "Login", bg: Colors.green, context: context),
                      const SizedBox(height: 35),
                      _button(
                          name: "Sign Up", bg: Colors.white, context: context),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
