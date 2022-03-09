import 'package:get/get.dart';
import 'package:hastrade/page/presentations/videos/videos_controller.dart';

class VideosBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VideosController>(() => VideosController());
  }
}
