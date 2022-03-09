import 'package:get/get.dart';
import 'package:hastrade/page/presentations/register/register_%20controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(() => RegisterController());
  }
}
