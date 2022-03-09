import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hastrade/network/api.dart';
import 'package:hastrade/page/stok_detail.dart';

class HalamanStok extends StatefulWidget {
  @override
  _HalamanStokState createState() => _HalamanStokState();
}

class _HalamanStokState extends State<HalamanStok> {
  List _loadedStok = [];

  // The function that fetches data from the API
  Future<void> _fetchData() async {
    var response = await Network().getData('/stok');
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
    print(_loadedStok.length);
    return Scaffold(
        body: SafeArea(
            child: _loadedStok.length == 0
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: _loadedStok.length,
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
                                      'https://hastrader.com/assets/images/frontend/stok/' +
                                          _loadedStok[index]['data_values']
                                              ["image"],
                                    ))),
                          ),
                          title:
                              Text(_loadedStok[index]['data_values']['title']),
                          onTap: () {
                            var id = _loadedStok[index]['id'];
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      HalamanStokDetail(id: id)),
                            );
                          },
                          subtitle: Text(''),
                        ),
                      );
                    },
                  )));
  }
}
