import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game_reviewer_application/screens/gamingEventsScreens/services/storage_service.dart';
import '../../collections/gamingEventsCollection.dart';
import 'editGameEventScreen.dart';

class GameEventList extends StatelessWidget {
  const GameEventList({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: GamingEventsDatabase.retrieveGameEvent(),
      builder: (context,snapshot){
        if(snapshot.hasError){
          return const Text('Something went wrong');
        }
        else if(snapshot.hasData || snapshot.data != null){
          return ListView.separated(
            padding: const EdgeInsets.only(top: 16.0),
            shrinkWrap: true,
            separatorBuilder: (context, index) => const SizedBox(height: 16.0),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index){
              var noteInfo = snapshot.data!.docs[index].data() as Map<String, dynamic>;
              String docID = snapshot.data!.docs[index].id;
              String name = noteInfo['name'];
              String gameName = noteInfo['gameName'];
              String tournamentMode = noteInfo['tournamentMode'];
              String rewards = noteInfo['rewards'];
              String organizedBy = noteInfo['organizedBy'];
              String date = noteInfo['date'];
              String time = noteInfo['time'];
              String eventPosterUrl = "";
              if(noteInfo['eventPosterUrl'] != null){
                eventPosterUrl = noteInfo['eventPosterUrl'];
              }

              // print("AB"+name);

              return Ink(
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: ListTile(
                  trailing:const Icon(
                    Icons.edit,
                    color: Colors.black,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => EditGameEventScreen(
                        currentName: name,
                        currentGameName: gameName,
                        currentTournamentMode: tournamentMode,
                        currentRewards: rewards,
                        currentOrganizedBy: organizedBy,
                        currentDate: date,
                        currentTime: time,
                        currentEventPosterUrl: eventPosterUrl,
                        documentId: docID,
                      ),
                    ),
                  ),
                  title: Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    ('$gameName'),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              );
            },
          );
        }
        return const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
          ),
        );

      },
    );
  }
}