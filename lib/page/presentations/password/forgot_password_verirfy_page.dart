import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hastrade/page/presentations/password/password_controller.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

import '../../widgets/header_widget.dart';

class ForgotPasswordVerirfyPage extends GetView<PasswordController> {
  const ForgotPasswordVerirfyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    OtpFieldController otpFieldController = OtpFieldController();
    bool _pinSuccess = false;
    double _headerHeight = 300;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: _headerHeight,
                child: HeaderWidget(
                    _headerHeight, true, Icons.privacy_tip_outlined),
              ),
              SafeArea(
                child: Container(
                  margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Verification',
                              style: TextStyle(
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                              // textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Masukkan kode verifikasi anda yang telah dikirim di whatsapp',
                              style: TextStyle(
                                  // fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                              // textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 40.0),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            OTPTextField(
                              length: 6,
                              width: 300,
                              controller: otpFieldController,
                              fieldWidth: 30,
                              style: TextStyle(fontSize: 30),
                              textFieldAlignment: MainAxisAlignment.spaceAround,
                              fieldStyle: FieldStyle.underline,
                              onCompleted: (val) {
                                controller.sendPin(
                                    val, context, otpFieldController);
                              },
                            ),
                            SizedBox(height: 10.0),
                            Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                  padding: const EdgeInsets.only(right: 25),
                                  child: Obx(
                                    () => Text(
                                      "00:${controller.time.value}",
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                  )),
                            ),
                            SizedBox(height: 30.0),
                            Obx(() {
                              return Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Jika kamu tidak menerima kode! ",
                                      style: TextStyle(
                                        color: Colors.black38,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'Kirim ulang',
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          controller.resendCoder(context);
                                          // showDialog(
                                          //   context: context,
                                          //   builder: (BuildContext context) {
                                          //     return ThemeHelper().alartDialog(
                                          //         "Successful",
                                          //         "Verification code resend successful.",
                                          //         context);
                                          //   },
                                          // );
                                        },
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: controller.resendCode.value
                                              ? Colors.blue
                                              : Colors.grey),
                                    ),
                                  ],
                                ),
                              );
                            }),
                            SizedBox(height: 40.0),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
    ;
  }
}
