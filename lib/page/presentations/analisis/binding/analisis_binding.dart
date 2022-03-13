import 'package:get/get.dart';

import '../controller/analisis_controller.dart';

class AnalisisBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AnalisisController>(() => AnalisisController());
  }
}
