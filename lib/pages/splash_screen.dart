import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:game_reviewer_application/pages/review_list.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const String routeName = '/splash';

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        duration: 6500,
        splash: 'assets/review.gif',
        splashIconSize: double.maxFinite,
        nextScreen: ReviewList(),
        splashTransition: SplashTransition.sizeTransition,
        pageTransitionType: PageTransitionType.fade,
        backgroundColor: Colors.amber
    );
  }
}
