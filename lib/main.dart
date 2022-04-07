import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:game_reviewer_application/screens/gamingEventsScreens/gameEventScreens.dart';
import 'package:game_reviewer_application/screens/gamingEventsScreens/gameEventSplashScreen.dart';
import 'package:provider/provider.dart';
import 'collections/gamingEventsCollection.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  // const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context){
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot){
        if(snapshot.hasError){
          print('Error occured');
        }
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator(),);
        }
        GamingEventsDatabase.userId = "uTodvKrEdM8glyifJD1K";
        return MaterialApp(
          title: 'Epic Games',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.amber,
          ),
          home: const GameEventSplashScreen(),
          // home: AnimatedSplashScreen(
          //     splash: const Image(image: AssetImage('images/epicgames.jpg')),
          //     duration: 3000,
          //     splashIconSize: 300,
          //     splashTransition: SplashTransition.fadeTransition,
          //     // pageTransitionType: PageTransitionType.scale,
          //     backgroundColor: Colors.black,
          //     nextScreen: GameEventScreen()),
        );
      },
    );
  }
}
