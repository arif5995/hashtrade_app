import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hastrade/page/presentations/videos/binding/videos_binding.dart';
import 'package:hastrade/page/presentations/videos/videos_detail_page.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../common/helper/dialog_helper.dart';
import '../../../../common/helper/youtube_helper.dart';
import '../../../../network/api.dart';
import '../../../data/models/stok_model.dart';

class VideosController extends GetxController {
  var dataVideo = <StokModel>[].obs;
  var dataDetailVideo = <StokModel>[].obs;
  var controllerYoutube;
  var flickController;
  var _currentPage = 0;
  var loading = false;

  @override
  void onInit() {
    print("video");
    super.onInit();
  }

  void getVideo(BuildContext context) async {
    loading = true;
    var response = await Network().getData('/video/0');
    final data = json.decode(response.body);

    print("VIDEO $data");
    if (response.statusCode == 200) {
      loading = false;
      update();
      dataVideo.value =
          (data as List).map((element) => StokModel.fromJson(element)).toList();
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
    }
  }

  Future refreshVideos() async {
    loading = true;
    await Future.delayed(Duration(seconds: 2));
    _currentPage += 1;
    var res = await Network().getDataStock('/video/$_currentPage');
    var data = json.decode(res.body);
    if (data != []) {
      loading = false;
      dataVideo.addAll((data as List).map((e) => StokModel.fromJson(e)));
      update();
    } else {
      dataVideo.clear();
      _currentPage = 0;
      loading = false;
      update();
    }
    update();
    print("DATA 2 $_currentPage");
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
