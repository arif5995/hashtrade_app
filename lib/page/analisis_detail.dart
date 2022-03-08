import 'package:flutter/material.dart';
import 'package:hastrade/network/api.dart';
import 'dart:convert';
import 'package:getwidget/getwidget.dart';
import 'package:flutter_html/flutter_html.dart';

class HalamanAnalisisDetail extends StatefulWidget {
  final int id;
  const HalamanAnalisisDetail({Key? key, required this.id}) : super(key: key);

  @override
  _HalamanAnalisisDetailState createState() => _HalamanAnalisisDetailState();
}

class _HalamanAnalisisDetailState extends State<HalamanAnalisisDetail> {
  late final id = widget.id;

  List _loadedAnalisis = [];

  Future<void> _fetchData() async {
    var response = await Network().getData('/analisis/' + id.toString());
    final data = json.decode(response.body);

    setState(() {
      _loadedAnalisis = data;
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
          title: const Text('Detail Analisis'),
          backgroundColor: Colors.transparent,
        ),
        body: SafeArea(
            child: _loadedAnalisis.length == 0
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
              itemCount: _loadedAnalisis.length,
              itemBuilder: (BuildContext ctx, index) {
                return GFCard(
                  borderRadius: BorderRadius.circular(5),
                  boxFit: BoxFit.cover,
                  titlePosition: GFPosition.end,
                  image: Image.network(
                      'https://hastrader.com/assets/images/frontend/analisis/' +
                          _loadedAnalisis[index]['data_values']["image"]),
                  showImage: true,
                  title: GFListTile(
                    titleText: _loadedAnalisis[index]['data_values']['title'],
                    margin: const EdgeInsets.all(0),
                  ),
                  content: Html(data: _loadedAnalisis[index]['data_values']
                  ['description_nic']),
                  /*Text(_loadedBlog[index]['data_values']
                            ['description_nic'],textAlign: TextAlign.justify,),*/
                );
              },
            )));
  }
}
