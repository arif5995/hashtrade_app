import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hastrade/page/presentations/news/controller/news_controller.dart';

import '../../../common/helper/constant_helper.dart';

class NewsPage extends GetView<NewsController> {
  const NewsPage({Key? key}) : super(key: key);
  static const routeName = '/news';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: GetBuilder<NewsController>(
              initState: (_) {
                controller.getNews(context);
              },
      builder: (controller) {
        return controller.loading
            ? Center(child: CupertinoActivityIndicator())
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: RefreshIndicator(
                  onRefresh: controller.refreshNews,
                  child: ListView.builder(
                    itemCount: controller.newsModel.length,
                    itemBuilder: (BuildContext ctx, index) {
                      var dataNews = controller.newsModel[index];
                      return Card(
                        child: ListTile(
                          leading: dataNews.data_values!.image != ""
                              ? Image.network(
                                  ConstantHelper.IMAGE_NETWORK_NEWS_FRONTEND +
                                      dataNews.data_values!.image!)
                              : Image.asset('assets/imagenotfound.png'),
                          title: Text(dataNews.data_values!.title!),
                          trailing: Text(dataNews.data_values!.catatan!),
                          onTap: () {
                            controller.loading
                                ? Center(child: CircularProgressIndicator())
                                : controller.getDetailNews(
                                    dataNews.id!, context);
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
