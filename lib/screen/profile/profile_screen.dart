import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:izelakkas/screen/sign_in/sign_in_screen.dart';
import 'package:izelakkas/screen/sign_up/sign_up_screen.dart';
import 'package:izelakkas/screen/profile/change_password_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  File? _image;
  final picker = ImagePicker();
  String? userName;
  String? userEmail;

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot snapshot =
          await _firestore.collection('users').doc(user.uid).get();
      setState(() {
        if (snapshot.exists &&
            (snapshot.data() as Map<String, dynamic>)
                .containsKey('imagePath')) {
          _image = snapshot.get('imagePath') != null &&
                  snapshot.get('imagePath') != ""
              ? File(snapshot.get('imagePath'))
              : null;
        }
        userName = snapshot.get('name');
        userEmail = snapshot.get('email');
      });
    }
  }

  Future<void> _uploadImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });

      try {
        User? user = _auth.currentUser;
        if (user != null) {
          DocumentReference userRef =
              _firestore.collection('users').doc(user.uid);
          await userRef.update({'imagePath': pickedFile.path});

          firebase_storage.Reference ref = firebase_storage
              .FirebaseStorage.instance
              .ref()
              .child('profile_images/${user.uid}');
          await ref.putFile(_image!);
          String downloadURL = await ref.getDownloadURL();
          // Resim yüklendikten sonra yapılacak işlemler...
        }
      } catch (e) {
        print('Failed to upload image: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 32.0),
          CircleAvatar(
            radius: 64.0,
            backgroundImage: _image != null ? FileImage(_image!) : null,
            child: _image == null ? Icon(Icons.person, size: 64.0) : null,
          ),
          ElevatedButton(
            onPressed: () {
              if (_auth.currentUser != null) {
                _uploadImage();
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignInScreen()),
                );
              }
            },
            child: Text('Upload Profile Photo'),
          ),
          SizedBox(height: 16.0),
          Text(
            userName ?? '',
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(height: 8.0),
          Text(
            userEmail ?? '',
            style: Theme.of(context).textTheme.bodyText2,
          ),
          ListTile(
            leading: Icon(Icons.lock),
            title: Text('Change Password'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChangePasswordScreen()),
              );
            },
          ),
          if (_auth.currentUser == null)
            Column(
              children: [
                ListTile(
                  leading: Icon(Icons.login),
                  title: Text('Sign In'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignInScreen()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.person_add),
                  title: Text('Sign Up'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpScreen()),
                    );
                  },
                ),
              ],
            ),
          if (_auth.currentUser != null)
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Log Out'),
              onTap: () async {
                await _auth.signOut();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Your session has been closed.'),
                  ),
                );
                Navigator.pop(context);
              },
            ),
        ],
      ),
    );
  }
}
