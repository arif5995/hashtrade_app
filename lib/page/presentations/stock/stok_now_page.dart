import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hastrade/common/helper/constant_helper.dart';
import 'package:hastrade/page/presentations/stock/controller/stock_controller.dart';
import 'package:hastrade/page/function/warna_text_catatan.dart';
import '../../../common/helper/parse_helper.dart';

class StockNowPage extends GetView<StockController> {
  const StockNowPage({Key? key}) : super(key: key);
  static const routeName = '/stockPickNow';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Stok Hari Ini"),
        ),
        body: SafeArea(child: GetBuilder<StockController>(
          builder: (controller) {
            return controller.loading
                ? Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: controller.stokModelfront.length,
                      itemBuilder: (BuildContext ctx, index) {
                        var dataStock = controller.stokModelfront[index];
                        return Card(
                          child: ListTile(
                            leading: dataStock.data_values!.image != ""
                                ? Image.network(
                                    ConstantHelper.IMAGE_NETWORK_STOK_FRONTEND +
                                        dataStock.data_values!.image!)
                                : Image.asset('assets/imagenotfound.png'),
                            title: Text(dataStock.data_values!.title!),
                            trailing: warnaCatatan(dataStock.data_values!.catatan!),
                            onTap: () {
                              controller.getDetailStok(
                                  controller.stokModelfront[index].id!,
                                  context);
                            },
                            subtitle: Text(ParseHelper.parseDate(dataStock.createdAt!) +' '+ ParseHelper.parseTime(dataStock.createdAt!),textAlign: TextAlign.left),
                          ),
                        );
                      },
                    ),
                  );
          },
        )));
  }
}
