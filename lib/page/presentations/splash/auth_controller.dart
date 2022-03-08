import 'dart:async';

import 'package:get/get.dart';
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
    token.value = localStorage.getString('token')!;
    if (token.isNotEmpty) {
      Future.delayed(const Duration(milliseconds: 2000), () {
        print("HOME PAGE");
        // Get.off(HomePage());
      });
    } else {
      Future.delayed(const Duration(milliseconds: 2000), () {
        Get.off(OnBoardingPage());
      });
    }
  }
}
