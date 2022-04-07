import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../validators/news_database.dart';
import 'addNewNewsScreen.dart';
import 'edit_news_screen.dart';
import 'package:flutter/cupertino.dart';


class NewsList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    // Future<ListResult> getImages() async {
    //   ListResult results = await storage.ref('news_images').listAll();
    //   results.items.forEach((Reference ref) {
    //     print('Image found: $ref');
    //   });
    //   return results;
    // }

    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.amber,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: const Padding(
            padding: EdgeInsets.only(left: 50.0, top: 5.0),
            child: Text(
              'Epic Games',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 25,
                color: Colors.black,
              ),
            ),
          ),
        ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => NewsScreen(
              ),
            ),
          );
        },
        backgroundColor: Colors.orangeAccent,
        child: Icon(
          Icons.add,
          color: Colors.black,
          size:32,
        ),
      ),

        body:StreamBuilder<QuerySnapshot>(
          stream: Database.readNews(),
          builder: (context,snapshot){
            if(snapshot.hasError){
              return Text('Something went wrong');
            }
            else if(snapshot.hasData || snapshot.data != null){
              return ListView.separated(
                padding: EdgeInsets.only(top: 16.0),
                separatorBuilder: (context, index) => SizedBox(height: 16.0),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var noteInfo = snapshot.data!.docs[index].data() as Map<
                      String,
                      dynamic>;
                  String docID = snapshot.data!.docs[index].id;
                  String title = noteInfo['title'];
                  String description = noteInfo['description'];
                  String imageURL = noteInfo['newsImage'];
                  return Ink(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                    ),


                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      onTap: () =>
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>EditNewsScreen(
                                    currentTitle: title,
                                    currentDescription: description,
                                    currentImage: imageURL,
                                    documentId: docID,
                                   // currentNewsPosterUrl: newsPosterUrl,
                                  ),
                            ),
                          ),
                      title: Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          letterSpacing: 1,
                        ),
                      ),
                      subtitle: Text(
                        description,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          letterSpacing: 1,
                        ),
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
        ),
        );
  }
}