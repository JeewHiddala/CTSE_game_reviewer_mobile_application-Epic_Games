import 'package:flutter/material.dart';
import '../model/games.dart';
import '../pages/details_page.dart';
import 'game_details_widget.dart';
import 'game_name_widget.dart';


//Techie Blossom Video Game Messaging App – Part2 and Part3  tutorial is used for developing attractive user interfaces
class GameCard extends StatelessWidget {
  final Games game;

  GameCard({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: game.gameName,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailsPage(
                          game: game,
                        )));
          },
          child: SizedBox(
            width: 280.0,
            child: Card(
              margin:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 60.0),
              elevation: 20.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                child: Stack(
                  children: <Widget>[
                    Image.asset(
                      game.imagePath,
                      fit: BoxFit.fitWidth,
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: GameDetailsWidget(game: game),
                    ),
                    Positioned(
                      left: 0,
                      bottom: 80.0,
                      child: GameNameWidget(game: game),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
