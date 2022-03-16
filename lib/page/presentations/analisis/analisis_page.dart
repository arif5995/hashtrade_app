import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hastrade/common/helper/constant_helper.dart';
import 'package:hastrade/page/presentations/analisis/controller/analisis_controller.dart';

class AnalisisPage extends GetView<AnalisisController> {
  static const routeName = '/analisis';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: GetBuilder<AnalisisController>(
      initState: (_) {
        controller.getAnalisis(context);
      },
      builder: (_) {
        return controller.loading
            ? Center(child: CupertinoActivityIndicator())
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: RefreshIndicator(
                  onRefresh: controller.refreshData,
                  child: ListView.builder(
                    itemCount: controller.analisisModel.length,
                    itemBuilder: (BuildContext ctx, index) {
                      var dataStock = controller.analisisModel[index];
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
                                controller.analisisModel[index].id!, context);
                          },
                          subtitle: Text(''),
                        ),
                      );
                    },
                  ),
                ),
              );
      },
    )));
  }
}
