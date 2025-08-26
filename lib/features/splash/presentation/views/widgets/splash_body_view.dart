import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:mabeet_app/core/utilities/asset_images.dart';
import 'package:mabeet_app/home_screen.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../../core/constant.dart';

class SplashBodyView extends StatelessWidget {
  const SplashBodyView({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        crossAxisAlignment: CrossAxisAlignment.stretch,

        children: [
          Image.asset(AssetImages.logo, height: 300),

          const Text(
            AppTitle,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      nextScreen: const HomeScreen(),
      splashIconSize: 350,
      duration: 2500, // الوقت بالملي ثانية
      splashTransition: SplashTransition.scaleTransition,
      pageTransitionType: PageTransitionType.fade,
      backgroundColor: Colors.white,
    );
  }
}
