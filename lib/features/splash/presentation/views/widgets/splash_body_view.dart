import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:mabeet_app/home_screen.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../../core/constant.dart';

class SplashBodyView extends StatelessWidget {
  const SplashBodyView({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        children: [
          Image.asset('assets/logo.png', height: 100),
          const SizedBox(height: 10),
          const Text(
            AppTitle,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      nextScreen: const HomeScreen(),
      splashIconSize: 150,
      duration: 2500, // الوقت بالملي ثانية
      splashTransition: SplashTransition.scaleTransition,
      pageTransitionType: PageTransitionType.fade,
      backgroundColor: Colors.white,
    );
  }
}
