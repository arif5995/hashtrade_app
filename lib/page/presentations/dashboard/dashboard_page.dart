import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hastrade/page/presentations/dashboard/dashboard_controller.dart';

import '../home/home_page.dart';

class DashboardPage extends GetView<DashboardController> {
  const DashboardPage({Key? key}) : super(key: key);
  static const routeName = "/dashboard";

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return GetBuilder<DashboardController>(builder: (controller) {
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Image.asset('assets/logo30x150.png', fit: BoxFit.scaleDown),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.notifications_none,
                color: Colors.black,
              ),
              onPressed: () {
                // _videos();
                // do something
              },
            ),
            IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.black,
              ),
              onPressed: () {
                _scaffoldKey.currentState?.openEndDrawer();
              },
            )
          ],
        ),
        endDrawer: Container(
          width: 200,
          child: Drawer(
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.only(top: 55),
              children: [
                ListTile(
                  leading: Icon(
                    Icons.face_unlock_outlined,
                    color: Colors.black,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios_sharp,
                    color: Colors.black,
                    size: 20,
                  ),
                  title: const Text('Profil'),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.info_outline,
                    color: Colors.black,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios_sharp,
                    color: Colors.black,
                    size: 20,
                  ),
                  title: const Text('Kebijakan Privasi'),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.logout,
                    color: Colors.black,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios_sharp,
                    color: Colors.black,
                    size: 20,
                  ),
                  title: const Text('Log Out'),
                  onTap: () {
                    controller.logout();
                  },
                ),
              ],
            ),
          ),
        ),
        body: Navigator(
          key: Get.nestedKey(1),
          initialRoute: HomePage.routeName,
          onGenerateRoute: controller.onGenerateRoute,
        ),
        bottomNavigationBar: Obx(
          () => ConvexAppBar(
            items: [
              TabItem(
                  icon: Icons.account_balance_wallet_outlined,
                  title: 'Stok Pick'),
              TabItem(icon: Icons.analytics, title: 'Analisis'),
              TabItem(icon: Icons.home, title: 'Home'),
              TabItem(icon: Icons.video_collection, title: 'Video'),
              TabItem(icon: Icons.announcement, title: 'News'),
            ],
            initialActiveIndex: controller.currentIndex.value,
            onTap: controller.changePage,
            backgroundColor: Colors.white70,
            color: Colors.black87,
            activeColor: Colors.blue,
          ),
        ),
      );
    });
  }
}

Widget _drawer(BuildContext context) {
  print("DRAWER");
  return Drawer(
    child: ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Text('Drawer Header'),
        ),
        ListTile(
          title: const Text('Item 1'),
          onTap: () {
            // Update the state of the app.
            // ...
          },
        ),
        ListTile(
          title: const Text('Item 2'),
          onTap: () {
            // Update the state of the app.
            // ...
          },
        ),
      ],
    ),
  );
}
