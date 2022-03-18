import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hastrade/page/presentations/login/login_controller.dart';
import 'package:hastrade/page/presentations/password/forgot_pasword_page.dart';
import 'package:hastrade/page/presentations/password/password_binding.dart';
import 'package:hastrade/page/widgets/my_flutter_app_icons.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../common/theme_helper.dart';
import '../../widgets/header_widget.dart';
import '../register/register_page.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({Key? key}) : super(key: key);
  static const routName = "/login";

  @override
  Widget build(BuildContext context) {
    double _headerHeight = 250;
    final _formKey = GlobalKey<FormState>();
    final _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: _headerHeight,
              child: HeaderWidget(_headerHeight, true,
                  MyFlutterApp.logohastrade), //let's create a common header widget
            ),
            SafeArea(
              child: Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  margin: EdgeInsets.fromLTRB(
                      20, 10, 20, 10), // This will be the login form
                  child: Column(
                    children: [
                      Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 60, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Masukan Alamat Email dan Password',
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(height: 30.0),
                      Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Container(
                                child: TextFormField(
                                    decoration: ThemeHelper()
                                        .textInputDecoration(
                                            'Email', 'Masukan alamat email'),
                                    validator: (String? emailValue) {
                                      if (emailValue != null &&
                                          emailValue.isEmpty) {
                                        return 'Please enter your email';
                                      }
                                      controller.email.value = emailValue!;
                                      return null;
                                    }),
                                decoration:
                                    ThemeHelper().inputBoxDecorationShaddow(),
                              ),
                              SizedBox(height: 30.0),
                              Container(
                                child: Obx(
                                  () => TextFormField(
                                      obscureText: controller.visible.value,
                                      decoration: ThemeHelper()
                                          .textInputPasswordDecoration(
                                              lableText: 'Password',
                                              hintText: 'Masukkan Password',
                                              onTap: () {
                                                controller.hidePass();
                                              },
                                              icon: Icon(
                                                  controller.visible.value
                                                      ? Icons.visibility
                                                      : Icons.visibility_off,
                                                  color: Theme.of(context)
                                                      .primaryColorDark)),
                                      validator: (String? passwordValue) {
                                        if (passwordValue != null &&
                                            passwordValue.isEmpty) {
                                          return 'Please enter your password';
                                        }
                                        controller.password.value =
                                            passwordValue!;
                                        return null;
                                      }),
                                ),
                                decoration:
                                    ThemeHelper().inputBoxDecorationShaddow(),
                              ),
                              SizedBox(height: 15.0),
                              Container(
                                margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
                                alignment: Alignment.topRight,
                                child: GestureDetector(
                                  onTap: () {
                                    Get.to(ForgotPasswordPage(),
                                        binding: PasswordBinding());
                                  },
                                  child: Text(
                                    "Lupa password?",
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration:
                                    ThemeHelper().buttonBoxDecoration(context),
                                child: ElevatedButton(
                                  style: ThemeHelper().buttonStyle(),
                                  child: Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(40, 10, 40, 10),
                                      child: Obx(
                                        () => Text(
                                          controller.isLoading.value
                                              ? 'Proccessing..'
                                              : 'Login',
                                          // 'Sign In'.toUpperCase(),
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      )),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      controller.Login(context);
                                    }
                                  },
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                                //child: Text('Don\'t have an account? Create'),
                                child: Text.rich(TextSpan(children: [
                                  TextSpan(text: "Belum punya akun? "),
                                  TextSpan(
                                    text: 'Buat Akun',
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Get.toNamed(RegisterPage.routeName);
                                      },
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary),
                                  ),
                                ])),
                              ),
                            ],
                          )),
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
                                await link(
                                    controller.sosmed[0].dataValues!.url!);
                              },
                              icon: FaIcon(
                                FontAwesomeIcons.whatsapp,
                                color: Colors.green,
                              )),
                          IconButton(
                              onPressed: () async {
                                await link(
                                    controller.sosmed[1].dataValues!.url!);
                              },
                              icon: FaIcon(
                                FontAwesomeIcons.instagram,
                                color: Colors.redAccent,
                              )),
                          IconButton(
                              onPressed: () async {
                                await link(
                                    controller.sosmed[2].dataValues!.url!);
                              },
                              icon: FaIcon(
                                FontAwesomeIcons.twitter,
                                color: Colors.blue,
                              )),
                          IconButton(
                              onPressed: () async {
                                await link(
                                    controller.sosmed[3].dataValues!.url!);
                              },
                              icon: FaIcon(
                                FontAwesomeIcons.youtube,
                                color: Colors.redAccent,
                              )),
                          IconButton(
                              onPressed: () async {
                                await link(
                                    controller.sosmed[4].dataValues!.url!);
                              },
                              icon: FaIcon(
                                FontAwesomeIcons.facebook,
                                color: Colors.blue,
                              )),
                        ],
                      )
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Future link(String url) async {
    if (await canLaunch(url)) {
      print("WEB ${controller.sosmed[0].dataValues?.url}");
      launch(url,
          forceSafariVC: false, forceWebView: false, enableJavaScript: true);
    }
  }
}
