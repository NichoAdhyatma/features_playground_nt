import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:note_taker/constants/theme.dart';
import 'package:note_taker/screens/intro_screen/listPageView.dart';
import 'package:get/get.dart';
import 'package:note_taker/screens/auth/login_screen.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);
  static const routeName = '/intro';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DoubleBackToCloseApp(
        snackBar: const SnackBar(
          margin: EdgeInsets.all(25),
          backgroundColor: darkBlue,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          duration: Duration(seconds: 1),
          content: Text("Tekan sekali lagi untuk keluar"),
        ),
        child: IntroductionScreen(
          pages: listPageView,
          autoScrollDuration: 5,
          showNextButton: false,
          showSkipButton: true,
          done: const Text("Mulai"),
          skip: const Text("Lewati"),
          onDone: () {
            Get.offAllNamed(LoginScreen.routeName);
          },
          dotsDecorator: DotsDecorator(
            size: const Size.square(15.0),
            activeSize: const Size(20.0, 15.0),
            activeColor: Theme.of(context).colorScheme.primary,
            color: Colors.black26,
            spacing: const EdgeInsets.symmetric(horizontal: 10.0),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
          ),
          baseBtnStyle: TextButton.styleFrom(
            textStyle: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                fontSize: 18),
          ),
          globalFooter: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Langsung  aja ? "),
                  TextButton(
                    onPressed: () {
                      Get.offAllNamed(LoginScreen.routeName);
                    },
                    child: const Text("Masuk"),
                  ),
                ],
              ),
              ClipPath(
                clipper: WaveClipperOne(reverse: true),
                child: Stack(
                  children: [
                    Container(
                      width: Get.width,
                      height: Get.height * 0.12,
                      decoration: const BoxDecoration(color: primaryColor),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(top: 50.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/app-logo.png",
                            width: 25,
                            height: 25,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Note Taker 2.4.3",
                            style: labelTextStyle.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
