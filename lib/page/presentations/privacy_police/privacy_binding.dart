import 'package:get/get.dart';
import 'package:hastrade/page/presentations/privacy_police/privacy_controller.dart';

class PrivacyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PrivacyController>(() => PrivacyController());
  }
}
