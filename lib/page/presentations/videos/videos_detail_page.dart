import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'controller/videos_controller.dart';

class VideosDetailPage extends GetView<VideosController> {
  const VideosDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isFullscreen = false;
    void _enableFullscreen(bool fullscreen) {
      isFullscreen = fullscreen;
      if (fullscreen) {
        // Force landscape orientation for fullscreen
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ]);
      } else {
        // Force portrait
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
        // Set preferred orientation to device default
        // Empty list causes the application to defer to the operating system default.
        // See: https://api.flutter.dev/flutter/services/SystemChrome/setPreferredOrientations.html
        SystemChrome.setPreferredOrientations([]);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Video'),
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          isFullscreen = orientation == Orientation.landscape;
          return isFullscreen
              ? YoutubePlayer(controller: controller.controllerYoutube)
              : ListView.builder(
                  itemCount: controller.dataDetailVideo.length,
                  itemBuilder: (context, index) {
                    var data = controller.dataDetailVideo[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Column(
                            children: [
                              Container(
                                height: 250,
                                child: YoutubePlayer(
                                  controller: controller.controllerYoutube,
                                ),
                              ),
                              Container(child: Text(data.data_values!.title!))
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _enableFullscreen(!isFullscreen);
        },
        tooltip: 'Fullscreen',
        child: const Icon(Icons.fullscreen),
      ),
    );
  }
}
