import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hastrade/page/presentations/password/password_binding.dart';
import 'package:hastrade/page/presentations/profil/profil_controller.dart';
import 'package:image_picker/image_picker.dart';

import '../../../common/theme_helper.dart';
import '../../widgets/header_widget.dart';
import '../password/update_password_page.dart';

class UpdateProfil extends GetView<ProfilController> {
  const UpdateProfil({Key? key}) : super(key: key);
  static const routeName = '/updateProfil';

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Update Page",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevation: 0.5,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: GetBuilder<ProfilController>(
        initState: (_) => ProfilController().getDataProfil(),
        builder: (profil) {
          return SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  height: 150,
                  child: HeaderWidget(150, false, Icons.person),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(25, 50, 25, 10),
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            GestureDetector(
                              child: Stack(
                                children: [
                                  if (profil.load)
                                    Container(
                                      height: 120,
                                      width: 120,
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        border: Border.all(
                                            width: 5, color: Colors.white),
                                        image: DecorationImage(
                                            image: FileImage(profil.image),
                                            fit: BoxFit.cover),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 20,
                                            offset: const Offset(5, 5),
                                          ),
                                        ],
                                      ),
                                    )
                                  else
                                    CachedNetworkImage(
                                        imageUrl: profil.imgNetwork,
                                        progressIndicatorBuilder: (context, url,
                                                downloadProgress) =>
                                            Container(
                                                height: 120,
                                                width: 120,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      width: 5,
                                                      color: Colors.white),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(100)),
                                                ),
                                                child:
                                                    CupertinoActivityIndicator()),
                                        imageBuilder: (context,
                                                imageProvider) =>
                                            Container(
                                              height: 120,
                                              width: 120,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(100)),
                                                border: Border.all(
                                                    width: 5,
                                                    color: Colors.white),
                                                image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                        errorWidget: (context, url, error) =>
                                            ClipOval(
                                              child: Material(
                                                color: Colors
                                                    .white, // Button color
                                                child: InkWell(
                                                  // splashColor: Colors.red, // Splash color
                                                  onTap: () {},
                                                  child: SizedBox(
                                                      width: 120,
                                                      height: 120,
                                                      child: Icon(
                                                        Icons.person,
                                                        size: 50,
                                                        color: Colors.grey,
                                                      )),
                                                ),
                                              ),
                                            )),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(80, 80, 0, 0),
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.add_circle,
                                        color: Colors.grey.shade700,
                                        size: 25.0,
                                      ),
                                      onPressed: () {
                                        Get.bottomSheet(Container(
                                            height: 100,
                                            padding: EdgeInsets.all(10),
                                            color: Colors.white,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  flex: 2,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      IconButton(
                                                          padding:
                                                              EdgeInsets.zero,
                                                          onPressed: () {
                                                            profil.getPicture(
                                                                source:
                                                                    ImageSource
                                                                        .camera,
                                                                img: profil
                                                                    .imgNetwork);
                                                          },
                                                          icon: Icon(
                                                            Icons.camera,
                                                            color: Colors.grey,
                                                            size: 50,
                                                          )),
                                                      Center(
                                                          child: Text('Camera'))
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: VerticalDivider(
                                                    thickness: 1,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      IconButton(
                                                          padding:
                                                              EdgeInsets.zero,
                                                          onPressed: () {
                                                            profil.getPicture(
                                                                source:
                                                                    ImageSource
                                                                        .gallery,
                                                                img: profil
                                                                    .imgNetwork);
                                                          },
                                                          icon: Icon(
                                                            Icons.image,
                                                            color: Colors.grey,
                                                            size: 50,
                                                          )),
                                                      Center(
                                                          child: Text('Galeri'))
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )));
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              child: TextFormField(
                                decoration: ThemeHelper().textInputDecoration(
                                    'First Name', 'Enter your first name'),
                                initialValue: profil.user.firstname,
                                validator: (val) {
                                  if (val!.isNotEmpty) {
                                    profil.user.firstname = val;
                                  } else {
                                    return 'Enter Your First Name';
                                  }
                                },
                              ),
                              decoration:
                                  ThemeHelper().inputBoxDecorationShaddow(),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              child: TextFormField(
                                decoration: ThemeHelper().textInputDecoration(
                                    'Last Name', 'Enter your last name'),
                                initialValue: profil.user.lastname,
                                validator: (val) {
                                  if (val!.isNotEmpty) {
                                    profil.user.lastname = val;
                                  } else {
                                    return 'Enter Your Last Name';
                                  }
                                },
                              ),
                              decoration:
                                  ThemeHelper().inputBoxDecorationShaddow(),
                            ),
                            SizedBox(height: 20.0),
                            Container(
                              child: TextFormField(
                                decoration: ThemeHelper().textInputDecoration(
                                    "E-mail address", "Enter your email"),
                                keyboardType: TextInputType.emailAddress,
                                initialValue: profil.user.email,
                                validator: (val) {
                                  if (val!.isEmpty ||
                                      !RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                          .hasMatch(val)) {
                                    return "Enter a valid email address";
                                  } else {
                                    profil.user.email = val;
                                  }
                                },
                              ),
                              decoration:
                                  ThemeHelper().inputBoxDecorationShaddow(),
                            ),
                            SizedBox(height: 20.0),
                            Container(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    child: Text(
                                      "+62",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    padding:
                                        EdgeInsets.fromLTRB(20, 11, 20, 11),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        border: Border.all(
                                            color: Colors.grey.shade400)),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Flexible(
                                    child: Container(
                                        child: TextFormField(
                                      decoration: ThemeHelper()
                                          .textInputDecoration("Mobile Number",
                                              "Enter your mobile number"),
                                      initialValue: profil.user.mobile,
                                      keyboardType: TextInputType.phone,
                                      validator: (val) {
                                        if (val!.isEmpty ||
                                            !RegExp(r"^(\d+)*$")
                                                .hasMatch(val)) {
                                          return "Enter a valid phone number";
                                        } else {
                                          profil.user.mobile = val;
                                        }
                                      },
                                    )),
                                  )
                                ],
                              ),
                              decoration:
                                  ThemeHelper().inputBoxDecorationShaddow(),
                            ),
                            SizedBox(height: 20.0),
                            Container(
                              child: TextFormField(
                                decoration: ThemeHelper()
                                    .textInputAddressDecoration(
                                        'Address', 'Enter your address'),
                                keyboardType: TextInputType.multiline,
                                maxLines: 5,
                                initialValue: profil.user.address == null
                                    ? ''
                                    : profil.user.address,
                                validator: (val) {
                                  if (val!.isNotEmpty) {
                                    profil.user.address = val;
                                  } else {
                                    return 'Enter Your Last Name';
                                  }
                                },
                              ),
                              decoration:
                                  ThemeHelper().inputBoxDecorationShaddow(),
                            ),
                            SizedBox(height: 15.0),
                            SizedBox(height: 20.0),
                            Container(
                              decoration:
                                  ThemeHelper().buttonBoxDecoration(context),
                              child: ElevatedButton(
                                style: ThemeHelper().buttonStyle(),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(40, 10, 40, 10),
                                  child: Text(
                                    profil.isLoading
                                        ? 'Proccessing..'
                                        : 'Update',
                                    // 'Sign In'.toUpperCase(),
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    profil.updateProfil(context);
                                  }
                                },
                              ),
                            ),
                            SizedBox(height: 30.0),
                            Text(
                              "Or change password account",
                              style: TextStyle(color: Colors.grey),
                            ),
                            SizedBox(height: 25.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  child: Text("Update Password",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary)),
                                  onTap: () {
                                    Get.to(UpdatePassword(),
                                        binding: PasswordBinding());
                                  },
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
