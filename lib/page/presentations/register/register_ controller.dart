import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hastrade/page/presentations/login/login_page.dart';
import 'package:stylish_dialog/stylish_dialog.dart';

import '../../../network/api.dart';

class RegisterController extends GetxController {
  var firstname = "".obs;
  var lastname = "".obs;
  var email = "".obs;
  var noTelp = "".obs;
  var password = "".obs;
  var checkBox = false.obs;
  var msg = "".obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkBox.value = false;
    print("CEK ${checkBox.value}");
  }

  void cekBox(bool val) {
    checkBox.value = val;
  }

  void register(BuildContext context) async {
    isLoading.value = true;
    var data = {
      'firstname': firstname.value,
      'lastname': lastname.value,
      'email': email.value,
      'mobile': "62" + noTelp.value,
      'password': password.value
    };

    var res = await Network().register(data, '/register');
    var body = json.decode(res.body);

    print('NO TELP ${data}');
    if (body['success'] == 'true') {
      isLoading.value = false;
      print('REGISTER 1 ${body['message']}');
      StylishDialog(
        context: context,
        alertType: StylishDialogType.WARNING,
        titleText: 'Perhatian',
        contentText: body['message'],
        confirmButton: TextButton(
          onPressed: () {
            Get.toNamed(LoginPage.routName);
          },
          child: Text('Ya'),
        ),
      ).show();
    } else {
      isLoading.value = false;
      print('REGISTER 2 ${body['message']}');
      msg.value = "${body['email']}  ${body['mobile']}";
      StylishDialog(
        context: context,
        alertType: StylishDialogType.WARNING,
        titleText: 'Pesan',
        contentText: msg.value,
      ).show();
    }
  }
}
