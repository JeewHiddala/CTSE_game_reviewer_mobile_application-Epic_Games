import 'package:flutter/material.dart';

import '../common/label_value_widget.dart';
import '../model/games.dart';
import '../styleguide/text_styles.dart';
//Techie Blossom Video Game Messaging App – Part2 and Part3  tutorial is used for developing attractive user interfaces
class DetailsPage extends StatelessWidget {
  final Games game;

  DetailsPage({required this.game});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      body: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 60.0,
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 100.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    LabelValueWidget(
                      value: game.price,
                      label: "Price",
                      labelStyle: whiteLabelTextStyle,
                      valueStyle: whiteValueTextStyle,
                    ),
                    LabelValueWidget(
                      value: game.rating,
                      label: "Rating",
                      labelStyle: whiteLabelTextStyle,
                      valueStyle: whiteValueTextStyle,
                    ),
                    LabelValueWidget(
                      value: game.noOfPlayers,
                      label: "Players",
                      labelStyle: whiteLabelTextStyle,
                      valueStyle: whiteValueTextStyle,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Hero(
                tag: game.gameName,
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(60.0)),
                  child: Container(
                      width: 500,
                      height: 500,
                      child: Image.asset(game.imagePath)),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: ClipRRect(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(60.0)),
              child: Container(
                height: 200.0,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            bottom: 180.0,
            right: 20.0,
            child: Material(
              elevation: 10.0,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  game.rating,
                  style: rankStyle,
                ),
              ),
              color: Colors.white,
              shape: CircleBorder(),
            ),
          ),
          Positioned(
            bottom: 140.0,
            left: 160.0,
            child: Material(
              child: Text(
                game.gameName,
                style: headingStyle,
              ),
            ),
          ),
          Positioned(
            bottom: 100.0,
            left: 140.0,
            child: Material(
              child: Text(
                game.developer,
                style: headingStyle,
              ),
            ),
          ),
          Positioned(
            bottom: 50.0,
            left: 10.0,
            child: Material(
              child: Text(
                game.description,
                style: headingStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
