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

  var loading = false;

  @override
  void onInit() {
    getVideo();
    print("video");
    super.onInit();
  }

  void getVideo() async {
    loading = true;
    var response = await Network().getData('/video');
    final data = json.decode(response.body);

    print("VIDEO $data");
    if (response.statusCode == 200) {
      loading = false;
      update();
      dataVideo.value =
          (data as List).map((element) => StokModel.fromJson(element)).toList();
    }
  }

  void getDetailVideo(int id, BuildContext context) async {
    // loading = true;
    var response = await Network().getData('/video/$id');
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
      }

      // flickController = YoutubeHelper.flickVideo(_idYoutube);;

    }
  }
}
