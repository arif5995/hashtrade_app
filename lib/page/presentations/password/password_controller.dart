import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hastrade/common/helper/dialog_helper.dart';
import 'package:hastrade/page/presentations/password/new_password_page.dart';
import 'package:hastrade/page/presentations/password/password_binding.dart';
import 'package:hastrade/page/presentations/profil/profil_controller.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stylish_dialog/stylish_dialog.dart';

import '../../../network/api.dart';
import '../login/login_page.dart';
import 'forgot_password_verirfy_page.dart';

class PasswordController extends GetxController {
  final profilController = Get.put(ProfilController());
  var pinSukses = false.obs;
  var passLama = "".obs;
  var passBaru = "".obs;
  var passBaruUlang = "".obs;
  var proses = false.obs;
  var result = false.obs;
  var noTelpVerify = "".obs;
  var time = "00".obs;
  var _startTime = 60.obs;
  var resendCode = false.obs;
  late Timer _timer;
  var visible = true.obs;
  var visibleBaru = true.obs;
  var visibleUlang = true.obs;

  @override
  void onInit() {
    super.onInit();
    print("TIMER");
  }

  void hidePass() {
    visible.value = !visible.value;
    print(visible);
  }

  void hidePassbaru() {
    visibleBaru.value = !visibleBaru.value;
    print(visibleBaru);
  }

  void hidePassbaruUlang() {
    visibleUlang.value = !visibleUlang.value;
    print(visibleUlang);
  }

  void timerKode() {
    _startTime.value = 60;
    Timer.periodic(Duration(seconds: 1), (timer) {
      print("TIMER 1 ${_startTime.value}");
      if (_startTime.value == 0) {
        resendCode.value = true;
        print(time.value);
        timer.cancel();
      } else {
        _startTime.value--;
        if (_startTime.value < 10) {
          time.value = "0" + _startTime.toString();
          print("TIMER 2 ${_startTime.value}");
        } else {
          time.value = _startTime.toString();
          print("TIMER 3 ${_startTime.value}");
        }
      }
    });
  }

  void verifyKode() async {}

  void resendCoder(BuildContext context) async {
    DialogHelper.loading(context, content: 'Mohon menunggu').show();
    var data = {'no_hp': "62${noTelpVerify.value}"};

    print('NO $data');
    var res = await Network().postDataParam(data, '/lupa-password');
    var body = json.decode(res.body);

    print('NO TELP 1 $body ${noTelpVerify.value}');
    if (res.statusCode == 200 && body['success'] == 'true') {
      DialogHelper.loading(context, content: 'Mohon menunggu').dismiss();
      print('NO TELP $body ${noTelpVerify.value}');
      StylishDialog(
        context: context,
        alertType: StylishDialogType.SUCCESS,
        titleText: 'Perhatian',
        contentText: body['message'],
        confirmButton: TextButton(
          onPressed: () {
            timerKode();
            Get.back();
          },
          child: Text('Ya'),
        ),
      ).show();
    } else {
      DialogHelper.loading(context, content: 'Mohon menunggu').dismiss();
      StylishDialog(
        context: context,
        alertType: StylishDialogType.SUCCESS,
        titleText: 'Perhatian',
        contentText: body['message'],
        confirmButton: TextButton(
          onPressed: () {
            timerKode();
          },
          child: Text('Ya'),
        ),
      ).show();
      print('GAGAL SIMPAN NO');
    }
  }

