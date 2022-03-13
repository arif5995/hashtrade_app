import 'package:get/get.dart';
import 'package:hastrade/page/presentations/stock/controller/stock_controller.dart';

class StockBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StockController>(() => StockController());
  }
}
