import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:izelakkas/screen/category/news_technology.dart';
import 'package:izelakkas/screen/profile/change_password_screen.dart';
import 'firebase_options.dart';
import 'package:izelakkas/screen/home/home_screen.dart';
import 'package:izelakkas/screen/sign_in/sign_in_screen.dart';
import 'package:izelakkas/screen/sign_up/sign_up_screen.dart';
import 'package:izelakkas/screen/category/news_business.dart';
import 'package:izelakkas/screen/category/news_entertainment.dart';
import 'package:izelakkas/screen/category/news_health.dart';
import 'package:izelakkas/screen/category/news_science.dart';
import 'package:izelakkas/screen/category/news_sports.dart';
import 'package:izelakkas/screen/category/news.dart';
import 'package:izelakkas/screen/profile/profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/sign-in': (context) => SignInScreen(),
        '/sign-up': (context) => SignUpScreen(),
        '/category/news_business': (context) => Business(),
        '/category/news_entertainment': (context) => Entertainment(),
        '/category/news_health': (context) => Health(),
        '/category/news_science': (context) => Science(),
        '/category/news_sports': (context) => Sports(),
        '/category/news_technology': (context) => Technology(),
        '/category/news': (context) => News(),
        '/home/home_screen': (context) => HomeScreen(),
        '/profile/change_password_screen.dart': (context) =>
            ChangePasswordScreen(),
        '/profile/profile_screen': (context) => ProfileScreen(),
      },
    );
  }
}
