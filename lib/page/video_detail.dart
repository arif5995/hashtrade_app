import 'package:flutter/material.dart';
import 'package:hastrade/network/api.dart';
import 'dart:convert';
import 'package:getwidget/getwidget.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


class HalamanVideoDetail extends StatefulWidget {
  final int id;
  const HalamanVideoDetail({Key? key, required this.id}) : super(key: key);

  @override
  _HalamanVideoDetailState createState() => _HalamanVideoDetailState();
}

class _HalamanVideoDetailState extends State<HalamanVideoDetail> {
  late final id = widget.id;

  List _loadedVideo = [];

  Future<void> _fetchData() async {
    var response = await Network().getData('/video/' + id.toString());
    final data = json.decode(response.body);

    setState(() {
      _loadedVideo = data;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Play Video'),
          backgroundColor: Colors.transparent,
        ),
        body: SafeArea(
            child: _loadedVideo.length == 0
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: _loadedVideo.length,
                    itemBuilder: (BuildContext ctx, index) {
                      /*return new YoutubePlayerBuilder(
                          player: YoutubePlayer(
                            controller: _controller,
                          ),
                          builder: (context, player) {
                            return Column(
                              children: [
                                // some widgets
                                player,
                                //some other widgets
                              ],
                            );
                          });*/

                      return GFCard(
                        borderRadius: BorderRadius.circular(5),
                        boxFit: BoxFit.cover,
                        titlePosition: GFPosition.end,
                        title: GFListTile(
                          titleText: _loadedVideo[index]['data_values']
                              ['title'],
                          margin: const EdgeInsets.all(0),
                        ),
                        content: Html(
                          data: '<iframe src="'+_loadedVideo[index]['data_values']['description_nic']+'"></iframe>'
                        ),
                      );
                    },
                  )));
  }
}

YoutubePlayerController _controller = YoutubePlayerController(
  initialVideoId: 'tgbNymZ7vqY',
  flags: YoutubePlayerFlags(
    autoPlay: true,
    mute: true,
  ),
);
