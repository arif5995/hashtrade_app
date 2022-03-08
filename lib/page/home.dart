// import 'dart:html';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:hastrade/network/api.dart';
import 'dart:convert';
import 'package:hastrade/page/news_detail.dart';
import 'package:hastrade/page/video_detail.dart';

// import 'package:hastrade/page/stok.dart';
import 'package:hastrade/page/analisis.dart';

// import 'package:convex_bottom_bar/convex_bottom_bar.dart';
// import 'main_menu.dart';

class HalamanUtama extends StatefulWidget {
  // const HalamanUtama({Key? key, required this.changePage}) : super(key: key);
  // final void Function(int) changePage;

  @override
  _HalamanUtamaState createState() => _HalamanUtamaState();
}

class _HalamanUtamaState extends State<HalamanUtama> {
  // late final changePage = widget.changePage;
  final TextStyle whiteText = TextStyle(color: Colors.white);

  List _loadedBlog = [];
  List _loadedVideo = [];

  Future<void> _fetchDataBlog() async {
    var response = await Network().getData('/blog-utama');
    final data = json.decode(response.body);

    setState(() {
      _loadedBlog = data;
    });
  }

  Future<void> _fetchDataVideo() async {
    var response = await Network().getData('/video-utama');
    final data = json.decode(response.body);

    setState(() {
      _loadedVideo = data;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchDataBlog();
    _fetchDataVideo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildHeader(),
          const SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              "Statistik",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
          ),
          Card(
            elevation: 4.0,
            color: Colors.white,
            margin: const EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ListTile(
                    leading: Container(
                      alignment: Alignment.bottomCenter,
                      width: 45.0,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            height: 20,
                            width: 8.0,
                            color: Colors.grey.shade300,
                          ),
                          const SizedBox(width: 4.0),
                          Container(
                            height: 25,
                            width: 8.0,
                            color: Colors.grey.shade300,
                          ),
                          const SizedBox(width: 4.0),
                          Container(
                            height: 40,
                            width: 8.0,
                            color: Colors.blue,
                          ),
                          const SizedBox(width: 4.0),
                          Container(
                            height: 30,
                            width: 8.0,
                            color: Colors.grey.shade300,
                          ),
                        ],
                      ),
                    ),
                    title: Text("Stok Pick"),
                    subtitle: Text("18 Stok Pick"),
                    // onTap: () => changePage(0),
                  ),
                ),
                VerticalDivider(),
                Expanded(
                  child: ListTile(
                    leading: Container(
                      alignment: Alignment.bottomCenter,
                      width: 45.0,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            height: 20,
                            width: 8.0,
                            color: Colors.grey.shade300,
                          ),
                          const SizedBox(width: 4.0),
                          Container(
                            height: 25,
                            width: 8.0,
                            color: Colors.grey.shade300,
                          ),
                          const SizedBox(width: 4.0),
                          Container(
                            height: 40,
                            width: 8.0,
                            color: Colors.red,
                          ),
                          const SizedBox(width: 4.0),
                          Container(
                            height: 30,
                            width: 8.0,
                            color: Colors.grey.shade300,
                          ),
                        ],
                      ),
                    ),
                    title: Text("Analisis"),
                    subtitle: Text("7 Analisis"),
                    onTap: () {
                      // HalamanAnalisis()
                      /*Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HalamanAnalisis()),
                      );*/
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 10),
            child: Text(
              "Video",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
          ),
          Container(
              child: CarouselSlider(
            items: [_gridView()],
            options: CarouselOptions(
              aspectRatio: 16 / 9,
              viewportFraction: 1.01,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: false,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
            ),
          )),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 10, bottom: 10),
            child: Text(
              "Berita",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
          ),
          SafeArea(
              child: _loadedBlog.length == 0
                  ? Center(child: CircularProgressIndicator())
                  : Container(
                      height: _loadedBlog.length * 100,
                      child: ListView.builder(
                          itemCount: _loadedBlog.length,
                          itemBuilder: (BuildContext ctx, index) {
                            return Card(
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                  ListTile(
                                    leading: Container(
                                      width: 100,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                'https://hastrader.com/assets/images/frontend/blog/' +
                                                    _loadedBlog[index]
                                                            ['data_values']
                                                        ["image"],
                                              ))),
                                    ),
                                    title: Text(_loadedBlog[index]
                                        ['data_values']['title']),
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
                                ]));
                          }),
                    )),
        ],
      ),
    );
  }

  Stack _buildHeader() {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          color: Colors.white,
        ),
        Container(
          padding: EdgeInsets.only(top: 20, bottom: 20),
          child: CarouselSlider(
            items: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          "https://hastrader.com/assets/images/frontend/header/header1.jpg")),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            "https://hastrader.com/assets/images/frontend/header/header2.jpg"))),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            "https://hastrader.com/assets/images/frontend/header/header3.jpg"))),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            "https://hastrader.com/assets/images/frontend/header/header4.jpg"))),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            "https://hastrader.com/assets/images/frontend/header/header5.jpg"))),
              ),
            ],
            options: CarouselOptions(
              height: 200,
              aspectRatio: 16 / 9,
              viewportFraction: 0.8,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
            ),
          ),
        ),
      ],
    );
  }

  /*Widget _gridView() {
    return GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        childAspectRatio: 2,
        children: getList()
    );
  }

  List<Widget> getList() {
    List<Widget> childs = [];
    for (int i = 0; i < _loadedVideo.length; i++) {
      childs.add(new Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    'https://hastrader.com/assets/images/frontend/video/' +
                        _loadedVideo[i]['data_values']
                        ["image"]))),
      ));
    }
    return childs;
  }*/

  Widget _gridView() {
    return GridView.builder(
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 250,
          childAspectRatio: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: _loadedVideo.length,
        itemBuilder: (BuildContext ctx, index) {
          return _loadedBlog.length == 0
              ? Center(child: CircularProgressIndicator())
              : GestureDetector(
                  onTap: () {
                    var id = _loadedVideo[index]['id'];
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HalamanVideoDetail(id:id)),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              'https://hastrader.com/assets/images/frontend/video/' +
                                  _loadedVideo[index]['data_values']["image"])),
                    ),
                  ),
                );
        });
  }

  /* Widget _gridView() {
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 2,
      childAspectRatio: 2,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(8),
          // child: const Text("He'd have you all unravel at the"),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      "https://hastrader.com/assets/images/frontend/video/61ef9b52a06701643092818.png"))),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          // child: const Text("He'd have you all unravel at the"),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      "https://hastrader.com/assets/images/frontend/video/61ec42f6327b71642873590.jpg"))),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          // child: const Text("He'd have you all unravel at the"),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      "https://hastrader.com/assets/images/frontend/video/61ef98be16b741643092158.png"))),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          // child: const Text("He'd have you all unravel at the"),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      "https://hastrader.com/assets/images/frontend/video/61ef9c22210121643093026.png"))),
        ),
      ],
    );
  }*/
}
