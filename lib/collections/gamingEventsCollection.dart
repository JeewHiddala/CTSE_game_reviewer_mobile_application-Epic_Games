import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('users');

class GamingEventsDatabase {
  static String? userId;

  static Future<void> addGameEvent({
    required String name,
    required String gameName,
    required String tournamentMode,
    required String rewards,
    required String organizedBy,
    required String date,
    required String time,
    required String eventPosterUrl,
  })async{
    DocumentReference documentReference = _mainCollection.doc(userId).collection('gameEvents').doc();

    Map<String, dynamic> data = <String, dynamic>{
      "name":name,
      "gameName":gameName,
      "tournamentMode":tournamentMode,
      "rewards":rewards,
      "organizedBy":organizedBy,
      "date":date,
      "time":time,
      "eventPosterUrl":eventPosterUrl,
    };

    await documentReference.set(data).whenComplete(() => print("Game Event Inserted to the database")).catchError((e)=> print(e));
  }

  static Future<void> updateGameEvent({
    required String name,
    required String gameName,
    required String tournamentMode,
    required String rewards,
    required String organizedBy,
    required String date,
    required String time,
    required String eventPosterUrl,
    required String docId,
  })async{
    DocumentReference documentReference = _mainCollection.doc(userId).collection('gameEvents').doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "name":name,
      "gameName":gameName,
      "tournamentMode":tournamentMode,
      "rewards":rewards,
      "organizedBy":organizedBy,
      "date":date,
      "time":time,
      "eventPosterUrl":eventPosterUrl,
    };

    await documentReference.set(data).whenComplete(() => print("Game Event Updated to the database")).catchError((e)=> print(e));
  }

  static Stream<QuerySnapshot> retrieveGameEvent(){
    CollectionReference gameEventCollection = _mainCollection.doc(userId).collection('gameEvents');

    return gameEventCollection.snapshots();
  }

  static Future<void> deleteGameEvent({
    required String docId,
  })async{
    DocumentReference documentReference = _mainCollection.doc(userId).collection('gameEvents').doc(docId);

    await documentReference.delete().whenComplete(() => print("Game Event Deleted from the database")).catchError((e)=>print(e));
  }
}