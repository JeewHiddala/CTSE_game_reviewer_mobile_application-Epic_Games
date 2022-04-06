import 'package:flutter/material.dart';
import '../model/games.dart';
import '../styleguide/text_styles.dart';
import 'label_value_widget.dart';


//Techie Blossom Video Game Messaging App – Part2 and Part3  tutorial is used for developing attractive user interfaces
class GameDetailsWidget extends StatelessWidget {
  final Games game;

  GameDetailsWidget({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      child: Container(
        height: 180.0,
        padding: const EdgeInsets.only(
            left: 20.0, right: 16.0, top: 24.0, bottom: 12.0),
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topRight,
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: Colors.grey.withOpacity(0.4), width: 2.0),
                    ),
                    height: 40.0,
                    width: 40.0,
                    child: Center(
                        child: Text(
                      game.rating,
                      style: rankStyle,
                    )),
                  ),
                  Text("new", style: labelTextStyle),
                ],
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                LabelValueWidget(
                  value: game.price,
                  label: "Price",
                  labelStyle: labelTextStyle,
                  valueStyle: valueTextStyle,
                ),
                LabelValueWidget(
                  value: game.rating,
                  label: "Rating",
                  labelStyle: labelTextStyle,
                  valueStyle: valueTextStyle,
                ),
                LabelValueWidget(
                  value: game.noOfPlayers,
                  label: "Players",
                  labelStyle: labelTextStyle,
                  valueStyle: valueTextStyle,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
