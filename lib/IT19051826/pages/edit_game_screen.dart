import 'package:flutter/material.dart';
import '../common/commons.dart';
import '../database/game_details_database.dart';
import 'app_bar.dart';
import 'edit_game_form.dart';

class EditGameScreen extends StatefulWidget {
  final String documentId;
  final String currentGameName;
  final String currentCategory;
  final String currentDeveloper;
  final String currentPrice;
  final String currentRank;
  final String currentNoOfPlayers;
  final String currentDescription;

  EditGameScreen({
    required this.currentGameName,
    required this.currentCategory,
    required this.currentDeveloper,
    required this.currentPrice,
    required this.currentRank,
    required this.currentNoOfPlayers,
    required this.currentDescription,
    required this.documentId,
  });

  @override
  _EditGameScreenState createState() => _EditGameScreenState();
}

class _EditGameScreenState extends State<EditGameScreen> {
  final FocusNode _gameNameFocusNode = FocusNode();
  final FocusNode _categoryFocusNode = FocusNode();
  final FocusNode _developerFocusNode = FocusNode();
  final FocusNode _priceFocusNode = FocusNode();
  final FocusNode _rankFocusNode = FocusNode();
  final FocusNode _noOfPlayersFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();

  bool _isDeleting = false;

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
          actions: [
            _isDeleting
                ? Padding(
                    padding: const EdgeInsets.only(
                      top: 10.0,
                      bottom: 10.0,
                      right: 16.0,
                    ),
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.redAccent,
                      ),
                      strokeWidth: 3,
                    ),
                  )
                : IconButton(
                    onPressed: () async {
                      setState(() {
                        _isDeleting = true;
                      });

                      await Game_Database.deleteGameDetails(
                        docId: widget.documentId,
                      );
                      setState(() {
                        _isDeleting = false;
                      });
                      SnackBar(
                        content: const Text('Game Details Deleted'),
                      );
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.delete_forever,
                      color: Colors.black,
                      size: 32,
                    )),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: 20.0,
            ),
            child: EditGameDetailsForm(
              documentId: widget.documentId,
              gameNameFocusNode: _gameNameFocusNode,
              categoryFocusNode: _categoryFocusNode,
              developerFocusNode: _developerFocusNode,
              priceFocusNode: _priceFocusNode,
              rankFocusNode: _rankFocusNode,
              noOfPlayersFocusNode: _noOfPlayersFocusNode,
              descriptionFocusNode: _descriptionFocusNode,
              currentGameName: widget.currentGameName,
              currentCategory: widget.currentCategory,
              currentDeveloper: widget.currentDeveloper,
              currentPrice: widget.currentPrice,
              currentRank: widget.currentRank,
              currentNoOfPlayers: widget.currentNoOfPlayers,
              currentDescription: widget.currentDescription,
            ),
          ),
        ),
      ),
    );
  }
}
