import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hastrade/page/data/models/stok_model.dart';
import 'package:hastrade/page/presentations/analisis/binding/analisis_binding.dart';

import '../../../../common/helper/dialog_helper.dart';
import '../../../../network/api.dart';
import '../analisis_detail_page.dart';

class AnalisisController extends GetxController {
  var loading = false;
  var analisisModelfront = <StokModel>[].obs;
  var analisisModel = <StokModel>[].obs;
  var detailAnalisis = <StokModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getAnalisiByDateNow();
    getAnalisis();
  }

  void getAnalisis() async {
    loading = true;
    var res = await Network().getDataStock('/analisis');
    var data = json.decode(res.body);
    print('STOK ${json.decode(res.body)}');
    print('STATUS ${res.statusCode}');
    if (res.statusCode == 200) {
      loading = false;
      update();
      analisisModel.value =
          (data as List).map((e) => StokModel.fromJson(e)).toList();
      print("DATA 1 ${analisisModel}");
    } else {
      loading = false;
      update();
      print("DATA STOK ${res.body}");
    }
  }

  void getDetailAnalisis(int id, BuildContext context) async {
    print(id);
    var res = await Network().getData("/analisis/$id");
    var bodi = json.decode(res.body);
    DialogHelper.loading(context, content: 'Mohon menunggu').show();
    if (bodi != []) {
      detailAnalisis.value =
          (bodi as List).map((element) => StokModel.fromJson(element)).toList();
      // detailStok.
      if (detailAnalisis.isNotEmpty) {
        DialogHelper.loading(context, content: 'Mohon menunggu').dismiss();
        Get.to(AnalisisDetailPage(), binding: AnalisisBinding());
      }
    }
  }

  void getAnalisiByDateNow() async {
    loading = true;
    try {
      var res = await Network().getDataStock('/analisis-front');
      var data = json.decode(res.body);

      if (res.statusCode == 200 && data['success'] == 'true') {
        analisisModelfront.value = (data["message"] as List)
            .map((e) => StokModel.fromJson(e))
            .toList();
        loading = false;
        update();
        print("analisis ${analisisModelfront.length}");
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
