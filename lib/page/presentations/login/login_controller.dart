import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hastrade/common/helper/constant_helper.dart';
import 'package:hastrade/common/helper/dialog_helper.dart';
import 'package:hastrade/page/presentations/dashboard/dashboard_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../network/api.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  var email = ''.obs;
  var password = ''.obs;
  var msg = ''.obs;

  void Login(BuildContext context) async {
    isLoading.value = true;
    DialogHelper.loading(context, content: 'Sedang Login...').show();
    var data = {'email': email.value, 'password': password.value};
    try {
      var res = await Network().auth(data, '/login');
      var body = json.decode(res.body);
      if (body['success'] == 'true') {
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        localStorage.setString(
            ConstantHelper.TOKEN, json.encode(body['token']));
        localStorage.setString(
            ConstantHelper.FIRSTNAME, json.encode(body['firstname']));
        localStorage.setString(
            ConstantHelper.LASTNAME, json.encode(body['lastname']));
        localStorage.setString(
            ConstantHelper.IMAGE_USER, json.encode(body['image']));
        localStorage.setString('user', json.encode(body['user']));
        print('TOKEN ${localStorage.getString('token')}');
        isLoading.value = false;
        Get.offAllNamed(DashboardPage.routeName);
      } else {
        print(body['message']);
        msg.value = body['message'];
        DialogHelper.warning(context,
                content: "Cek Email dan Password", title: "Perhatian")
            .show();
        DialogHelper.loading(context, content: 'Sedang Login...').dismiss();
        isLoading.value = false;
      }
    } catch (e) {
      DialogHelper.error(context, title: "Terjadi Kesalahan!").show();
      DialogHelper.loading(context, content: 'Sedang Login...').dismiss();
    }
  }
}
