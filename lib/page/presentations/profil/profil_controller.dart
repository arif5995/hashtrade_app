import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hastrade/common/helper/dialog_helper.dart';
import 'package:hastrade/page/data/models/profil_model.dart';
import 'package:image_picker/image_picker.dart';

import '../../../network/api.dart';

class ProfilController extends GetxController {
  ProfilModel user = ProfilModel();
  var isLoading = false.obs;
  late File image;
  var load = false;
  var loading = false;
  var loadImg = false.obs;
  var imgNetwork = "".obs;

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

  void getPicture({required ImageSource source}) async {
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
    var res = await Network().getData('/get-profile');
    var body = json.decode(res.body);

    if (body != null) {
      user = ProfilModel.fromJson(body);
      if (user.image != null || user.image!.isNotEmpty || user.image == "") {
        imgNetwork.value =
            "https://api.hastrader.com/image_profile/${user.image}";
        loadImg.value = true;
      } else {
        loadImg.value = false;
      }
      loading = false;
      print("PROFIL $user");
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
    isLoading.value = true;
    try {
      var data = {
        'firstname': user.firstname,
        'lastname': user.lastname,
        'email': user.email,
        'mobile': "62${user.mobile}",
        'address': user.address,
      };

      print("UPDATE PROFILE $data");

      var res = await Network().postUpdate(data, '/update-profile', image);

      if (res.statusCode == 200 || res.statusCode == 201) {
        isLoading.value = false;
        print("SUKSES UPDATE");

        DialogHelper.sukses(context,
            title: "Terima Kasih",
            content: "Proses Update",
            widget: TextButton(
              onPressed: () {
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
