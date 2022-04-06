
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:game_reviewer_application/IT19051826/pages/view_game.dart';
import '../common/commons.dart';
import 'add_game.dart';
import 'app_bar.dart';

class ShowDetails extends StatelessWidget {
  const ShowDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 100,
        backgroundColor: Colors.amberAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0)),
        ),
        title: AppBarTitle(
          sectionName: 'App',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddGame(),
            ),
          );
        },
        backgroundColor: Colors.amberAccent,
        child: Icon(
          Icons.add,
          color: Colors.black,
          size: 32,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 20.0),
          child: GamingList(),
        ),
      ),
    );
  }
}
