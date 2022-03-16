import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  var _currentPage = 0;

  @override
  void onInit() {
    super.onInit();
  }

  void getDataNews(BuildContext context) async {
    loading = true;
    var res = await Network().getDataStock('/blog/0');
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
      DialogHelper.warning(context,
              title: "Perhatian!",
              content: 'News Kosong!',
              widget: TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text('Oke')))
          .show();
      print("DATA NEWS ${res.body}");
    }
  }

  void getDetailNews(int id, BuildContext context) async {
    loading = true;
    print(id);
    var res = await Network().getData("/blog-detail/$id");
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

  Future refreshNews() async {
    loading = true;
    await Future.delayed(Duration(seconds: 2));
    _currentPage += 1;
    var res = await Network().getDataStock('/blog/$_currentPage');
    var data = json.decode(res.body);
    if (data != []) {
      loading = false;
      newsModel.addAll((data as List).map((e) => StokModel.fromJson(e)));
      update();
    } else {
      newsModel.clear();
      var res = await Network().getDataStock('/blog/0');
      var data = json.decode(res.body);
      newsModel.addAll((data as List).map((e) => StokModel.fromJson(e)));
      loading = false;
      update();
    }
    update();
    print("DATA 2 $_currentPage");
  }
}
