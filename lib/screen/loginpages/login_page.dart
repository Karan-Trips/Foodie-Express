// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:my_app/Funtionnalities/login_controller.dart';
import 'package:my_app/pages/main_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // LoginLogic loginLogic = LoginLogic(context);
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  void nextPage(user) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Mainpage(
          user: user,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    LoginLogic loginLogic = LoginLogic(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipOval(
              child: SizedBox(
                height: 250,
                child: ClipOval(child: Image.asset('images/login.jpg')),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 3,
                            color: Colors.greenAccent,
                          ),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        labelText: 'Email',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _email = value;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 3,
                            color: Colors.greenAccent,
                          ),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        labelText: 'Password',
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _password = value;
                        });
                      },
                    ),
                    const SizedBox(height: 16.0),
                    Center(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 5,
                                shape: const StadiumBorder(
                                  side: BorderSide(color: Colors.orange),
                                ),
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  // Call the function to perform login logic
                                  loginLogic.performLogin(_email, _password);
                                }
                              },
                              child: const Text('Login'),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                          ]),
                    ),
                    const SizedBox(height: 50),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SignInButton(
                            elevation: 10,
                            padding: const EdgeInsets.all(8),
                            shape: const StadiumBorder(),
                            Buttons.Google,
                            text: 'Login with Google',
                            onPressed: () {
                              loginLogic.googleLogin();
                            },
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          SignInButton(
                            Buttons.GitHub,
                            onPressed: () {},
                            padding: const EdgeInsets.all(10),
                            elevation: 10,
                            shape: const StadiumBorder(),
                            text: 'Login with GitHub',
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
