import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hastrade/page/presentations/login/login_binding.dart';
import 'package:hastrade/page/presentations/onboarding/oanboarding_controller.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../../widgets/button.dart';
import '../login/login_page.dart';

class OnBoardingPage extends GetView<OnboardingController> {
  static const routeName = "/onboarding";

  @override
  Widget build(BuildContext context) => SafeArea(
        child: IntroductionScreen(
          pages: [
            PageViewModel(
              title: 'HasTrade',
              body:
                  'Metode edukasi saham dengan referensi stock pick yang mudah dan praktis',
              image: buildImage('assets/ebook.png'),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'Kenapa belajar saham dengan HasTrade',
              body:
                  'Karena hanya HasTrade yang memberikan one stop solution, dengan bimbingan terintensif, dan praktis, bisa langsung diterapkan',
              image: buildImage('assets/readingbook.png'),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'Pahami pasar saham dengan HasTrade',
              body: 'Ribuan trader di seluruh Indonesia mempercayai HasTrade',
              image: buildImage('assets/manthumbs.png'),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title:
                  'Apakah anda sudah siap untuk menjadi trader Profesional ?',
              body: '',
              footer: ButtonWidget(
                text: 'Mari kita mulai',
                onClicked: () => Get.off(LoginPage(), binding: LoginBinding()),
              ),
              image: buildImage('assets/learn.png'),
              decoration: getPageDecoration(),
            ),
          ],
          done: Text('Start', style: TextStyle(fontWeight: FontWeight.w600)),
          onDone: () => Get.off(LoginPage(), binding: LoginBinding()),
          showSkipButton: true,
          skip: Text('Skip'),
          onSkip: () => Get.off(LoginPage(), binding: LoginBinding()),
          next: Icon(Icons.arrow_forward),
          dotsDecorator: getDotDecoration(),
          onChange: (index) => print('Page $index selected'),
          globalBackgroundColor: Theme.of(context).bottomAppBarColor,
          skipFlex: 0,
          nextFlex: 0,
          // isProgressTap: false,
          // isProgress: false,
          // showNextButton: false,
          // freeze: true,
          // animationDuration: 1000,
        ),
      );

  // void goToHome(context) => Navigator.of(context).pushReplacement(
  //       MaterialPageRoute(builder: (_) => LoginPage()),
  //     );

  Widget buildImage(String path) =>
      Center(child: Image.asset(path, width: 350));

  DotsDecorator getDotDecoration() => DotsDecorator(
        color: Color(0xFFBDBDBD),
        //activeColor: Colors.orange,
        size: Size(10, 10),
        activeSize: Size(22, 10),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      );

  PageDecoration getPageDecoration() => PageDecoration(
        titleTextStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        bodyTextStyle: TextStyle(fontSize: 20),
        descriptionPadding: EdgeInsets.all(16).copyWith(bottom: 0),
        imagePadding: EdgeInsets.all(24),
        pageColor: Colors.white,
      );
}
