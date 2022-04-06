import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';

class Storage {
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<void> uploadImage(
    String filePath,
    String fileName,
  ) async {
    File file = File(filePath);
    try {
      await storage.ref('game_events/$fileName').putFile(file);
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  Future<ListResult> getImages() async {
    ListResult results = await storage.ref('game_events').listAll();
    results.items.forEach((Reference ref) {
      print('File found: $ref');
    });
    return results;
  }

  Future<String> downloadUrl(String imageName) async{
    String downloadUrl = await storage.ref('game_events/$imageName').getDownloadURL();
    return downloadUrl;
  }

  // Future<String> downloadUrl(String pathName) async{
  //   print(pathName);
  //   String downloadUrl = await storage.ref(pathName).getDownloadURL();
  //   print(downloadUrl);
  //   return downloadUrl;
  // }
}
