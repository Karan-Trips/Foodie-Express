// ignore_for_file: use_build_context_synchronously, avoid_print, library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserUpdateProfile extends StatefulWidget {
  final User user;

  const UserUpdateProfile({Key? key, required this.user}) : super(key: key);

  @override
  _UserUpdateProfileState createState() => _UserUpdateProfileState();
}

class _UserUpdateProfileState extends State<UserUpdateProfile> {
  late TextEditingController name;
  late TextEditingController email;

  @override
  void initState() {
    super.initState();
    name = TextEditingController(text: widget.user.displayName);
    email = TextEditingController(text: widget.user.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: name,
              decoration: const InputDecoration(labelText: 'Display Name'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: email,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _updateUserProfile(),
              child: const Text('Update Profile'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _updateUserProfile() async {
    try {
      await FirebaseAuth.instance.currentUser!.updateDisplayName(name.text);
      await FirebaseAuth.instance.currentUser!.updateEmail(email.text);

      await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.user.uid)
          .update({
        'displayName': name.text,
        'email': email.text,
        // 'photo': null,
      });

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Profile updated successfully'),
      ));
    } catch (error) {
      print('Error updating profile: $error');
    }
  }
}