  void saveNoTelp(BuildContext context) async {
    proses.value = true;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('no_telp_verify', noTelpVerify.value);
    String no = preferences.getString('no_telp_verify')!;
    var data = {'no_hp': "62${noTelpVerify.value}"};
    try {
      var res = await Network().postDataParam(data, '/lupa-password');
      var body = json.decode(res.body);

      print('NO TELP 1 $body ${noTelpVerify.value}');
      if (res.statusCode == 200 && body['success'] == 'true') {
        proses.value = false;
        print('NO TELP $body ${noTelpVerify.value}');
        StylishDialog(
          context: context,
          alertType: StylishDialogType.SUCCESS,
          titleText: 'Perhatian',
          contentText: body['message'],
          confirmButton: TextButton(
            onPressed: () {
              Get.to(ForgotPasswordVerirfyPage(), binding: PasswordBinding());
              timerKode();
            },
            child: Text('Ya'),
          ),
        ).show();
      } else {
        proses.value = false;
        StylishDialog(
          context: context,
          alertType: StylishDialogType.WARNING,
          titleText: 'Perhatian',
          contentText: body['message'],
          confirmButton: TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text('Ya'),
          ),
        ).show();
        print('GAGAL SIMPAN NO');
      }
    } catch (e) {
      proses.value = false;
      StylishDialog(
        context: context,
        alertType: StylishDialogType.WARNING,
        titleText: 'Perhatian',
        contentText: 'Cek Ulang',
        confirmButton: TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text('Ya'),
        ),
      ).show();
    }
  }

  void sendPin(String val, BuildContext context,
      OtpFieldController otpFieldController) async {
    DialogHelper.loading(context, content: 'Mohon menunggu').show();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('kode_aktivasi', val);
    var data = {'kode_aktivasi': val, 'no_hp': "62" + noTelpVerify.value};
    try {
      var res = await Network().postDataParam(data, '/verifikasi-kode');
      var body = json.decode(res.body);
      print('PIN ${body} dan ${data} ');
      if (res.statusCode == 200 && body['success'] == 'true') {
        pinSukses.value = true;
        DialogHelper.loading(context, content: 'Mohon menunggu').dismiss();
        Get.to(NewPasswordPage(), binding: PasswordBinding());
      } else {
        DialogHelper.loading(context, content: 'Mohon menunggu').dismiss();
        StylishDialog(
          context: context,
          alertType: StylishDialogType.WARNING,
          titleText: 'Perhatian',
          contentText: 'Cek Kode Aktivasi',
          confirmButton: TextButton(
            onPressed: () {
              Get.back();
              otpFieldController.clear();
            },
            child: Text('Ya'),
          ),
        ).show();
        print('GAGAL PIN');
      }
      pinSukses.value = false;
    } catch (e) {
      print(e);
    }
  }

  void forgotPassword(BuildContext context) async {
    proses.value = true;
    DialogHelper.loading(context, content: "Update password").show();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var data = {
      'no_hp': "62${preferences.getString('no_telp_verify')}",
      'kode_aktivasi': preferences.getString('kode_aktivasi'),
      'password_baru_ulang': passBaruUlang.value,
      'password_baru': passBaru.value,
    };

    try {
      var res = await Network().postDataParam(data, '/buat-password');
      var body = json.decode(res.body);

      if (res.statusCode == 200 && body['success'] == 'true') {
        print('FORGOT $body');
        proses.value = false;
        DialogHelper.loading(context, content: "Update password").dismiss();
        DialogHelper.sukses(context,
                content: "Update password berhasil",
                widget: TextButton(
                    onPressed: () {
                      Get.offAndToNamed(LoginPage.routName);
                    },
                    child: Text("Oke")))
            .show();
      } else {
        proses.value = false;
        DialogHelper.loading(context, content: "Update password").dismiss();
        DialogHelper.warning(context,
                title: 'Perhatian',
                content: "Cek kembali password anda",
                widget: TextButton(
                    onPressed: () {
                      Get.back();
                      DialogHelper.loading(context, content: "Update password")
                          .dismiss();
                    },
                    child: Text("Oke")))
            .show();
      }
      print('GAGAL PASS');
    } catch (e) {
      proses.value = false;
      DialogHelper.loading(context, content: "Update password").dismiss();
      DialogHelper.error(context,
              title: 'Perhatian',
              content: "Terjadi kesalahan!",
              widget: TextButton(
                  onPressed: () {
                    Get.back();
                    DialogHelper.loading(context, content: "Update password")
                        .dismiss();
                  },
                  child: Text("Oke")))
          .show();
    }
  }

  void changePassword(BuildContext context) async {
    proses.value = true;
    DialogHelper.loading(context, content: 'Mohon menunggu').show();
    var data = {
      'password_lama': passLama.value,
      'password_baru': passBaru.value,
      'password_baru_ulang': passBaruUlang.value
    };

    var res = await Network().postUpdatePass(data, '/update-password');
    var body = json.decode(res.body);

    if (body['success'] == 'true') {
      print('PAS ${body}');
      DialogHelper.loading(context, content: 'Mohon menunggu').dismiss();
      proses.value = false;
      result.value = true;
      DialogHelper.sukses(context,
              title: "Terima kasih",
              content: 'Password berhasil diubah',
              widget: TextButton(
                  onPressed: () {
                    Get.back();
                    Get.back();
                    profilController.getDataProfil();
                  },
                  child: Text('Oke')))
          .show();
    } else {
      proses.value = false;
      result.value = false;
      DialogHelper.loading(context, content: 'Mohon menunggu').dismiss();
      DialogHelper.warning(context,
              title: "Perhatian",
              content: 'Cek Kembali Password Anda',
              widget: TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text('Oke')))
          .show();
      print('GAGAL UPDATE');
    }
    result.value = false;
    update();
  }
}
