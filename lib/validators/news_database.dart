import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('news_update');

class Database {
  static String? userId;

  static Future<void> addNews({
    required String title,
    required String description,
    required String newsImage,

  })async{
    DocumentReference documentReference = _mainCollection.doc(userId).collection('news').doc();

    Map<String, dynamic> data = <String, dynamic>{
      "title":title,
      "description":description,
      "newsImage": newsImage,
    };

    await documentReference.set(data).whenComplete(() => print("Note news inserted to the database")).catchError((e)=> print(e));
  }

  static Future<void> updateNews({
    required String title,
    required String description,
    required String docId,
    required String newsImage,

  })async{
    DocumentReference documentReference = _mainCollection.doc(userId).collection('news').doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "title":title,
      "description":description,
      "newsImage": newsImage,
    };

    await documentReference.set(data).whenComplete(() => print("Note item updated to the database")).catchError((e)=> print(e));
  }

  static Stream<QuerySnapshot> readNews(){
    userId= 'idsYYJmcKdoRJYIqMcxp';
    CollectionReference NewsCollection = _mainCollection.doc(userId).collection('news');

    return NewsCollection.snapshots();
  }

  static Future<void> deleteNews({
    required String docId,
  })async{
    DocumentReference documentReference = _mainCollection.doc(userId).collection('news').doc(docId);

    await documentReference.delete().whenComplete(() => print("Note news deleted from the database")).catchError((e)=>print(e));
  }
}
