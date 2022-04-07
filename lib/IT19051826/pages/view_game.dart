import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../common/commons.dart';
import '../database/game_details_database.dart';
import 'edit_game_screen.dart';

class GamingList extends StatefulWidget {
  const GamingList({Key? key}) : super(key: key);

  @override
  _GamingListState createState() => _GamingListState();
}


class _GamingListState extends State<GamingList> {


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Game_Database.readGameDetails(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }
        if (snapshot.hasData || snapshot.data != null) {
          print('ccc');
          return ListView.separated(
            padding: EdgeInsets.only(top: 16.0),
            separatorBuilder: (context, index) => SizedBox(height: 16.0),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              print('ss');
              var gameInfo =
              snapshot.data!.docs[index].data() as Map<String, dynamic>;
              String gameID = snapshot.data!.docs[index].id;
              //String gameImage = gameInfo['test/$fileName'];
              String gameName = gameInfo['gameName'];
              String category = gameInfo['category'];
              String developer = gameInfo['developer'];
              String price = gameInfo['price'];
              String rank = gameInfo['rank'];
              String noOfPlayers = gameInfo['noOfPlayers'];
              String description = gameInfo['description'];

              return Ink(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: ListTile(
                  trailing: Icon(
                    Icons.edit,
                    color: black,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  onTap: () =>
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              EditGameScreen(
                                currentGameName: gameName,
                                currentCategory: category,
                                currentPrice: price,
                                currentDeveloper: developer,
                                currentRank: rank,
                                currentNoOfPlayers: noOfPlayers,
                                currentDescription: description,
                                documentId: gameID,
                              ),
                        ),
                      ),
                  title: Text(
                    gameName,
                    style: TextStyle(
                        color: black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    category,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              );
            },
          );
        }


        return Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.orangeAccent),
          ),
        );
      },
    );
  }
}



