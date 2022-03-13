import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hastrade/common/helper/constant_helper.dart';
import 'package:hastrade/page/presentations/analisis/controller/analisis_controller.dart';

class AnalisisNewPage extends GetView<AnalisisController> {
  const AnalisisNewPage({Key? key}) : super(key: key);
  static const routeName = '/analisisnew';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Analisis Hari Ini"),
        ),
        body: SafeArea(child: GetBuilder<AnalisisController>(
          builder: (controller) {
            return controller.loading
                ? Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: controller.analisisModelfront.length,
                      itemBuilder: (BuildContext ctx, index) {
                        var dataStock = controller.analisisModelfront[index];
                        return Card(
                          child: ListTile(
                            leading: dataStock.data_values!.image != ""
                                ? Image.network(ConstantHelper
                                        .IMAGE_NETWORK_ANALISIS_FRONTEND +
                                    dataStock.data_values!.image!)
                                : Image.asset('assets/imagenotfound.png'),
                            title: Text(dataStock.data_values!.title!),
                            onTap: () {
                              controller.getDetailAnalisis(
                                  controller.analisisModelfront[index].id!,
                                  context);
                            },
                            subtitle: Text(''),
                          ),
                        );
                      },
                    ),
                  );
          },
        )));
  }
}
