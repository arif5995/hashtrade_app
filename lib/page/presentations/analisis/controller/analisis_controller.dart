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
  var analisisModel = RxList<StokModel>([]);
  var detailAnalisis = <StokModel>[].obs;
  ScrollController scrollController =
      ScrollController(initialScrollOffset: 0.0, keepScrollOffset: true);
  int _currentPage = 1;

  @override
  void onInit() {
    super.onInit();
    getAnalisiByDateNow();
    loadMore();
  }

  @override
  void onClose() {
    super.onClose();
    scrollController.dispose();
    print('close');
  }

  void getAnalisis(BuildContext context) async {
    _currentPage = 0;
    loading = true;
    var res = await Network().getDataStock('/analisis/$_currentPage');
    var data = json.decode(res.body);
    print('STOK ${json.decode(res.body)}');
    print('STATUS ${res.statusCode}');
    if (res.statusCode == 200) {
      loading = false;
      update();

      analisisModel.assignAll((data as List).map((e) => StokModel.fromJson(e)));
      // analisisModel.value =
      //     (data as List).map((e) => StokModel.fromJson(e)).toList();
      print("DATA 1 ${analisisModel}");
    } else {
      loading = false;
      update();
      DialogHelper.warning(context,
              title: "Perhatian!",
              content: 'Analisi Kosong!',
              widget: TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text('Oke')))
          .show();
      print("DATA STOK ${res.body}");
    }
  }

  Future<void> refreshData() async {
    loading = true;
    await Future.delayed(Duration(seconds: 2));
    _currentPage += 1;
    var res = await Network().getDataStock('/analisis/$_currentPage');
    var data = json.decode(res.body);
    if (data != []) {
      analisisModel.addAll((data as List).map((e) => StokModel.fromJson(e)));
      update();
    } else {
      analisisModel.clear();
      _currentPage = 0;
      loading = false;
      update();
    }
    print("DATA 2 ${analisisModel}");
    loading = false;
  }

  loadMore() async {
    print("LOAD MORE");
    scrollController.addListener(() async {
      double offset = 0.9 * scrollController.position.maxScrollExtent;
      if (scrollController.position.pixels > offset) {
        loading = true;
        _currentPage += 1;
        var res = await Network().getDataStock('/analisis/$_currentPage');
        var data = json.decode(res.body);
        analisisModel.addAll((data as List).map((e) => StokModel.fromJson(e)));
        update();
        print("DATA 2 ${analisisModel}");
        loading = false;
      }
    });
  }

  void getDetailAnalisis(int id, BuildContext context) async {
    print(id);
    var res = await Network().getData("/analisis-detail/$id");
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
