import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../network/api.dart';
import '../../video_detail.dart';

class VideosPage extends StatefulWidget {
  const VideosPage({Key? key}) : super(key: key);
  static const routeName = "/videos";

  @override
  _VideosPageState createState() => _VideosPageState();
}

class _VideosPageState extends State<VideosPage> {
  List _loadedVideos = [];

  // The function that fetches data from the API
  Future<void> _fetchData() async {
    var response = await Network().getData('/video');
    final data = json.decode(response.body);

    setState(() {
      _loadedVideos = data;
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
        body: SafeArea(
            child: _loadedVideos.length == 0
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: _loadedVideos.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return Card(
                        child: ListTile(
                          leading: Container(
                            width: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      'https://hastrader.com/assets/images/frontend/video/' +
                                          _loadedVideos[index]['data_values']
                                              ["image"],
                                    ))),
                          ),
                          title: Text(
                              _loadedVideos[index]['data_values']['title']),
                          onTap: () {
                            var id = _loadedVideos[index]['id'];
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      HalamanVideoDetail(id: id)),
                            );
                          },
                          subtitle: Text(''),
                        ),
                      );
                    },
                  )));
  }
}
