import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('games');

class Game_Database {
  static String? gameId;

  static Future<void> addGameDetails({
    required String gameImage,
    required String gameName,
    required String category,
    required String developer,
    required String price,
    required String rank,
    required String noOfPlayers,
    required String description,
  }) async {
    DocumentReference documentReference =
        _mainCollection.doc('gameId').collection('game').doc();

    Map<String, dynamic> data = <String, dynamic>{
      "gameImage": gameImage,
      "gameName": gameName,
      "category": category,
      "developer": developer,
      "price": price,
      "rank": rank,
      "noOfPlayers": noOfPlayers,
      "description": description,
    };

    await documentReference
        .set(data)
        .whenComplete(() => print("Game details added to the database"))
        .catchError((e) => print(e));
  }

  static Future<void> updateGameDetails({
    //required String gameImage,
    required String gameName,
    required String category,
    required String developer,
    required String price,
    required String rank,
    required String noOfPlayers,
    required String description,
    required String docId,
  }) async {
    DocumentReference documentReference =
        _mainCollection.doc('gameId').collection('game').doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      //"gameImage": gameImage,
      "gameName": gameName,
      "category": category,
      "developer": developer,
      "price": price,
      "rank": rank,
      "noOfPlayers": noOfPlayers,
      "description": description,
    };

    await documentReference
        .set(data)
        .whenComplete(() => print("Game Details Updated "))
        .catchError((e) => print(e));
  }

  static Stream<QuerySnapshot> readGameDetails() {
    CollectionReference gameCollection =
        _mainCollection.doc('gameId').collection('game');

    return gameCollection.snapshots();
  }


  static Future<void> deleteGameDetails({
    required String docId,
  }) async {
    DocumentReference documentReference =
        _mainCollection.doc('gameId').collection('game').doc(docId);

    await documentReference
        .delete()
        .whenComplete(() => print("Game details deleted from the database"))
        .catchError((e) => print(e));
  }
}
