import 'package:get/get.dart';
import 'package:hastrade/page/presentations/profil/profil_controller.dart';

class ProfilBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfilController>(() => ProfilController());
  }
}
