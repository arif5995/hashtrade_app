import 'package:flutter/material.dart';
import 'package:hastrade/network/api.dart';
import 'dart:convert';

import 'package:hastrade/page/news_detail.dart';

class HalamanNews extends StatefulWidget {
  @override
  _HalamanNewsState createState() => _HalamanNewsState();
}

class _HalamanNewsState extends State<HalamanNews> {
  List _loadedBlog = [];

  Future<void> _fetchData() async {
    var response = await Network().getData('/blog');
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
        body: SafeArea(
            child: _loadedBlog.length == 0
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: _loadedBlog.length,
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
                                      'https://hastrader.com/assets/images/frontend/blog/' +
                                          _loadedBlog[index]['data_values']
                                              ["image"],
                                    ))),
                          ),
                          title: Text(_loadedBlog[index]['data_values']['title']),
                          subtitle: Text(''),
                          onTap: (){
                            var id = _loadedBlog[index]['id'];
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => HalamanNewsDetail(id:id)),
                            );
                          },
                        ),
                      );
                    },
                  )));
  }
}
