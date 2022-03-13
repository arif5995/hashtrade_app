import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hastrade/page/presentations/splash/auth_controller.dart';

class SplashPage extends GetView<AuthController> {
  const SplashPage({Key? key}) : super(key: key);
  static const routeName = '/splash';

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: new BoxDecoration(
      //   gradient: new LinearGradient(
      //     colors: [Colors.white],
      //     begin: const FractionalOffset(0, 0),
      //     end: const FractionalOffset(1.0, 0.0),
      //     stops: [0.0, 1.0],
      //     tileMode: TileMode.clamp,
      //   ),
      // ),
      color: Colors.white,
      child: Obx(() => AnimatedOpacity(
            opacity: controller.isVisible.value ? 1.0 : 0,
            duration: Duration(milliseconds: 1200),
            child: Center(
              child: Container(
                height: 350.0,
                width: 350.0,
                child: Center(child: Image.asset('assets/hashtrade.jpeg')),
                // decoration: BoxDecoration(
                //     shape: BoxShape.circle,
                //     color: Colors.white,
                //     boxShadow: [
                //       BoxShadow(
                //         color: Colors.black.withOpacity(0.3),
                //         blurRadius: 2.0,
                //         offset: Offset(5.0, 3.0),
                //         spreadRadius: 2.0,
                //       )
                //     ]),
              ),
            ),
          )),
    );
  }
}
