import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../network/api.dart';
import '../../news_detail.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);
  static const routeName = "/News";

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
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
                          title:
                              Text(_loadedBlog[index]['data_values']['title']),
                          subtitle: Text(''),
                          onTap: () {
                            var id = _loadedBlog[index]['id'];
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      HalamanNewsDetail(id: id)),
                            );
                          },
                        ),
                      );
                    },
                  )));
  }
}
