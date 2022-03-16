import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hastrade/common/helper/dialog_helper.dart';
import 'package:hastrade/page/data/models/profil_model.dart';
import 'package:image_picker/image_picker.dart';

import '../../../network/api.dart';

class ProfilController extends GetxController {
  ProfilModel user = ProfilModel();
  var isLoading = false;
  var image;
  var load = false;
  var loading = false;
  var loadImg = false.obs;
  var imgNetwork = "";

  @override
  void onInit() {
    super.onInit();
    getDataProfil();
    update();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getDataProfil();
  }

  void getPicture({required ImageSource source, required String img}) async {
    print("UIUIJ $img");
    CachedNetworkImage.evictFromCache(img);
    final file =
        await ImagePicker.platform.pickImage(source: source, imageQuality: 40);
    if (file?.path != null) {
      image = File(file!.path);
      print("gambar $image");
      load = true;
      update();
      Get.back();
    }
  }

  void getDataProfil() async {
    loading = true;

    print("PROFIL $user");
    var res = await Network().getData('/get-profile');
    var body = json.decode(res.body);

    if (body != null) {
      user = ProfilModel.fromJson(body);
      if (user.image != null || user.image!.isNotEmpty || user.image == "") {
        imgNetwork = "https://api.hastrader.com/image_profile/${user.image}";
        update();
        print("FOTO $imgNetwork}");
        print("FOTO ${user.mobile}");
        loadImg.value = true;
      } else {
        loadImg.value = false;
      }
      loading = false;
    } else {
      loading = false;
      update();
      print("GAGAL");
    }
  }

  // uploadImage(filepath, url) async {
  //   var request = http.MultipartRequest('POST', Uri.parse(url));
  //   request.files.add(http.MultipartFile('image',
  //       File(filepath).readAsBytes().asStream(), File(filepath).lengthSync(),
  //       filename: filepath.split("/").last));
  //   await request.send();
  // }

  void updateProfil(BuildContext context) async {
    DialogHelper.loading(context, content: "Proses Update").show();
    isLoading = true;
    var data = {
      'firstname': user.firstname,
      'lastname': user.lastname,
      'email': user.email,
      'mobile': user.mobile,
      'address': user.address,
    };

    try {
      print("UPDATE PROFILE $data");

      var res = await Network().postUpdate(data, '/update-profile', image);

      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading = false;
        update();
        print("SUKSES UPDATE");

        DialogHelper.sukses(context,
            title: "Terima Kasih",
            content: "Proses Update Berhasil",
            widget: TextButton(
              onPressed: () {
                getDataProfil();
                Get.back();
                Get.back();
                Get.back();
              },
              child: Text(
                "OKE",
                style: TextStyle(color: Colors.green, fontSize: 15),
              ),
            )).show();
      } else {
        loading = false;
        update();

        DialogHelper.loading(context, content: "Proses Update").dismiss();
        print("gagal UPDATE");
        DialogHelper.error(context,
            title: "Gagal",
            content: "Proses Update Gagal",
            widget: TextButton(
              onPressed: () {
                Get.back();
                Get.back();
              },
              child: Text(
                "OKE",
                style: TextStyle(color: Colors.red, fontSize: 15),
              ),
            )).show();
      }
    } catch (e) {
      DialogHelper.error(context,
          title: "Terjadi Kesalahan",
          widget: TextButton(
            onPressed: () {
              Get.back();
              Get.back();
            },
            child: Text(
              "OKE",
              style: TextStyle(color: Colors.red, fontSize: 15),
            ),
          )).show();
    }
  }
}
