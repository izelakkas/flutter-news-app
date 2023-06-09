import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:izelakkas/screen/profile/profile_screen.dart';
import 'package:izelakkas/screen/sign_in/sign_in_screen.dart';
import 'package:izelakkas/screen/sign_up/sign_up_screen.dart';
import 'package:izelakkas/services/auth_service.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:izelakkas/screen/category/news_business.dart';
import 'package:izelakkas/screen/category/news_entertainment.dart';
import 'package:izelakkas/screen/category/news_health.dart';
import 'package:izelakkas/screen/category/news_science.dart';
import 'package:izelakkas/screen/category/news_sports.dart';
import 'package:izelakkas/screen/category/news.dart';
import 'package:izelakkas/screen/search/search_page.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthService _authService = AuthService();
  final User? user = FirebaseAuth.instance.currentUser;

  bool get _isLogged => user != null;

  int _currentIndex = 0;
  final List<Widget> _screens = [
    HomeContent(),
    SearchPage(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News'),
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.red,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    user != null ? user!.email! : '',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text(_isLogged ? 'Sign Out' : 'Sign In'),
              onTap: () async {
                if (_isLogged) {
                  await _authService.signOut();
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignInScreen(),
                    ),
                  );
                }
              },
            ),
            ListTile(
              leading: Icon(Icons.app_registration),
              title: Text('Sign Up'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignUpScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  final List<String> images = [
    'https://r.resimlink.com/Vb3fJPCtD.png',
    'https://r.resimlink.com/RhVaAlZqE.png',
    'https://r.resimlink.com/9n4_t25plg.png',
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 20),
          CarouselSlider(
            items: images.map((image) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Image.network(
                      image,
                      fit: BoxFit.fitWidth,
                    ),
                  );
                },
              );
            }).toList(),
            options: CarouselOptions(
              height: 200,
              enlargeCenterPage: true,
              aspectRatio: 16 / 9,
              autoPlay: true,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              viewportFraction: 0.8,
            ),
          ),
          SizedBox(height: 20),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/category/news_business');
                  },
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.width / 2,
                    child: Image.network(
                      'https://r.resimlink.com/ScFan.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 1),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                        context, '/category/news_entertainment');
                  },
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.width / 2,
                    child: Image.network(
                      'https://r.resimlink.com/ulUNsZzEPo_.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/category/news_health');
                  },
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.width / 2,
                    child: Image.network(
                      'https://r.resimlink.com/eo_Zu7nkW.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 1),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/category/news_science');
                  },
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.width / 2,
                    child: Image.network(
                      'https://r.resimlink.com/ycR2pi.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/category/news_sports');
                  },
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.width / 2,
                    child: Image.network(
                      'https://r.resimlink.com/4obmJlQ3.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 1),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/category/news_technology');
                  },
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.width / 2,
                    child: Image.network(
                      'https://r.resimlink.com/hKEBU4.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/category/news');
            },
            child: Container(
              width: double.infinity,
              child: Image.network(
                'https://r.resimlink.com/OMFCm.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
