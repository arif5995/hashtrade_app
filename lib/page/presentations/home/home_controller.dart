import 'dart:convert';

import 'package:get/get.dart';
import 'package:hastrade/page/data/models/qty_analis_dan_stok.dart';

import '../../../network/api.dart';

class HomeController extends GetxController {
  var qtyStok = "".obs;
  var qtyAnalis = "".obs;
  var loading = false.obs;
  List<QtyAnalisStok> qtyStokAnalis = <QtyAnalisStok>[].obs;

  @override
  void onInit() {
    super.onInit();
    getQtyAnalisDanStock();
  }

  void getQtyAnalisDanStock() async {
    loading.value = true;
    var res = await Network().getData('/jumlah-stok');
    var data = json.decode(res.body);

    if (data['success'] == "true") {
      loading.value = false;
      qtyStokAnalis = (data['message'] as List)
          .map((e) => QtyAnalisStok.fromJson(e))
          .toList();
      qtyStok.value = qtyStokAnalis[0].stok!;
      qtyAnalis.value = qtyStokAnalis[1].analisis!;
      print("STOK $qtyStok.value");
    } else {
      loading.value = false;
      print('STOK KOSONG');
    }
  }
}
