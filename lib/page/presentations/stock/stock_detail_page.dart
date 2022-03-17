import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:hastrade/common/helper/constant_helper.dart';
import 'package:hastrade/common/helper/parse_helper.dart';
import 'package:hastrade/page/presentations/stock/controller/stock_controller.dart';

class StockDetailPage extends GetView<StockController> {
  const StockDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(
            "Detail Stock ${controller.detailStok[0].data_values!.title!}")),
      ),
      body: ListView.builder(
          itemCount: controller.detailStok.length,
          itemBuilder: (context, index) {
            var data = controller.detailStok[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Tanggal : "),
                          Text(ParseHelper.parseDate(data.createdAt!)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Jam : "),
                          Text(ParseHelper.parseTime(data.createdAt!)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Status : "),
                          Text(data.data_values!.catatan!),
                        ],
                      ),
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
                                            .IMAGE_NETWORK_STOK_FRONTEND +
                                        data.data_values!.image!)
                                    : AssetImage('assets/imagenotfound.png')
                                        as ImageProvider,
                                fit: BoxFit.fill)),
                      ),
                      SizedBox(
                        height: 10,
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
