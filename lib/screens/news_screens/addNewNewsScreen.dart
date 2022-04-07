import 'package:flutter/material.dart';

import 'addNewNewsForm.dart';


class NewsScreen extends StatelessWidget {
  final FocusNode _titleFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        _titleFocusNode.unfocus();
        _descriptionFocusNode.unfocus();
      },
      child: Scaffold(
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
                  color: Colors.black,
                  fontSize: 25,
                ),
              ),
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0,right: 16.0,bottom: 20,),
              child:NewsDetailsForm (
                titleFocusNode: _titleFocusNode,
                descriptionFocusNode: _descriptionFocusNode,
              ),
            ),
          ),
          ),
    );
  }
}