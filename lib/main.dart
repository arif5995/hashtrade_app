import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hastrade/page/main_menu.dart';
import 'package:hastrade/page/presentations/login/login_binding.dart';
import 'package:hastrade/page/presentations/login/login_page.dart';
import 'package:hastrade/page/presentations/onboarding/oanboarding_page.dart';
import 'package:hastrade/page/presentations/onboarding/onboarding_binding.dart';
import 'package:hastrade/page/presentations/register/register_binding.dart';
import 'package:hastrade/page/presentations/register/register_page.dart';
import 'package:hastrade/page/presentations/splash/splash_binding.dart';
import 'package:hastrade/page/presentations/splash/splash_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class NewMyApp extends StatelessWidget {
  const NewMyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: [
        GetPage(
            name: SplashPage.routeName,
            page: () => SplashPage(),
            binding: SplashBinding()),
        GetPage(
            name: OnBoardingPage.routeName,
            page: () => OnBoardingPage(),
            binding: OnboardingBinding()),
        GetPage(
            name: LoginPage.routName,
            page: () => LoginPage(),
            binding: LoginBinding()),
        GetPage(
            name: RegisterPage.routeName,
            page: () => RegisterPage(),
            binding: RegisterBinding())
      ],
    );
  }
}

class MyApp extends StatelessWidget {
  static final String title = 'HasTrade';

  @override
  Widget build(BuildContext context) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(primarySwatch: Colors.blue),
        home: CheckAuth(),
      );
}

class CheckAuth extends StatefulWidget {
  @override
  _CheckAuthState createState() => _CheckAuthState();
}

class _CheckAuthState extends State<CheckAuth> {
  bool isAuth = false;

  @override
  void initState() {
    super.initState();
    _checkIfLoggedIn();
  }

  void _checkIfLoggedIn() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    if (token != null) {
      if (mounted) {
        setState(() {
          isAuth = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (isAuth) {
      child = MyHomePage();
    } else {
      child = OnBoardingPage();
    }

    return Scaffold(
      body: child,
    );
  }
}
