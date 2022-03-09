import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hastrade/page/presentations/dashboard/dashboard_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stylish_dialog/stylish_dialog.dart';

import '../../../network/api.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  var email = ''.obs;
  var password = ''.obs;
  var msg = ''.obs;

  void Login(BuildContext context) async {
    isLoading.value = true;
    var data = {'email': email.value, 'password': password.value};

    var res = await Network().auth(data, '/login');
    var body = json.decode(res.body);
    if (body['success'] == 'true') {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', json.encode(body['token']));
      localStorage.setString('user', json.encode(body['user']));
      isLoading.value = false;
      Get.offAllNamed(DashboardPage.routeName);
    } else {
      print(body['message']);
      msg.value = body['message'];
      StylishDialog(
        context: context,
        alertType: StylishDialogType.WARNING,
        titleText: 'Pesan',
        contentText: body['message'],
      ).show();
      isLoading.value = false;
    }
  }
}
