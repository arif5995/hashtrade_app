import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:hastrade/page/presentations/news/controller/news_controller.dart';

import '../../../common/helper/constant_helper.dart';

class NewsDetailPage extends GetView<NewsController> {
  const NewsDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail News"),
      ),
      body: ListView.builder(
          itemCount: controller.newsDetailModel.length,
          itemBuilder: (context, index) {
            var data = controller.newsDetailModel[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: [
                      Row(children: <Widget>[
                        Expanded(
                          child: Html(
                            data: data.data_values!.title!,
                          ),
                        ),
                      ]),
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
                                            .IMAGE_NETWORK_NEWS_FRONTEND +
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
