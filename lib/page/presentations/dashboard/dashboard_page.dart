import 'package:cached_network_image/cached_network_image.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hastrade/page/presentations/dashboard/dashboard_controller.dart';
import 'package:hastrade/page/presentations/privacy_police/privacy_binding.dart';
import 'package:hastrade/page/presentations/privacy_police/privacy_police_page.dart';
import 'package:hastrade/page/presentations/profil/profil_controller.dart';
import 'package:hastrade/page/presentations/profil/profil_page.dart';
import 'package:stylish_dialog/stylish_dialog.dart';

import '../home/home_page.dart';
import '../profil/profil_binding.dart';

class DashboardPage extends GetView<DashboardController> {
  const DashboardPage({Key? key}) : super(key: key);
  static const routeName = "/dashboard";

  @override
  Widget build(BuildContext context) {
    final profilController = Get.put(ProfilController());

    return GetBuilder<DashboardController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Row(
            children: [
              Flexible(
                child: Image.asset(
                  'assets/logoHastrade.png',
                  fit: BoxFit.scaleDown,
                  width: 50,
                  height: 50,
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Flexible(
                child: Image.asset(
                  'assets/textHasTrade.png',
                  fit: BoxFit.scaleDown,
                  width: 100,
                  height: 50,
                ),
              ),
            ],
          ),
          actions: <Widget>[
            Builder(
                builder: (context) => IconButton(
                      icon: Icon(
                        Icons.menu,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        Scaffold.of(context).openEndDrawer();
                      },
                    ))
          ],
        ),
        endDrawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              GetBuilder<ProfilController>(initState: (_) {
                ProfilController().getDataProfil();
              }, builder: (profil) {
                return DrawerHeader(
                  decoration: BoxDecoration(color: Colors.blue),
                  child: InkWell(
                    onTap: () {
                      Get.to(ProfilPage(), binding: ProfilBinding());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CachedNetworkImage(
                            imageUrl: profil.imgNetwork,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) => Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(50)),
                                    ),
                                    child: CupertinoActivityIndicator()),
                            imageBuilder: (context, imageProvider) => Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50)),
                                    border: Border.all(
                                        width: 1, color: Colors.white),
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                            errorWidget: (context, url, error) => ClipOval(
                                  child: Material(
                                    color: Colors.white, // Button color
                                    child: InkWell(
                                      // splashColor: Colors.red, // Splash color
                                      onTap: () {},
                                      child: SizedBox(
                                          width: 60,
                                          height: 60,
                                          child: Icon(
                                            Icons.person,
                                            size: 25,
                                            color: Colors.grey,
                                          )),
                                    ),
                                  ),
                                )),
                        SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          flex: 5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                controller.namaorang,
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white),
                              ),
                              Text(
                                controller.email,
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          flex: 1,
                          child: Icon(
                            Icons.arrow_forward_ios_sharp,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
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
                  Get.to(PrivacyPolicePage(), binding: PrivacyBinding());
                  Scaffold.of(context).openDrawer();
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
                  StylishDialog(
                    context: context,
                    alertType: StylishDialogType.NORMAL,
                    titleText: 'Perhatian',
                    contentText: 'Apakah anda ingin keluar?',
                    confirmButton: TextButton(
                      onPressed: () {
                        controller.logout();
                      },
                      child: Text('Ya'),
                    ),
                    cancelButton: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Tidak'),
                    ),
                  ).show();
                },
              ),
            ],
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
