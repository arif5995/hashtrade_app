import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../network/api.dart';
import '../../analisis_detail.dart';

class AnalisisPage extends StatefulWidget {
  const AnalisisPage({Key? key}) : super(key: key);
  static const routeName = "/analisi";

  @override
  _AnalisisPageState createState() => _AnalisisPageState();
}

class _AnalisisPageState extends State<AnalisisPage> {
  List _loadedAnalisis = [];

  // The function that fetches data from the API
  Future<void> _fetchData() async {
    var response = await Network().getData('/analisis');
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
        body: SafeArea(
            child: _loadedAnalisis.length == 0
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: _loadedAnalisis.length,
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
                                      'https://hastrader.com/assets/images/frontend/analisis/' +
                                          _loadedAnalisis[index]['data_values']
                                              ["image"],
                                    ))),
                          ),
                          title: Text(
                              _loadedAnalisis[index]['data_values']['title']),
                          onTap: () {
                            var id = _loadedAnalisis[index]['id'];
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      HalamanAnalisisDetail(id: id)),
                            );
                          },
                          subtitle: Text(''),
                        ),
                      );
                    },
                  )));
  }
}
