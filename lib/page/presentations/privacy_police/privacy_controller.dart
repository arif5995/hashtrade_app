import 'dart:convert';

import 'package:get/get.dart';
import 'package:hastrade/network/api.dart';

import '../../data/models/privacy_police_model.dart';

class PrivacyController extends GetxController {
  var title = "".obs;
  var detail = "".obs;
  PrivacyPolice privacyPolice = PrivacyPolice();
  RxList<Message> data = <Message>[].obs;

  @override
  void onInit() {
    super.onInit();
    getPrivacyPolice();
    update();
  }

  void getPrivacyPolice() async {
    var res = await Network().getData('/kebijakan-privasi');
    var body = json.decode(res.body);

    print(body["message"]);

    if (body["success"] == "true") {
      // privacyPolice = body;
      print("PRIVACY ${body["message"] as List}");
      data.value = (body["message"] as List)
          .map((val) => Message.fromJson(val))
          .toList();
      print("TES ${data[0].dataValues2}");
    } else {
      print('GAGAL');
    }
  }
}
