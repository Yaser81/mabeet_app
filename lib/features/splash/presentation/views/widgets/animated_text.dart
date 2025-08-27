import 'package:flutter/material.dart';

import '../../../../../core/constant.dart';

class AnimatedText extends StatelessWidget {
  const AnimatedText({
    super.key,
    required Animation<double> fadeAnimation,
    required Animation<Offset> slidingAnimation,
  }) : _fadeAnimation = fadeAnimation,
       _slidingAnimation = slidingAnimation;

  final Animation<double> _fadeAnimation;
  final Animation<Offset> _slidingAnimation;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slidingAnimation,
        child: const Text(
          AppTitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Color(0xff023663),
          ),
        ),
      ),
    );
  }
}
