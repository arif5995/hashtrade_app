import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hastrade/page/presentations/analisis/analisis_binding.dart';
import 'package:hastrade/page/presentations/analisis/analisis_page.dart';
import 'package:hastrade/page/presentations/home/home_page.dart';
import 'package:hastrade/page/presentations/login/login_page.dart';
import 'package:hastrade/page/presentations/news/news_binding.dart';
import 'package:hastrade/page/presentations/news/news_page.dart';
import 'package:hastrade/page/presentations/stock/stock_binding.dart';
import 'package:hastrade/page/presentations/stock/stock_page.dart';
import 'package:hastrade/page/presentations/videos/videos_binding.dart';
import 'package:hastrade/page/presentations/videos/videos_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../network/api.dart';
import '../home/home_binding.dart';

class DashboardController extends GetxController {
  static DashboardController get to => Get.find();
  var currentIndex = 2.obs;
  var namaorang = "";
  var email = "";

  final pages = <String>[
    StockPage.routeName,
    AnalisisPage.routeName,
    HomePage.routeName,
    VideosPage.routeName,
    NewsPage.routeName
  ];

  @override
  void onInit() {
    super.onInit();
    getProfil();
    print("GET PROFIL");
  }

  void changePage(int index) {
    currentIndex.value = index;
    Get.toNamed(pages[index], id: 1);
  }

  Route? onGenerateRoute(RouteSettings settings) {
    if (settings.name == HomePage.routeName) {
      return GetPageRoute(
        settings: settings,
        page: () => HomePage(),
        binding: HomeBinding(),
      );
    }

    if (settings.name == StockPage.routeName) {
      return GetPageRoute(
        settings: settings,
        page: () => StockPage(),
        binding: StockBinding(),
      );
    }

    if (settings.name == AnalisisPage.routeName) {
      return GetPageRoute(
        settings: settings,
        page: () => AnalisisPage(),
        binding: AnalisisBinding(),
      );
    }

    if (settings.name == VideosPage.routeName) {
      return GetPageRoute(
        settings: settings,
        page: () => VideosPage(),
        binding: VideosBinding(),
      );
    }

    if (settings.name == NewsPage.routeName) {
      return GetPageRoute(
        settings: settings,
        page: () => NewsPage(),
        binding: NewsBinding(),
      );
    }

    return null;
  }

  void logout() async {
    print('LOGOUT');
    var res = await Network().postData('/logout');
    var body = json.decode(res.body);
    print(body);
    if (body['success'] == 'true') {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.remove('user');
      localStorage.remove('token');
      Get.offAllNamed(LoginPage.routName);
    }
  }

  void getProfil() async {
    var res = await Network().getData('/get-profile');
    var body = json.decode(res.body);

    print("profil $body");
    if (body != null) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      // localStorage.setString("firstname", );
      // localStorage.setString("lastname", body['lastname']);
      localStorage.setString("email", body['email']);

      /// get data
      ///
      namaorang = body['firstname'] + " " + body['lastname'];
      email = body['email'];
      update();

      print("profil 1 ${namaorang}");
    } else {
      print("profil ${body}");
    }
  }
}
