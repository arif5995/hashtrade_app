import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:hastrade/page/presentations/analisis/controller/analisis_controller.dart';

import '../../../common/helper/constant_helper.dart';

class AnalisisDetailPage extends GetView<AnalisisController> {
  const AnalisisDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(
            "Detail Stock ${controller.detailAnalisis[0].data_values!.title!}")),
      ),
      body: ListView.builder(
          itemCount: controller.detailAnalisis.length,
          itemBuilder: (context, index) {
            var data = controller.detailAnalisis[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 250,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: data.data_values!.image != ""
                                    ? NetworkImage(ConstantHelper
                                            .IMAGE_NETWORK_ANALISIS_FRONTEND +
                                        data.data_values!.image!)
                                    : AssetImage('assets/imagenotfound.png')
                                        as ImageProvider,
                                fit: BoxFit.cover)),
                      ),
                      Container(
                        child: Html(
                          data: data.data_values!.descriptionNic!,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
