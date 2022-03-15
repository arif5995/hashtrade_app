import 'package:flick_video_player/flick_video_player.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeHelper {
  static YoutubePlayerController showVideo(String linkYoutube) {
    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: linkYoutube,
      flags: YoutubePlayerFlags(isLive: true),
    );
    return _controller;
  }

  static FlickManager flickVideo(String url) {
    FlickManager flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.network(url),
    );
    return flickManager;
  }
}
