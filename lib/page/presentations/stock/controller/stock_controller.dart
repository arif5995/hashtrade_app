import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  var stokModel = <StokModel>[].obs;
  var stokModelfront = <StokModel>[].obs;
  var analisisModelfront = <StokModel>[].obs;
  var detailStok = <StokModel>[].obs;
  var loadImg = false.obs;
  late StylishDialog _dialog;
  var _currentPage = 1;

  @override
  void onInit() {
    print('GET STOK');
    getStokByDateNow();
    super.onInit();
  }

  Future refreshStok() async {
    loading = true;
    stokModel.clear();
    _currentPage += 20;
    var res = await Network().getDataStock('/stok/$_currentPage');
    var data = json.decode(res.body);
    print("stok $data");
    if ((data as List).isNotEmpty) {
      stokModel.addAll((data as List).map((e) => StokModel.fromJson(e)));
      update();
      print("stok 1 $_currentPage");
    } else {
      stokModel.clear();
      _currentPage = 0;
      var res = await Network().getDataStock('/stok/$_currentPage');
      var data = json.decode(res.body);
      stokModel.addAll((data as List).map((e) => StokModel.fromJson(e)));
      loading = false;
      update();
      print("DATA STOK $detailStok");
    }
    print("DATA 3 $_currentPage " "${stokModel}");
    loading = false;
  }

  void getStock(BuildContext context) async {
    loading = true;
    _currentPage = 0;
    var res = await Network().getDataStock('/stok/0');
    var data = json.decode(res.body);
    print('STOK ${json.decode(res.body)}');
    print('STATUS ${res.statusCode}');
    if (res.statusCode == 200) {
      loading = false;
      update();
      stokModel.assignAll((data as List).map((e) => StokModel.fromJson(e)));
      print("DATA 1 ${stokModel}");
    } else {
      loading = false;
      update();
      DialogHelper.warning(context,
              title: "Perhatian!",
              content: 'Stock Pick Kosong!',
              widget: TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text('Oke')))
          .show();
      print("DATA STOK ${res.body}");
    }
  }

  void getDetailStok(int id, BuildContext context) async {
    print(id);
    var res = await Network().getData("/stok-detail/$id");
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
