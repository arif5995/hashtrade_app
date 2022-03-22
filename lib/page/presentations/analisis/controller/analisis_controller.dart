import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hastrade/page/data/models/stok_model.dart';
import 'package:hastrade/page/presentations/analisis/binding/analisis_binding.dart';
import 'package:stylish_dialog/stylish_dialog.dart';

import '../../../../common/helper/dialog_helper.dart';
import '../../../../network/api.dart';
import '../analisis_detail_page.dart';

class AnalisisController extends GetxController {
  var data = [].obs;
  var loading = false;
  var analisisModel = <StokModel>[].obs;
  var analisisModelfront = <StokModel>[].obs;

  var detailAnalisis = <StokModel>[].obs;
  var loadImg = false.obs;
  late StylishDialog _dialog;
  int _currentPage = 1;

  @override
  void onInit() {
    getAnalisisByDateNow();
    super.onInit();
  }

  Future refreshAnalisis() async {
    loading = true;
    analisisModel.clear();
    _currentPage += 20;
    var res = await Network().getDataStock('/analisis/$_currentPage');
    var data = json.decode(res.body);
    if ((data as List).isNotEmpty) {
      analisisModel.addAll((data as List).map((e) => StokModel.fromJson(e)));
      update();
    } else {
      analisisModel.clear();
      _currentPage = 0;
      var res = await Network().getDataStock('/analisis/$_currentPage');
      var data = json.decode(res.body);
      analisisModel.addAll((data as List).map((e) => StokModel.fromJson(e)));
      loading = false;
      update();
    }
    loading = false;
  }

  void getAnalisis(BuildContext context) async {
    loading = true;
    _currentPage = 0;
    var res = await Network().getDataStock('/analisis/0');
    var data = json.decode(res.body);
    if (res.statusCode == 200) {
      loading = false;
      update();
      analisisModel.assignAll((data as List).map((e) => StokModel.fromJson(e)));
    } else {
      loading = false;
      update();
      DialogHelper.warning(context,
              title: "Perhatian!",
              content: 'Analisis Kosong!',
              widget: TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text('Oke')))
          .show();
    }
  }

  void getDetailAnalisis(int id, BuildContext context) async {
    print(id);
    var res = await Network().getData("/analisis-detail/$id");
    var bodi = json.decode(res.body);
    DialogHelper.loading(context, content: 'Mohon menunggu').show();
    if (bodi != []) {
      detailAnalisis.value =
          (bodi as List).map((element) => StokModel.fromJson(element)).toList();
      // detailAnalisis.
      if (detailAnalisis.isNotEmpty) {
        DialogHelper.loading(context, content: 'Mohon menunggu').dismiss();
        Get.to(AnalisisDetailPage(), binding: AnalisisBinding());
      }
    }
  }

  void getAnalisisByDateNow() async {
    try {
      var res = await Network().getDataStock('/analisis-front');
      var data = json.decode(res.body);

      if (res.statusCode == 200 && data['success'] == 'true') {
        loading = false;
        update();

        analisisModelfront.value = (data["message"] as List)
            .map((e) => StokModel.fromJson(e))
            .toList();
        print("Analisis ${analisisModelfront.length}");
      } else {
        loading = false;
        update();
      }
    } catch (e) {
      print("DATA ANALISIS KOSONG $e");
    }
  }
}
