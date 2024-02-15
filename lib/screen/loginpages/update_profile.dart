// ignore_for_file: use_build_context_synchronously, avoid_print, library_private_types_in_public_api

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';

class UserUpdateProfile extends StatefulWidget {
  final User user;

  const UserUpdateProfile({Key? key, required this.user}) : super(key: key);

  @override
  _UserUpdateProfileState createState() => _UserUpdateProfileState();
}

class _UserUpdateProfileState extends State<UserUpdateProfile> {
  late TextEditingController name;
  late TextEditingController email;
  late TextEditingController streetNo;
  late TextEditingController city;
  late TextEditingController nearby;
  late TextEditingController phoneno;

  @override
  void initState() {
    super.initState();
    name = TextEditingController(text: widget.user.displayName);
    email = TextEditingController(text: widget.user.email);
    streetNo = TextEditingController();
    city = TextEditingController();
    nearby = TextEditingController();
    phoneno = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => _updateUserImage(),
                child: SizedBox(
                  height: 250,
                  child: CircleAvatar(
                    radius: 120,
                    backgroundImage: widget.user.photoURL != null
                        ? NetworkImage(widget.user.photoURL!)
                        : const AssetImage("images/profile.jpg")
                            as ImageProvider,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: name,
                decoration: const InputDecoration(
                  labelText: 'Update Name',
                  labelStyle: TextStyle(color: Colors.blue),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                  ),
                ),
                style: const TextStyle(color: Colors.black),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: streetNo,
                decoration: const InputDecoration(
                  labelText: 'Street Number/Flat-Number',
                  labelStyle: TextStyle(color: Colors.blue),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                  ),
                ),
                style: const TextStyle(color: Colors.black),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: city,
                decoration: const InputDecoration(
                  labelText: 'City',
                  labelStyle: TextStyle(color: Colors.blue),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                  ),
                ),
                style: const TextStyle(color: Colors.black),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: nearby,
                decoration: const InputDecoration(
                  labelText: 'Nearby',
                  labelStyle: TextStyle(color: Colors.blue),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                  ),
                ),
                style: const TextStyle(color: Colors.black),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _updateUserProfile(),
                child: const Text('Update Profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _updateUserProfile() async {
    try {
      await FirebaseAuth.instance.currentUser!.updateDisplayName(name.text);
      // await FirebaseAuth.instance.currentUser!.updateEmail(email.text);

      await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.user.uid)
          .update({
        'displayName': name.text,
        // 'email': email.text,
        'street': streetNo.text,
        'city': city.text,
        'nearby': nearby.text,
        "phone": phoneno.text,
      });

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Profile updated successfully'),
      ));
      // Navigator.pop(context);
    } catch (error) {
      print('Error updating profile: $error');
    }
  }

  Future<void> _updateUserImage() async {
    final ImagePicker picker = ImagePicker();

    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      try {
        File imageFile = File(pickedFile.path);

        String imageName = 'user_profile_${widget.user.uid}.jpg';
        firebase_storage.Reference storageRef =
            firebase_storage.FirebaseStorage.instance.ref().child(imageName);
        await storageRef.putFile(imageFile);
        String downloadURL = await storageRef.getDownloadURL();
        await FirebaseAuth.instance.currentUser!.updatePhotoURL(downloadURL);
        setState(() {});

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Image updated successfully'),
        ));
      } catch (error) {
        print('Error updating image: $error');
      }
    }
  }
}
