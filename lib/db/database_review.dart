import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('test');

class ReviewDatabase {
  static String? gameId;

  static Future<void> addReview({
    required String title,
    required double rating,
    required String userName,
    required String description,

  })async{
    DocumentReference documentReference = _mainCollection.doc(gameId).collection('reviews').doc();

    Map<String, dynamic> data = <String, dynamic>{
      "title":title,
      "rating":rating,
      "userName":userName,
      "description":description,
      "timestamp": DateTime.now(),
    };

    await documentReference.set(data).whenComplete(() => print("Review inserted to the database")).catchError((e)=> print(e));
  }

  static Stream<QuerySnapshot> readReviewInfo(){
    CollectionReference reviewCollection = _mainCollection.doc(gameId).collection('reviews');
    return reviewCollection.snapshots();
  }

  static Future<void> updateReview({
    required String title,
    required double rating,
    required String userName,
    required String description,
    required String docId,
  })async{
    DocumentReference documentReference = _mainCollection.doc(gameId).collection('reviews').doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "title":title,
      "rating":rating,
      "userName":userName,
      "description":description,
      "timestamp": DateTime.now(),
    };

    await documentReference.set(data).whenComplete(() => print("Review updated in the database")).catchError((e)=> print(e));
  }

  static Future<void> deleteReview({
    required String docId,
  })async{
    DocumentReference documentReference = _mainCollection.doc(gameId).collection('reviews').doc(docId);

    await documentReference.delete().whenComplete(() => print("Review deleted from the database")).catchError((e)=>print(e));
  }
}