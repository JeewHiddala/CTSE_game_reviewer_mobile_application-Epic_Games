// animated splash screen using coding cafe tutorial

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'newsList.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        splash: Image.asset(
          'images/news_icon.png',
        ),
        nextScreen: NewsList(),
        splashTransition: SplashTransition.rotationTransition,
        backgroundColor: Colors.amberAccent,
      ),
    );
  }
}
