// ignore_for_file: avoid_print, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:my_app/Funtionnalities/Funtions_navigation/auth/signup_controller.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Sign Up '),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              ClipOval(
                child: SizedBox(
                  height: 250,
                  child: ClipOval(child: Image.asset('images/signup.png')),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 3, color: Colors.greenAccent),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          labelText: 'Name',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            _name = value;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 3,
                                color: Colors.greenAccent), //<-- SEE HERE
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          labelText: 'Email',
                        ),
                        validator: (value) {
                          if (value!.isEmpty || !value.contains('@')) {
                            return 'Please enter a valid email address';
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
                        height: 12,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 3,
                                color: Colors.greenAccent), //<-- SEE HERE
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          labelText: 'Password',
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty || value.length < 6) {
                            return 'Password must be at least 6 characters';
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
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder(
                                side: BorderSide(
                                    color: Colors.lightGreenAccent))),
                        onPressed: () {
                          if (_formKey.currentState?.validate() == true) {
                            SignUpHandler signUpHandler = SignUpHandler(
                              context: context,
                              name: _name,
                              email: _email,
                              password: _password,
                            );
                            signUpHandler.performSignUp();
                          }
                        },
                        child: const Center(child: Text('Sign Up')),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
