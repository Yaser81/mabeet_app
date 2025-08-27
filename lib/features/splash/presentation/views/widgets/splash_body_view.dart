import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:mabeet_app/core/utilities/asset_images.dart';
import 'package:mabeet_app/home_screen.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../../core/constant.dart';
import 'animated_text.dart';

class SplashBodyView extends StatefulWidget {
  const SplashBodyView({super.key});

  @override
  State<SplashBodyView> createState() => _SplashBodyViewState();
}

class _SplashBodyViewState extends State<SplashBodyView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slidingAnimation;
  late Animation<double> _fadeAnimation;
  @override
  void initState() {
    super.initState();
    initAnimations();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        crossAxisAlignment: CrossAxisAlignment.stretch,

        children: [
          Image.asset(AssetImages.logo, height: 300),

          AnimatedText(
            fadeAnimation: _fadeAnimation,
            slidingAnimation: _slidingAnimation,
          ),
        ],
      ),
      nextScreen: const HomeScreen(),
      splashIconSize: 350,
      duration: 250, // الوقت بالملي ثانية
      splashTransition: SplashTransition.scaleTransition,
      pageTransitionType: PageTransitionType.rightToLeftWithFade,
      backgroundColor: Colors.white,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void initAnimations() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _slidingAnimation = Tween<Offset>(begin: Offset(0, 1), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOut, // حركة انسيابية
          ),
        );
    // الشفافية (Fade) من 0 → 1
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    _animationController.forward();
  }
}
