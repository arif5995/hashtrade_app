import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hastrade/page/presentations/news/binding/news_binding.dart';
import 'package:hastrade/page/presentations/news/news_detail_page.dart';

import '../../../../common/helper/dialog_helper.dart';
import '../../../../network/api.dart';
import '../../../data/models/stok_model.dart';

class NewsController extends GetxController {
  var loading = false;
  List<StokModel> newsModel = <StokModel>[].obs;
  var newsDetailModel = <StokModel>[].obs;

  @override
  void onInit() {
    getDataNews();
    super.onInit();
  }

  void getDataNews() async {
    loading = true;
    var res = await Network().getDataStock('/blog');
    var data = json.decode(res.body);
    print('news ${json.decode(res.body)}');
    print('STATUS ${res.statusCode}');
    if (res.statusCode == 200) {
      loading = false;
      update();
      newsModel = (data as List).map((e) => StokModel.fromJson(e)).toList();
      print("DATA 1 ${newsModel}");
    } else {
      loading = false;
      update();
      print("DATA NEWS ${res.body}");
    }
  }

  void getDetailNews(int id, BuildContext context) async {
    loading = true;
    print(id);
    var res = await Network().getData("/blog/$id");
    var bodi = json.decode(res.body);
    DialogHelper.loading(context, content: 'Mohon menunggu').show();
    if (bodi != []) {
      newsDetailModel.value =
          (bodi as List).map((element) => StokModel.fromJson(element)).toList();
      // detailStok.
      if (newsDetailModel.isNotEmpty) {
        loading = false;
        update();
        DialogHelper.loading(context, content: 'Mohon menunggu').dismiss();
        Get.to(NewsDetailPage(), binding: NewsBinding());
      }
    }
  }
}
