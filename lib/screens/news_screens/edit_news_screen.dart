import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../validators/news_database.dart';
import 'edit_news_form.dart';


class EditNewsScreen extends StatefulWidget {
  final String currentTitle;
  final String currentDescription;
  final String currentImage;
  final String documentId;

  EditNewsScreen({
    required this.currentTitle,
    required this.currentDescription,
    required this.currentImage,
    required this.documentId,
  });

  @override
  _EditNewsScreenState createState() => _EditNewsScreenState();
}

class _EditNewsScreenState extends State<EditNewsScreen> {
  final FocusNode _titleFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();

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
                Text('Would you like delete news details permanently?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              // onPressed: () => Navigator.pop(context, 'OK'),
              onPressed: () async {
                setState(() {
                  _isDeleting = true;
                });

                await Database.deleteNews(
                  docId: widget.documentId,
                );

                setState(() {
                  _isDeleting = false;
                });

                Fluttertoast.showToast(       //Toast Message
                  msg: "News Details Deleted Successfully",
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
          // backgroundColor: Colors.amber,
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _titleFocusNode.unfocus();
        _descriptionFocusNode.unfocus();
      },
      child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
              // Here we take the value from the MyHomePage object that was created by
              // the App.build method, and use it to set our appbar title.
              title: const Padding(
                padding: EdgeInsets.only(left: 50.0, top: 5.0),
                child: Text(
                  'Epic Game Reviewer',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 25,
                    color: Colors.black,
                  ),
                ),
              ),
            elevation: 0,
            backgroundColor: Colors.amber,
            actions: [
              _isDeleting
                  ? Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, right: 16.0,),
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.red,
                  ),
                  strokeWidth: 3,
                ),
              ) : IconButton(
                  onPressed: () async {
                    await _showMyDialog(context);
                  },
                  icon: Icon(Icons.delete_forever, color: Colors.black, size: 32,)
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
              child: EditNewsForm(
                documentId: widget.documentId,
                titleFocusNode: _titleFocusNode,
                descriptionFocusNode: _descriptionFocusNode,
                currentTitle: widget.currentTitle,
                currentDescription: widget.currentDescription,
                currentImage: widget.currentImage,

              ),
            ),
          )
      ),
    );
  }
}
