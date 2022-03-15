import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hastrade/common/helper/dialog_helper.dart';
import 'package:hastrade/page/data/models/stok_model.dart';
import 'package:hastrade/page/presentations/stock/binding/stock_binding.dart';
import 'package:hastrade/page/presentations/stock/stock_detail_page.dart';
import 'package:stylish_dialog/stylish_dialog.dart';

import '../../../../network/api.dart';

class StockController extends GetxController {
  var data = [].obs;
  var loading = false;
  List<StokModel> stokModel = <StokModel>[].obs;
  var stokModelfront = <StokModel>[].obs;
  var analisisModelfront = <StokModel>[].obs;
  var detailStok = <StokModel>[].obs;
  var loadImg = false.obs;
  late StylishDialog _dialog;

  @override
  void onInit() {
    print('GET STOK');
    getStock();
    getStokByDateNow();
    super.onInit();
  }

  void getStock() async {
    loading = true;
    var res = await Network().getDataStock('/stok');
    var data = json.decode(res.body);
    print('STOK ${json.decode(res.body)}');
    print('STATUS ${res.statusCode}');
    if (res.statusCode == 200) {
      loading = false;
      update();
      stokModel = (data as List).map((e) => StokModel.fromJson(e)).toList();
      print("DATA 1 ${stokModel}");
    } else {
      loading = false;
      update();
      print("DATA STOK ${res.body}");
    }
  }

  void getDetailStok(int id, BuildContext context) async {
    print(id);
    var res = await Network().getData("/stok/$id");
    var bodi = json.decode(res.body);
    DialogHelper.loading(context, content: 'Mohon menunggu').show();
    if (bodi != []) {
      detailStok.value =
          (bodi as List).map((element) => StokModel.fromJson(element)).toList();
      // detailStok.
      if (detailStok.isNotEmpty) {
        DialogHelper.loading(context, content: 'Mohon menunggu').dismiss();
        Get.to(StockDetailPage(), binding: StockBinding());
      }
    }
  }

  void getStokByDateNow() async {
    print("tess");
    try {
      var res = await Network().getDataStock('/stok-front');
      var data = json.decode(res.body);

      if (res.statusCode == 200 && data['success'] == 'true') {
        loading = false;
        update();

        stokModelfront.value = (data["message"] as List)
            .map((e) => StokModel.fromJson(e))
            .toList();
        print("stok ${stokModelfront.length}");
      } else {
        loading = false;
        update();
        print("DATA STOK ${res.body}");
      }
    } catch (e) {
      print("DATA STOK KOSONG $e");
    }
  }
}
