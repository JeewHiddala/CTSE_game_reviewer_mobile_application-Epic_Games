import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:game_reviewer_application/pages/splash_screen.dart';
import 'db/database_review.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  // final Future<FirebaseApp> _initialization = Firebase.initializeApp();


  // This widget is the root of your application.
  @override


  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print('Error occured');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(),);
        }
        ReviewDatabase.gameId = "6OCSUsjJ1qQ5qmNJKDOW";
        return MaterialApp(
          title: 'Game Reviewer',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.amber,
          ),
          home: const SplashScreen(),
        );
      },
    );
  }
}