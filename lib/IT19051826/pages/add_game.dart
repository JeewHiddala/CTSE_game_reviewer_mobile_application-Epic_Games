import 'package:flutter/material.dart';
import '../common/commons.dart';
import 'app_bar.dart';
import 'games.dart';

class AddGame extends StatelessWidget {
  //final FocusNode _gameImageFocusNode = FocusNode();
  final FocusNode _gameNameFocusNode = FocusNode();
  final FocusNode _categoryFocusNode = FocusNode();
  final FocusNode _developerFocusNode = FocusNode();
  final FocusNode _priceFocusNode = FocusNode();
  final FocusNode _rankFocusNode = FocusNode();
  final FocusNode _noOfPlayersFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _gameNameFocusNode.unfocus();
        _categoryFocusNode.unfocus();
        _developerFocusNode.unfocus();
        _priceFocusNode.unfocus();
        _rankFocusNode.unfocus();
        _noOfPlayersFocusNode.unfocus();
        _descriptionFocusNode.unfocus();
      },
      child: Scaffold(
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
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              bottom: 20.0,
            ),
            child: Game(
              gameNameFocusNode: _gameNameFocusNode,
              categoryFocusNode: _categoryFocusNode,
              developerFocusNode: _developerFocusNode,
              priceFocusNode: _priceFocusNode,
              rankFocusNode: _rankFocusNode,
              noOfPlayersFocusNode: _noOfPlayersFocusNode,
              descriptionFocusNode: _descriptionFocusNode,
            ),
          ),
        ),
      ),
    );
  }
}
