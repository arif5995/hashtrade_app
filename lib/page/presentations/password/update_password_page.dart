import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hastrade/page/presentations/password/password_controller.dart';

import '../../../common/theme_helper.dart';
import '../../widgets/header_widget.dart';
import '../profil/profil_binding.dart';
import '../profil/update_profil.dart';

class UpdatePassword extends GetView<PasswordController> {
  const UpdatePassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Update Password",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevation: 0.5,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: GetBuilder<PasswordController>(
        builder: (controller) {
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
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(
                                          width: 5, color: Colors.white),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 20,
                                          offset: const Offset(5, 5),
                                        ),
                                      ],
                                    ),
                                    child: Icon(
                                      Icons.lock_open_rounded,
                                      color: Colors.grey.shade300,
                                      size: 80.0,
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
                                    'Password lama',
                                    'Enter your Password lama'),
                                validator: (val) {
                                  if (val!.isNotEmpty) {
                                    controller.passLama.value = val;
                                  } else {
                                    return 'Enter Your Password lama';
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
                                    'Password baru',
                                    'Enter your password baru'),
                                validator: (val) {
                                  if (val!.isNotEmpty) {
                                    controller.passBaru.value = val;
                                  } else {
                                    return 'Enter Your password baru';
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
                                    'Password baru ulang',
                                    'Enter your password baru ulangi'),
                                validator: (val) {
                                  if (val!.isNotEmpty) {
                                    controller.passBaruUlang.value = val;
                                  } else {
                                    return 'Enter Your password baru ulang';
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
                                    padding: const EdgeInsets.fromLTRB(
                                        40, 10, 40, 10),
                                    child: Obx(
                                      () => Text(
                                        controller.proses.value
                                            ? 'Proccessing..'
                                            : 'Update',
                                        // 'Sign In'.toUpperCase(),
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    )),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    controller.changePassword();
                                  }
                                },
                              ),
                            ),
                            SizedBox(height: 30.0),
                            Text(
                              "Or change profile update",
                              style: TextStyle(color: Colors.grey),
                            ),
                            SizedBox(height: 25.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  child: Text("Update Profil",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary)),
                                  onTap: () {
                                    Get.to(UpdateProfil(),
                                        binding: ProfilBinding());
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
