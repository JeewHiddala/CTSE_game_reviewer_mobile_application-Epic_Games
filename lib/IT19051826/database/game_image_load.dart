import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class FireStorageService extends ChangeNotifier{
  FireStorageService();
  static Future<String> loadImage(BuildContext context, String image) async{
    return await FirebaseStorage.instance.ref().child(image).getDownloadURL();
  }

  static loadFromStorage(BuildContext context, String gameImage) async {
    return await FirebaseStorage.instance
        .ref()
        .child(gameImage)
        .getDownloadURL();
  }
}

