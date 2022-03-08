import 'package:get/get.dart';
import 'package:hastrade/page/presentations/splash/auth_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
  }
}
