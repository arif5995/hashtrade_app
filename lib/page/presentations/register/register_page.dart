import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hastrade/page/presentations/login/login_controller.dart';
import 'package:hastrade/page/presentations/login/login_page.dart';
import 'package:hastrade/page/presentations/register/register_%20controller.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../common/theme_helper.dart';
import '../../widgets/header_widget.dart';

class RegisterPage extends GetView<RegisterController> {
  const RegisterPage({Key? key}) : super(key: key);
  static const routeName = "/register";

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final loginCont = Get.put(LoginController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 150,
              child: HeaderWidget(150, false, Icons.person_add_alt_1_rounded),
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
                                  border:
                                      Border.all(width: 5, color: Colors.white),
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
                                  Icons.person,
                                  color: Colors.grey.shade300,
                                  size: 80.0,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(80, 80, 0, 0),
                                child: Icon(
                                  Icons.add_circle,
                                  color: Colors.grey.shade700,
                                  size: 25.0,
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
                            validator: (val) {
                              if (val!.isNotEmpty) {
                                controller.firstname.value = val;
                              } else {
                                return 'Enter Your First Name';
                              }
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          child: TextFormField(
                            decoration: ThemeHelper().textInputDecoration(
                                'Last Name', 'Enter your last name'),
                            validator: (val) {
                              if (val!.isNotEmpty) {
                                controller.lastname.value = val;
                              } else {
                                return 'Enter Your Last Name';
                              }
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            decoration: ThemeHelper().textInputDecoration(
                                "E-mail address", "Enter your email"),
                            keyboardType: TextInputType.emailAddress,
                            validator: (val) {
                              if (val!.isEmpty ||
                                  !RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                      .hasMatch(val)) {
                                return "Enter a valid email address";
                              } else {
                                controller.email.value = val;
                              }
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
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
                                padding: EdgeInsets.fromLTRB(20, 11, 20, 11),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                        color: Colors.grey.shade400)),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                child: Container(
                                    child: TextFormField(
                                  decoration: ThemeHelper().textInputDecoration(
                                      "Mobile Number",
                                      "Enter your mobile number"),
                                  keyboardType: TextInputType.phone,
                                  validator: (val) {
                                    if (val!.isEmpty ||
                                        !RegExp(r"^(\d+)*$").hasMatch(val)) {
                                      return "Enter a valid phone number";
                                    } else {
                                      controller.noTelp.value = val;
                                    }
                                  },
                                )),
                              )
                            ],
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            obscureText: true,
                            decoration: ThemeHelper().textInputDecoration(
                                "Password*", "Enter your password"),
                            validator: (val) {
                              print("PASS $val");
                              if (val!.isEmpty || val.length <= 5) {
                                return "Please enter your password";
                              } else {
                                controller.password.value = val;
                              }
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 15.0),
                        FormField<bool>(
                          builder: (state) {
                            return Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Obx(
                                      () => Checkbox(
                                          value: controller.checkBox.value,
                                          onChanged: (value) {
                                            controller.cekBox(value!);
                                          }),
                                    ),
                                    Text(
                                      "Anda harus menerima persyaratan\ndan ketentuan yang berlaku",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    state.errorText ?? '',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Theme.of(context).errorColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                )
                              ],
                            );
                          },
                          validator: (value) {
                            print("Val $value");
                            if (controller.checkBox.value == false) {
                              return 'Anda harus menerima persyaratan dan ketentuan yang berlaku';
                            }
                          },
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          decoration:
                              ThemeHelper().buttonBoxDecoration(context),
                          child: ElevatedButton(
                            style: ThemeHelper().buttonStyle(),
                            child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(40, 10, 40, 10),
                                child: Obx(
                                  () => Text(
                                    controller.isLoading.value
                                        ? 'Proccessing..'
                                        : 'Register',
                                    // 'Sign In'.toUpperCase(),
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                )),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                controller.register(context);
                              }
                            },
                          ),
                        ),
                        SizedBox(height: 30.0),
                        Text(
                          "atau masuk jika andau sudah memilik akun",
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(height: 25.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              child: Text("Login",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary)),
                              onTap: () {
                                Get.toNamed(LoginPage.routName);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    thickness: 1,
                    height: 1,
                    color: Colors.grey,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () async {
                            await link(loginCont.sosmed[0].dataValues!.url!);
                          },
                          icon: FaIcon(
                            FontAwesomeIcons.whatsapp,
                            color: Colors.green,
                          )),
                      IconButton(
                          onPressed: () async {
                            await link(loginCont.sosmed[1].dataValues!.url!);
                          },
                          icon: FaIcon(
                            FontAwesomeIcons.instagram,
                            color: Colors.redAccent,
                          )),
                      IconButton(
                          onPressed: () async {
                            await link(loginCont.sosmed[2].dataValues!.url!);
                          },
                          icon: FaIcon(
                            FontAwesomeIcons.twitter,
                            color: Colors.blue,
                          )),
                      IconButton(
                          onPressed: () async {
                            await link(loginCont.sosmed[3].dataValues!.url!);
                          },
                          icon: FaIcon(
                            FontAwesomeIcons.youtube,
                            color: Colors.redAccent,
                          )),
                      IconButton(
                          onPressed: () async {
                            await link(loginCont.sosmed[4].dataValues!.url!);
                          },
                          icon: FaIcon(
                            FontAwesomeIcons.facebook,
                            color: Colors.blue,
                          )),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future link(String url) async {
    if (await canLaunch(url)) {
      launch(url,
          forceSafariVC: false, forceWebView: false, enableJavaScript: true);
    }
  }
}
