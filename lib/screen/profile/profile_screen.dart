import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:izelakkas/screen/sign_in/sign_in_screen.dart';
import 'package:izelakkas/screen/sign_up/sign_up_screen.dart';
import 'package:izelakkas/services/auth_service.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthService _authService = AuthService();

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
            backgroundImage: NetworkImage('https://source.unsplash.com/400x400/?portrait'),
          ),
          SizedBox(height: 16.0),
          Text(
            'İzel Akkaş',
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(height: 8.0),
          Text(
            'info@example.com',
            style: Theme.of(context).textTheme.bodyText2,
          ),
          SizedBox(height: 16.0),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Edit Profile'),
            onTap: () {
              // Navigate to edit profile screen
            },
          ),
          ListTile(
            leading: Icon(Icons.lock),
            title: Text('Change Password'),
            onTap: () {
              // Navigate to change password screen
            },
          ),
          if (_authService.currentUser == null)
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
          if (_authService.currentUser != null)
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Log Out'),
              onTap: () async {
                await _authService.signOut();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Oturumunuz kapatıldı.'),
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
