import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:game_reviewer_application/screens/gamingEventsScreens/gameEventScreens.dart';

class GameEventSplashScreen extends StatefulWidget {
  const GameEventSplashScreen({Key? key}) : super(key: key);

  @override
  State<GameEventSplashScreen> createState() => _GameEventSplashScreenState();
}

class _GameEventSplashScreenState extends State<GameEventSplashScreen> {
  @override
  void initState(){
    super.initState();
    _navigatetohome();
  }

  _navigatetohome()async{
    await Future.delayed(Duration(milliseconds: 4000),() {});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> GameEventScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Colors.black,
              child: Container(
                // height: 100,
                // width: 100,
                child: Column(
                  children: [
                    Image.asset('images/gameevents.gif',),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                        'Epic Game Events',
                        style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
      // splash: 'images/splash.png',
      // nextScreen: GameEventScreen(),
      // splashTransition: SplashTransition.rotationTransition,
      // pageTransitionType: PageTransitionType.scale,
    );
  }
}


