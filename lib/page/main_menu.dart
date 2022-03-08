import 'dart:convert';

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:hastrade/network/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'analisis.dart';
import 'home.dart';
import 'login.dart.w';
import 'news.dart';
import 'stok.dart';
import 'video.dart';

void main() {
  runApp(MyHomePage());
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainMenu(),
    );
  }
}

class MainMenu extends StatefulWidget {
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  String name = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  _loadUserData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user').toString());

    if (user != null) {
      setState(() {
        name = user;
      });
    }
  }

  int _selectedNavbar = 2;
  final options = [
    HalamanStok(),
    HalamanAnalisis(),
    HalamanUtama(),
    HalamanVideo(),
    HalamanNews()
  ];

  void _changeSelectedNavBar(int index) {
    setState(() {
      _selectedNavbar = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Image.asset('assets/logo30x150.png', fit: BoxFit.scaleDown),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.notifications_none,
              color: Colors.black,
            ),
            onPressed: () {
              // _videos();
              // do something
            },
          ),
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.black,
            ),
            onPressed: () {
              logout();
              // do something
            },
          )
        ],
      ),
      body: Center(
        child: options.elementAt(_selectedNavbar),
      ),
      bottomNavigationBar: ConvexAppBar(
        items: [
          TabItem(
              icon: Icons.account_balance_wallet_outlined, title: 'Stok Pick'),
          TabItem(icon: Icons.analytics, title: 'Analisis'),
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.video_collection, title: 'Video'),
          TabItem(icon: Icons.announcement, title: 'News'),
        ],
        initialActiveIndex: _selectedNavbar,
        onTap: _changeSelectedNavBar,
        backgroundColor: Colors.white70,
        color: Colors.black87,
        activeColor: Colors.blue,
      ),
    );
  }

  void logout() async {
    var res = await Network().postData('/logout');
    var body = json.decode(res.body);
    print(body);
    if (body['success'] == 'true') {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.remove('user');
      localStorage.remove('token');
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    }
  }
}
