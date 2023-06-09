import 'package:flutter/material.dart';
import 'package:izelakkas/services/auth_service.dart'; // AuthService'ın bulunduğu dosya
import 'package:izelakkas/screen/home/home_screen.dart'; // Ana sayfanın bulunduğu dosya

class SignInScreen extends StatelessWidget {
  final AuthService _authService =
      AuthService(); // AuthService sınıfını kullanmak için bir örnek oluşturuyoruz

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: 'Enter your email',
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Enter your password',
                labelText: 'Password',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                bool signInSuccessful =
                    await _authService.signInWithEmailAndPassword(
                  email: emailController.text,
                  password: passwordController.text,
                );
                if (signInSuccessful) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Failed to sign in.'),
                  ));
                }
              },
              child: Text('Sign In'),
            ),
          ],
        ),
      ),
    );
  }
}
