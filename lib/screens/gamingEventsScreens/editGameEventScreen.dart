
import 'package:flutter/material.dart';
import '../../collections/gamingEventsCollection.dart';
import 'app_bar.dart';
import 'editGameEventForm.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EditGameEventScreen extends StatefulWidget {

  final String currentName;
  final String currentGameName;
  final String currentTournamentMode;
  final String currentRewards;
  final String currentOrganizedBy;
  final String currentDate;
  final String currentTime;
  final String currentEventPosterUrl;
  final String documentId;

  const EditGameEventScreen({Key? key,
    required this.currentName,
    required this.currentGameName,
    required this.currentTournamentMode,
    required this.currentRewards,
    required this.currentOrganizedBy,
    required this.currentDate,
    required this.currentTime,
    required this.currentEventPosterUrl,
    required this.documentId,
  }) : super(key: key);

  @override
  _EditGameEventScreenState createState() => _EditGameEventScreenState();
}

class _EditGameEventScreenState extends State<EditGameEventScreen> {
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _gameNameFocusNode = FocusNode();
  final FocusNode _tournamentModeFocusNode = FocusNode();
  final FocusNode _rewardsFocusNode = FocusNode();
  final FocusNode _organizedByFocusNode = FocusNode();
  final FocusNode _dateFocusNode = FocusNode();
  final FocusNode _timeFocusNode = FocusNode();

  bool _isDeleting = false;

  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete ?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                // Text('Delete ?'),
                Text('Would you like delete game event permanently?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                setState(() {
                  _isDeleting = true;
                });

                await GamingEventsDatabase.deleteGameEvent(
                  docId: widget.documentId,
                );

                setState(() {
                  _isDeleting = false;
                });

                Fluttertoast.showToast(       //Toast Message
                  msg: "Game event Details Deleted Successfully",
                  fontSize:16,
                  backgroundColor: Colors.lightGreenAccent,
                  textColor: Colors.black,
                );

                Navigator.pop(context, 'OK');
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
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
          actions: [
            _isDeleting
                ? const Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0, right: 16.0,),
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.redAccent,
                ),
                strokeWidth: 3,
              ),
            ) : IconButton(
                onPressed: () async {
                  await _showMyDialog(context);
                },
                icon: const Icon(Icons.delete_forever, color: Colors.black, size: 32,)
            ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: 20.0,
            ),
            child: EditGameEventForm(
              documentId: widget.documentId,
              nameFocusNode: _nameFocusNode,
              gameNameFocusNode: _gameNameFocusNode,
              tournamentModeFocusNode: _tournamentModeFocusNode,
              rewardsFocusNode: _rewardsFocusNode,
              organizedByFocusNode: _organizedByFocusNode,
              dateFocusNode: _dateFocusNode,
              timeFocusNode: _timeFocusNode,

              currentName: widget.currentName,
              currentGameName: widget.currentGameName,
              currentTournamentMode: widget.currentTournamentMode,
              currentRewards: widget.currentRewards,
              currentOrganizedBy: widget.currentOrganizedBy,
              currentDate: widget.currentDate,
              currentTime: widget.currentTime,
              currentEventPosterUrl: widget.currentEventPosterUrl,
            ),
          ),
        ),
        // bottomNavigationBar:
        // BottomNavBar(selectedIndex:1,),
      ),
    );
  }
}
