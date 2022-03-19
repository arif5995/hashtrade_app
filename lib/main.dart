import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hastrade/page/presentations/dashboard/dashboard_binding.dart';
import 'package:hastrade/page/presentations/dashboard/dashboard_page.dart';
import 'package:hastrade/page/presentations/login/login_binding.dart';
import 'package:hastrade/page/presentations/login/login_page.dart';
import 'package:hastrade/page/presentations/onboarding/oanboarding_page.dart';
import 'package:hastrade/page/presentations/onboarding/onboarding_binding.dart';
import 'package:hastrade/page/presentations/register/register_binding.dart';
import 'package:hastrade/page/presentations/register/register_page.dart';
import 'package:hastrade/page/presentations/splash/splash_binding.dart';
import 'package:hastrade/page/presentations/splash/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  String? token = await FirebaseMessaging.instance.getToken();
  print("FirebaseMessaging token: $token");

  runApp(NewMyApp());
}

class NewMyApp extends StatefulWidget {
  const NewMyApp({Key? key}) : super(key: key);

  @override
  _NewMyAppState createState() => _NewMyAppState();
}

class _NewMyAppState extends State<NewMyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: SplashPage.routeName,
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
            name: DashboardPage.routeName,
            page: () => DashboardPage(),
            binding: DashboardBinding()),
        GetPage(
            name: LoginPage.routName,
            page: () => LoginPage(),
            binding: LoginBinding()),
        GetPage(
            name: RegisterPage.routeName,
            page: () => RegisterPage(),
            binding: RegisterBinding()),
      ],
    );
  }
}
