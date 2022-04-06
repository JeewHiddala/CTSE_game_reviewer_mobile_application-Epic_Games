import 'package:flutter/material.dart';
import '../model/games.dart';
import '../styleguide/text_styles.dart';
import 'commons.dart';

class GameNameWidget extends StatelessWidget {
  final Games game;

  GameNameWidget({required this.game});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: primaryColor1,
      elevation: 20.0,
      borderRadius: BorderRadius.circular(20),

      /*shape: CustomShapeBorder(),*/
      child: Padding(
        padding: const EdgeInsets.only(
            top: 10.0, left: 20.0, right: 16.0, bottom: 8.0),
        child: Text(
          game.gameName,
          style: forumNameTextStyle,
        ),
      ),
    );
  }
}
