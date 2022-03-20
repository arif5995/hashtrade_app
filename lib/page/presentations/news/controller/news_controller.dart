import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hastrade/page/presentations/news/binding/news_binding.dart';
import 'package:hastrade/page/presentations/news/news_detail_page.dart';
import 'package:stylish_dialog/stylish_dialog.dart';
import '../../../../common/helper/dialog_helper.dart';
import '../../../../network/api.dart';
import '../../../data/models/stok_model.dart';

class NewsController extends GetxController {
  var data = [].obs;
  var loading = false;
  var newsModel = <StokModel>[].obs;

  var detailNews = <StokModel>[].obs;
  var loadImg = false.obs;
  late StylishDialog _dialog;
  int _currentPage = 1;

  @override
  void onInit() {
    print('GET NEWS');
    //getAnalisisByDateNow();
    super.onInit();
  }

  Future refreshNews() async {
    loading = true;
    newsModel.clear();
    _currentPage += 20;
    var res = await Network().getDataStock('/blog/$_currentPage');
    var data = json.decode(res.body);
    print("News $data");
    if ((data as List).isNotEmpty) {
      newsModel.addAll((data as List).map((e) => StokModel.fromJson(e)));
      update();
      print("news 1 $_currentPage");
    } else {
      newsModel.clear();
      _currentPage = 0;
      var res = await Network().getDataStock('/blog/$_currentPage');
      var data = json.decode(res.body);
      newsModel.addAll((data as List).map((e) => StokModel.fromJson(e)));
      loading = false;
      update();
      print("DATA NEWS $detailNews");
    }
    print("DATA 3 $_currentPage " "${newsModel}");
    loading = false;
  }

  void getNews(BuildContext context) async {
    loading = true;
    _currentPage = 0;
    var res = await Network().getDataStock('/blog/0');
    var data = json.decode(res.body);
    print('NEWS ${json.decode(res.body)}');
    print('STATUS ${res.statusCode}');
    if (res.statusCode == 200) {
      loading = false;
      update();
      newsModel.assignAll((data as List).map((e) => StokModel.fromJson(e)));
      print("DATA 1 $newsModel}");
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
    print(id);
    var res = await Network().getData("/blog-detail/$id");
    var bodi = json.decode(res.body);
    DialogHelper.loading(context, content: 'Mohon menunggu').show();
    if (bodi != []) {
      detailNews.value =
          (bodi as List).map((element) => StokModel.fromJson(element)).toList();
      // detailNews.
      if (detailNews.isNotEmpty) {
        DialogHelper.loading(context, content: 'Mohon menunggu').dismiss();
        Get.to(NewsDetailPage(), binding: NewsBinding());
      }
    }
  }
}
