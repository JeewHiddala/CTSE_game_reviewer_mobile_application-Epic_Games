import 'package:flutter/material.dart';
import 'package:game_reviewer_application/pages/splash_screen.dart';
import 'package:game_reviewer_application/screens/gamingEventsScreens/gameEventSplashScreen.dart';
import 'package:game_reviewer_application/screens/news_screens/news_splash.dart';
import 'IT19051826/common/bottom_nav.dart';
import 'IT19051826/pages/game_list.dart';


class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Padding(
          padding: EdgeInsets.only(left: 50.0, top: 5.0),
          child: Text(
            'Epic Game Reviewer',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 25,
            ),
          ),
        ),
      ),

      body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child: ListView(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,

              ),
          GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GameList(),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.all(10.0),
                    padding: const EdgeInsets.only(left: 5.0),
                    color: Colors.white,
                    height: 105.0,
                    child: Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Games',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 25,
                            ),
                          ),
                        ),
                        Expanded(
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Image.asset(
                              'assets/images/joystick.jpg',
                              height: 50,
                              width: 50,
                              // fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ),
              GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Splash(),
                  ),
                );
              },
              child:
              Center(
                child: Container(
                  margin: const EdgeInsets.all(10.0),
                  padding: const EdgeInsets.only(right: 5.0),
                  color: Colors.white,
                  height: 105.0,
                  child: Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'News',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 25,
                          ),
                        ),
                      ),
                      Expanded(
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Image.asset(
                            'assets/images/news.png',
                            height: 50,
                            width: 50,
                            // fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),
              GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GameEventSplashScreen(),
              ),
            );
          },
          child:
              Center(
                child: Container(
                  margin: const EdgeInsets.all(10.0),
                  padding: const EdgeInsets.only(left: 5.0),
                  color: Colors.white,
                  height: 105.0,
                  child: Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Events',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 25,
                          ),
                        ),
                      ),
                      Expanded(
                        child: FittedBox(
                          fit: BoxFit.contain, // otherwise the logo will be tiny
                          child: Image.asset(
                            'assets/images/trophy.png',
                            height: 50,
                            width: 50,
                            // fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
        ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SplashScreen(),
                    ),
                  );
                },
                child:
                Center(
                  child: Container(
                    margin: const EdgeInsets.all(10.0),
                    padding: const EdgeInsets.only(left: 5.0),
                    color: Colors.white,
                    height: 105.0,
                    child: Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Reviews',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 25,
                            ),
                          ),
                        ),
                        Expanded(
                          child: FittedBox(
                            fit: BoxFit.contain, // otherwise the logo will be tiny
                            child: Image.asset(
                              'assets/images/review.png',
                              height: 50,
                              width: 50,
                              // fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
      ),
      bottomNavigationBar: BottomNavBar(selectedIndex: 1,),
    );
  }
}
