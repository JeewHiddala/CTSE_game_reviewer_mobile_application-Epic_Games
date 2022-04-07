
import 'package:flutter/material.dart';
import 'package:game_reviewer_application/IT19051826/pages/show_game_details.dart';
import '../common/commons.dart';
import '../common/horizontal_tab_layout.dart';
import '../navigation/screen_navigation.dart';
import '../styleguide/text_styles.dart';
import 'app_bar.dart';

//Techie Blossom Video Game Messaging App – Part2 and Part3  tutorial is used for developing attractive user interfaces
class GameList extends StatelessWidget {
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
          sectionName: '',
        ),
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
              top: 50,
              left: 130,
              child: Text(
                "Game Details",
                style: buttonStyle,
              )),
          Center(
            child: HorizontalTabLayout(),
          ),
          Spacer(),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 60.0, vertical: 30.0),
              child: GestureDetector(
                onTap: () {
                  changeScreen(context, ShowDetails());
                },
                child: Text(
                  'Add Games',
                  style: headingStyle,
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.amberAccent,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(40.0)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
