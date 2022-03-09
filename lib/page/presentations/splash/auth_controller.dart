import 'dart:async';

import 'package:get/get.dart';
import 'package:hastrade/page/presentations/dashboard/dashboard_page.dart';
import 'package:hastrade/page/presentations/onboarding/oanboarding_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  var isVisible = false.obs;
  var token = "".obs;

  @override
  void onInit() {
    super.onInit();

    Future.delayed(Duration(milliseconds: 10), () {
      isVisible.value =
          true; // Now it is showing fade effect and navigating to Login page
    });

    changeVisible();
  }

  void changeVisible() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token.value = localStorage.getString('token') ?? "";
    print("TOKEN ${token.value}");
    if (token.value != "") {
      Future.delayed(const Duration(milliseconds: 2000),
          () => Get.offAndToNamed(DashboardPage.routeName));
    } else {
      Future.delayed(const Duration(milliseconds: 2000), () {
        Get.off(OnBoardingPage());
      });
    }
  }
}
