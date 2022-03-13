import 'package:get/get.dart';
import 'package:hastrade/page/presentations/password/password_controller.dart';

class PasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PasswordController>(() => PasswordController());
  }
}
