import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
// import 'package:carousel_slider/carousel_slider.dart';
import 'addGameEventScreen.dart';
import 'app_bar.dart';
import 'gameEventList.dart';

class GameEventScreen extends StatefulWidget {
  const GameEventScreen({Key? key}) : super(key: key);

  @override
  _GameEventScreenState createState() => _GameEventScreenState();
}

class _GameEventScreenState extends State<GameEventScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.amber,
        title: const AppBarTitle(
          sectionName: '',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddGameEventScreen(),
            ),
          );
        },
        backgroundColor: Colors.amber,
        child: const Icon(
          Icons.add,
          color: Colors.black,
          size:32,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 12.0,right: 12.0,bottom: 20.0,),
          child: Column(
              children: [
                CarouselSlider(
                  options: CarouselOptions(height: 200.0),
                  items: ["images/cod.jpg", "images/pubg.jpg", "images/coc.jpg", "images/fortnite.jpg", "images/seshock.jpg"].map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: const BoxDecoration(
                                color: Colors.black
                            ),
                            // child: Text('text $i', style: TextStyle(fontSize: 16.0),)
                          child: Image.asset(i),
                        );
                      },
                    );
                  }).toList(),
                ),
                const GameEventList(),
              ]
          ),
        ),
      ),
      // bottomNavigationBar:
      // BottomNavBar(selectedIndex:1,),
    );
  }
}
