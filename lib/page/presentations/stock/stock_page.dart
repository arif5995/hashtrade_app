import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hastrade/page/presentations/stock/controller/stock_controller.dart';

import '../../../common/helper/constant_helper.dart';

class StockPage extends GetView<StockController> {
  const StockPage({Key? key}) : super(key: key);
  static const routeName = '/stockPick';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: GetBuilder<StockController>(
      init: StockController(),
      initState: (val) {
        print("STOK");
        controller.getStock();
      },
      builder: (controller) {
        return controller.loading
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: controller.stokModel.length,
                  itemBuilder: (BuildContext ctx, index) {
                    var dataStock = controller.stokModel[index];
                    return Card(
                      child: ListTile(
                        leading: dataStock.data_values!.image != ""
                            ? Image.network(
                                ConstantHelper.IMAGE_NETWORK_STOK_FRONTEND +
                                    dataStock.data_values!.image!)
                            : Image.asset('assets/imagenotfound.png'),
                        title: Text(dataStock.data_values!.title!),
                        trailing: Text(dataStock.data_values!.catatan!),
                        onTap: () {
                          controller.getDetailStok(
                              controller.stokModel[index].id!, context);
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
