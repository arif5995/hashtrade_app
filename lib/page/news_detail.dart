import 'package:flutter/material.dart';
import 'package:hastrade/network/api.dart';
import 'dart:convert';
import 'package:getwidget/getwidget.dart';
import 'package:flutter_html/flutter_html.dart';

class HalamanNewsDetail extends StatefulWidget {
  final int id;
  const HalamanNewsDetail({Key? key, required this.id}) : super(key: key);

  @override
  _HalamanNewsDetailState createState() => _HalamanNewsDetailState();
}

class _HalamanNewsDetailState extends State<HalamanNewsDetail> {
  late final id = widget.id;

  List _loadedBlog = [];

  Future<void> _fetchData() async {
    var response = await Network().getData('/blog/' + id.toString());
    final data = json.decode(response.body);

    setState(() {
      _loadedBlog = data;
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
          title: const Text('Detail Berita'),
          backgroundColor: Colors.transparent,
        ),
        body: SafeArea(
            child: _loadedBlog.length == 0
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: _loadedBlog.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return GFCard(
                        borderRadius: BorderRadius.circular(5),
                        boxFit: BoxFit.cover,
                        titlePosition: GFPosition.end,
                        image: Image.network(
                            'https://hastrader.com/assets/images/frontend/blog/' +
                                _loadedBlog[index]['data_values']["image"]),
                        showImage: true,
                        title: GFListTile(
                          titleText: _loadedBlog[index]['data_values']['title'],
                          margin: const EdgeInsets.all(0),
                        ),
                        content: Html(data: _loadedBlog[index]['data_values']
                        ['description_nic']),
                        /*Text(_loadedBlog[index]['data_values']
                            ['description_nic'],textAlign: TextAlign.justify,),*/
                      );
                    },
                  )));
  }
}
