import 'package:flutter/material.dart';
import 'package:hastrade/network/api.dart';
import 'dart:convert';
import 'package:getwidget/getwidget.dart';
import 'package:flutter_html/flutter_html.dart';

class HalamanStokDetail extends StatefulWidget {
  final int id;
  const HalamanStokDetail({Key? key, required this.id}) : super(key: key);

  @override
  _HalamanStokDetailState createState() => _HalamanStokDetailState();
}

class _HalamanStokDetailState extends State<HalamanStokDetail> {
  late final id = widget.id;

  List _loadedStok = [];

  Future<void> _fetchData() async {
    var response = await Network().getData('/stok/' + id.toString());
    final data = json.decode(response.body);

    setState(() {
      _loadedStok = data;
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
          title: const Text('Detail Stok'),
          backgroundColor: Colors.transparent,
        ),
        body: SafeArea(
            child: _loadedStok.length == 0
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
              itemCount: _loadedStok.length,
              itemBuilder: (BuildContext ctx, index) {
                return GFCard(
                  borderRadius: BorderRadius.circular(5),
                  boxFit: BoxFit.cover,
                  titlePosition: GFPosition.end,
                  image: Image.network(
                      'https://hastrader.com/assets/images/frontend/stok/' +
                          _loadedStok[index]['data_values']["image"]),
                  showImage: true,
                  title: GFListTile(
                    titleText: _loadedStok[index]['data_values']['title'],
                    margin: const EdgeInsets.all(0),
                  ),
                  content: Html(data: _loadedStok[index]['data_values']
                  ['description_nic']),
                  /*Text(_loadedBlog[index]['data_values']
                            ['description_nic'],textAlign: TextAlign.justify,),*/
                );
              },
            )));
  }
}
