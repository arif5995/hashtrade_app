import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hastrade/page/presentations/password/password_binding.dart';
import 'package:hastrade/page/presentations/password/update_password_page.dart';
import 'package:hastrade/page/presentations/profil/profil_binding.dart';
import 'package:hastrade/page/presentations/profil/profil_controller.dart';
import 'package:hastrade/page/presentations/profil/update_profil.dart';

import '../../widgets/header_widget.dart';

class ProfilPage extends GetView<ProfilController> {
  const ProfilPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profilController = Get.put(ProfilController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile Page",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevation: 0.5,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: GetBuilder<ProfilController>(
          builder: (controller) {
            return controller.loading
                ? Container(child: Center(child: CircularProgressIndicator()))
                : Stack(
                    children: [
                      Container(
                        height: 100,
                        child: HeaderWidget(100, false, Icons.house_rounded),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Column(
                          children: [
                            Obx(() => CachedNetworkImage(
                                imageUrl: profilController.imgNetwork.value,
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                      height: 120,
                                      width: 120,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(60)),
                                        border: Border.all(
                                            width: 5, color: Colors.white),
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                errorWidget: (context, url, error) => Icon(
                                      Icons.person,
                                      size: 30,
                                      color: Colors.grey,
                                    ))),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "${controller.user.firstname} ${controller.user.lastname}",
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, bottom: 4.0),
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "User Information",
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  Card(
                                    child: Container(
                                      alignment: Alignment.topLeft,
                                      padding: EdgeInsets.all(15),
                                      child: Column(
                                        children: <Widget>[
                                          Column(
                                            children: <Widget>[
                                              ...ListTile.divideTiles(
                                                color: Colors.grey,
                                                tiles: [
                                                  ListTile(
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 12,
                                                            vertical: 4),
                                                    leading:
                                                        Icon(Icons.my_location),
                                                    title: Text("Location"),
                                                    subtitle: Text(
                                                        "${controller.user.address}"),
                                                  ),
                                                  ListTile(
                                                    leading: Icon(Icons.email),
                                                    title: Text("Email"),
                                                    subtitle: Text(
                                                        "${controller.user.email}"),
                                                  ),
                                                  ListTile(
                                                    leading: Icon(Icons.phone),
                                                    title: Text("Phone"),
                                                    subtitle: Text(
                                                        "${controller.user.mobile}"),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton.icon(
                                    onPressed: () {
                                      Get.to(UpdateProfil(),
                                          binding: ProfilBinding());
                                    },
                                    icon: Icon(Icons.edit),
                                    label: Text(
                                      "Update Profil",
                                      style: TextStyle(color: Colors.blue),
                                    )),
                                TextButton.icon(
                                    onPressed: () {
                                      Get.to(UpdatePassword(),
                                          binding: PasswordBinding());
                                    },
                                    icon: Icon(Icons.lock_open_rounded),
                                    label: Text(
                                      "Ganti Password",
                                      style: TextStyle(color: Colors.blue),
                                    ))
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  );
          },
        ),
      ),
    );
  }
}
