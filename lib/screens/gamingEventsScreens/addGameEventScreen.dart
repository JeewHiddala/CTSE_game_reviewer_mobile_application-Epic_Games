
import 'package:flutter/material.dart';

import 'addGameEventsForm.dart';
import 'app_bar.dart';

class AddGameEventScreen extends StatelessWidget {

  AddGameEventScreen({Key? key}) : super(key: key);

  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _gameNameFocusNode = FocusNode();
  final FocusNode _tournamentModeFocusNode = FocusNode();
  final FocusNode _rewardsFocusNode = FocusNode();
  final FocusNode _organizedByFocusNode = FocusNode();
  final FocusNode _dateFocusNode = FocusNode();
  final FocusNode _timeFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        _nameFocusNode.unfocus();
        _gameNameFocusNode.unfocus();
        _tournamentModeFocusNode.unfocus();
        _rewardsFocusNode.unfocus();
        _organizedByFocusNode.unfocus();
        _dateFocusNode.unfocus();
        _timeFocusNode.unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.amber,
          title: const AppBarTitle(
            sectionName: '',
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0,bottom: 20.0,),
            child: AddGameEventForm(
              nameFocusNode: _nameFocusNode,
              gameNameFocusNode: _gameNameFocusNode,
              tournamentModeFocusNode: _tournamentModeFocusNode,
              rewardsFocusNode: _rewardsFocusNode,
              organizedByFocusNode: _organizedByFocusNode,
              dateFocusNode: _dateFocusNode,
              timeFocusNode: _timeFocusNode,
            ),
          ),
        ),
        // bottomNavigationBar:
        // BottomNavBar(selectedIndex:1,),
      ),
    );
  }
}