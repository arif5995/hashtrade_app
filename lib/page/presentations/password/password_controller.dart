import 'package:get/get.dart';

class PasswordController extends GetxController {
  var pinSukses = false.obs;

  void sendPin() {
    pinSukses.value = true;
  }
}
