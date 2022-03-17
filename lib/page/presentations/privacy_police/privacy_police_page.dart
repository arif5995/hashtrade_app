import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:hastrade/page/presentations/privacy_police/privacy_controller.dart';

class PrivacyPolicePage extends GetView<PrivacyController> {
  const PrivacyPolicePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Kebijakan Privasi'),
        ),
        body: Obx(() {
          return ListView.builder(
            itemCount: controller.data.length,
            itemBuilder: (context, index) {
              var data = controller.data[index].dataValues2;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Html(data: data?.details!)],
                ),
              );
            },
          );
        }));
  }
}
