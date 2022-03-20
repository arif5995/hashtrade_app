import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hastrade/page/presentations/videos/binding/videos_binding.dart';
import 'package:hastrade/page/presentations/videos/videos_detail_page.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:stylish_dialog/stylish_dialog.dart';
import '../../../../common/helper/dialog_helper.dart';
import '../../../../common/helper/youtube_helper.dart';
import '../../../../network/api.dart';
import '../../../data/models/stok_model.dart';

class VideosController extends GetxController {
  var data = [].obs;
  var loading = false;
  var videoModel = <StokModel>[].obs;
  var dataDetailVideo = <StokModel>[].obs;
  // var dataVideo = <StokModel>[].obs;
  var loadImg = false.obs;
  late StylishDialog _dialog;
  var controllerYoutube;
  int _currentPage = 1;

  @override
  void onInit() {
    print('GET Video');
    //getAnalisisByDateNow();
    super.onInit();
  }

  Future refreshVideo() async {
    loading = true;
    videoModel.clear();
    _currentPage += 20;
    var res = await Network().getDataStock('/video/$_currentPage');
    var data = json.decode(res.body);
    print("News $data");
    if ((data as List).isNotEmpty) {
      videoModel.addAll((data as List).map((e) => StokModel.fromJson(e)));
      update();
      print("Video 1 $_currentPage");
    } else {
      videoModel.clear();
      _currentPage = 0;
      var res = await Network().getDataStock('/video/$_currentPage');
      var data = json.decode(res.body);
      videoModel.addAll((data as List).map((e) => StokModel.fromJson(e)));
      loading = false;
      update();
      print("DATA VIDEO $dataDetailVideo");
    }
    print("DATA 3 $_currentPage " "${videoModel}");
    loading = false;
  }

  void getVideo(BuildContext context) async {
    loading = true;
    _currentPage = 0;
    var res = await Network().getDataStock('/video/0');
    var data = json.decode(res.body);
    print('VIDEO ${json.decode(res.body)}');
    print('STATUS ${res.statusCode}');
    if (res.statusCode == 200) {
      loading = false;
      update();
      videoModel.assignAll((data as List).map((e) => StokModel.fromJson(e)));
      print("DATA 1 $videoModel}");
    } else {
      loading = false;
      update();
      DialogHelper.warning(context,
          title: "Perhatian!",
          content: 'Video Kosong!',
          widget: TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text('Oke')))
          .show();
      print("DATA VIDEO ${res.body}");
    }
  }

  void getDetailVideo(int id, BuildContext context) async {
    // loading = true;
    print(id);
    var response = await Network().getData('/video-detail/$id');
    final data = json.decode(response.body);
    DialogHelper.loading(context, content: 'Mohon menunggu').show();
    if (data != []) {
      dataDetailVideo.value =
          (data as List).map((element) => StokModel.fromJson(element)).toList();
      if (dataDetailVideo.isNotEmpty) {
        DialogHelper.loading(context, content: 'Mohon menunggu').dismiss();
        print("video detail");
        String _idYoutube = dataDetailVideo[0].data_values!.descriptionNic!;
        String videoId = YoutubePlayer.convertUrlToId(_idYoutube)!;
        controllerYoutube = YoutubeHelper.showVideo(videoId);
        Get.to(VideosDetailPage(), binding: VideosBinding());
      } else {
        DialogHelper.loading(context, content: 'Mohon menunggu').dismiss();
      }
    } else {
      print(data);
    }
  }
}
