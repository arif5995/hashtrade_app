import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hastrade/common/helper/constant_helper.dart';
import 'package:hastrade/page/presentations/videos/controller/videos_controller.dart';

class VideosPage extends GetView<VideosController> {
  const VideosPage({Key? key}) : super(key: key);
  static const routeName = '/videospage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: GetBuilder<VideosController>(
      initState: (_) {
        controller.getVideo(context);
      },
      builder: (controller) {
        return controller.loading
            ? Center(
                child: CupertinoActivityIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: RefreshIndicator(
                  onRefresh: controller.refreshVideos,
                  child: ListView.builder(
                    itemCount: controller.dataVideo.length,
                    itemBuilder: (BuildContext ctx, index) {
                      var dataVideo = controller.dataVideo[index];
                      return Card(
                        child: ListTile(
                          leading: dataVideo.data_values!.descriptionNic != ""
                              ? CachedNetworkImage(
                                  imageUrl: ConstantHelper
                                          .IMAGE_NETWORK_VIDEO_FRONTEND +
                                      dataVideo.data_values!.image!,
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          Container(
                                              height: 50,
                                              width: 50,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5)),
                                              ),
                                              child: CupertinoActivityIndicator(
                                                  color: Colors.blue)),
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                        height: 60,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                          border: Border.all(
                                              width: 1, color: Colors.white),
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                  errorWidget: (context, url, error) => Icon(
                                        Icons.person,
                                        size: 30,
                                        color: Colors.grey,
                                      ))
                              : Image.asset('assets/imagenotfound.png'),
                          title: Text(dataVideo.data_values!.title!),
                          trailing: Text(dataVideo.data_values!.catatan!),
                          onTap: () {
                            controller.getDetailVideo(dataVideo.id!, context);
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
