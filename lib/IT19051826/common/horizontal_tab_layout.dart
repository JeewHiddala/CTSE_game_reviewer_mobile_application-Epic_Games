
import 'package:flutter/cupertino.dart';
import 'package:game_reviewer_application/IT19051826/common/tab_text.dart';
import '../model/games.dart';
import 'game_card.dart';
//Techie Blossom Video Game Messaging App – Part2 and Part3  tutorial is used for developing attractive user interfaces

class HorizontalTabLayout extends StatefulWidget {
  @override
  _HorizontalTabLayoutState createState() => _HorizontalTabLayoutState();
}

class _HorizontalTabLayoutState extends State<HorizontalTabLayout> {
  int selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500.0,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: -20,
            bottom: 0,
            top: 100,
            width: 120.0,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 50.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TabText(
                    text: "All Games",
                    isSelected: selectedTabIndex == 0,
                    onTabTap: () {
                      onTabTap(0);
                    },
                  ),
                  TabText(
                    text: "Mobile Games",
                    isSelected: selectedTabIndex == 1,
                    onTabTap: () {
                      onTabTap(1);
                    },
                  ),
                  TabText(
                    text: "PC Games",
                    isSelected: selectedTabIndex == 2,
                    onTabTap: () {
                      onTabTap(2);
                    },
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 65.0, top: 40.0),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: getList(selectedTabIndex),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> getList(index) {
    return [
      [
        GameCard(game: fortniteGame),
        GameCard(game: pubgGame),
        GameCard(game: spidermanGame),
        GameCard(game: adventureGame),
      ],
      [
        GameCard(game: spidermanGame),
        GameCard(game: pubgGame),
      ],
      [
        GameCard(game: adventureGame),
      ]
    ][index];
  }

  onTabTap(int index) {
    setState(() {
      selectedTabIndex = index;
    });
  }
}
