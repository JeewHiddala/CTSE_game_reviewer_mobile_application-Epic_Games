import 'package:flutter/material.dart';
import 'package:epic_games_app/news_screens/newsList.dart';
import 'package:epic_games_app/news_screens/addNewNewsScreen.dart';
import 'addNewNewsScreen.dart';
import 'newsList.dart';

class NewsDetails extends StatefulWidget {
  const NewsDetails({Key? key}) : super(key: key);

  @override
  _NewsDetailsState createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
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
              'Epic Games',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 25,
              ),
            ),
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: (){
        //     Navigator.of(context).push(
        //       MaterialPageRoute(
        //         builder: (context) => NewsScreen(),
        //       ),
        //     );
        //   },
        //   backgroundColor: Colors.amber,
        //   child: Icon(
        //     Icons.add,
        //     color: Colors.white,
        //     size: 32,
        //   ),
        // ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0,right: 16.0,bottom: 20, top: 25.0,),
            child:

            NewsList(),

          ),
        ),
        );
  }
}
