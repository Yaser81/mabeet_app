import 'package:flutter/material.dart';

import 'widgets/splash_body_view.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SplashBodyView());
  }
}
