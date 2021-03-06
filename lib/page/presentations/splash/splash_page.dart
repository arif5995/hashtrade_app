import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hastrade/page/presentations/splash/auth_controller.dart';

class SplashPage extends GetView<AuthController> {
  const SplashPage({Key? key}) : super(key: key);
  static const routeName = '/splah';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
          colors: [
            Theme.of(context).colorScheme.secondary,
            Theme.of(context).primaryColor
          ],
          begin: const FractionalOffset(0, 0),
          end: const FractionalOffset(1.0, 0.0),
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp,
        ),
      ),
      child: Obx(() => AnimatedOpacity(
            opacity: controller.isVisible.value ? 1.0 : 0,
            duration: Duration(milliseconds: 1200),
            child: Center(
              child: Container(
                height: 140.0,
                width: 140.0,
                child: Center(
                  child: ClipOval(
                    child: Icon(
                      Icons.android_outlined,
                      size: 128,
                    ), //put your logo here
                  ),
                ),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 2.0,
                        offset: Offset(5.0, 3.0),
                        spreadRadius: 2.0,
                      )
                    ]),
              ),
            ),
          )),
    );
  }
}
