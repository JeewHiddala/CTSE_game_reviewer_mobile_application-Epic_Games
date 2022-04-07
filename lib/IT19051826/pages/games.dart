// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors


import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game_reviewer_application/IT19051826/pages/show_game_details.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart';

import '../database/game_details_database.dart';
import '../styleguide/custom_form_field_game.dart';


class Game extends StatefulWidget {
  final FocusNode gameNameFocusNode;
  final FocusNode categoryFocusNode;
  final FocusNode developerFocusNode;
  final FocusNode priceFocusNode;
  final FocusNode rankFocusNode;
  final FocusNode noOfPlayersFocusNode;
  final FocusNode descriptionFocusNode;

  const Game({
    required this.gameNameFocusNode,
    required this.categoryFocusNode,
    required this.developerFocusNode,
    required this.priceFocusNode,
    required this.rankFocusNode,
    required this.noOfPlayersFocusNode,
    required this.descriptionFocusNode,
  });

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  final _addGameDetailsFormKey = GlobalKey<FormState>();

  bool _isProcessing = false;
  bool _isUploading = false;

  final TextEditingController _gameNameController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _developerController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _rankController = TextEditingController();
  final TextEditingController _noOfPlayersController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  XFile? _image;
  String getGameName = "";
  String getCategory = "";
  String getDeveloper = "";
  String getPrice = "";
  String getRank = "";
  String getNoOfPlayers = "";
  String getDescription = "";
  String getImagePath = "";

  Future getImage() async {
    final ImagePicker _picker = ImagePicker();

    final image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
      print('Image Path $_image');
    });
  }

  Future uploadPic(BuildContext context) async {
    String fileName = basename(_image!.path);
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child('test/$fileName');
    UploadTask uploadTask = ref.putFile(File(_image!.path));
    uploadTask.then((res) => res.ref.getDownloadURL());
    return 'test/$fileName';
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _addGameDetailsFormKey,
        child: Column(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  right: 8.0,
                  bottom: 24.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 24.0),
                    Center(
                      child: Text(
                        'Add Game Details',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22.0,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Divider(
                      height: 15,
                    ),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Align(
                                alignment: Alignment.center,
                                child: CircleAvatar(
                                  radius: 110,
                                  backgroundColor: Colors.white,
                                  child: ClipOval(
                                    child: SizedBox(
                                      width: 200.0,
                                      height: 200.0,
                                      child: (_image != null)
                                          ? Image.file((File(_image!.path)))
                                          : Image.asset(
                                              'assets/images/load.png',
                                              fit: BoxFit.fill,
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Center(
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.amberAccent),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                )),
                              ),
                              onPressed: () async {
                                setState(() {
                                  _isUploading = true;
                                });
                                getImage();
                              },
                              child: Text('Upload Image'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 25,
                    ),
                    Text(
                      'Game Name:',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        letterSpacing: 1,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Divider(
                      height: 5,
                    ),
                    CustomFormFieldGame(
                      initialValue: "",
                      isLabelEnabled: false,
                      controller: _gameNameController,
                      focusNode: widget.gameNameFocusNode,
                      keyboardType: TextInputType.text,
                      inputAction: TextInputAction.next,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter game';
                        }
                        // return null;
                        getGameName = value;
                      },
                      label: 'Game',
                      hint: 'Enter the Game Name',
                    ),
                    Divider(
                      height: 25,
                    ),
                    Text(
                      'Category:',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        letterSpacing: 1,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Divider(
                      height: 5,
                    ),
                    CustomFormFieldGame(
                      initialValue: "",
                      isLabelEnabled: false,
                      controller: _categoryController,
                      focusNode: widget.categoryFocusNode,
                      keyboardType: TextInputType.text,
                      inputAction: TextInputAction.next,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter category';
                        }
                        // return null;
                        getCategory = value;
                      },
                      label: 'Category',
                      hint: 'Enter the Category',
                    ),
                    Divider(
                      height: 25,
                    ),
                    Text(
                      'Developer:',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        letterSpacing: 1,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Divider(
                      height: 5,
                    ),
                    CustomFormFieldGame(
                      initialValue: "",
                      isLabelEnabled: false,
                      controller: _developerController,
                      focusNode: widget.developerFocusNode,
                      keyboardType: TextInputType.text,
                      inputAction: TextInputAction.next,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter developer ';
                        } else if (value.length <= 3) {
                          return 'Enter Developer name more than 3 characters';
                        }
                        getDeveloper = value;
                      },
                      label: 'Developer',
                      hint: 'Enter the Developer Details',
                    ),
                    Divider(
                      height: 25,
                    ),
                    Text(
                      'Price:',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        letterSpacing: 1,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Divider(
                      height: 5,
                    ),
                    CustomFormFieldGame(
                      initialValue: '',
                      isLabelEnabled: false,
                      controller: _priceController,
                      focusNode: widget.priceFocusNode,
                      keyboardType: TextInputType.number,
                      inputAction: TextInputAction.next,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter price ';
                        }

                        // return null;
                        getPrice = value;
                      },
                      label: 'Price',
                      hint: 'Enter the Price',
                    ),
                    Divider(
                      height: 25,
                    ),
                    Text(
                      'Rank:',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        letterSpacing: 1,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Divider(
                      height: 5,
                    ),
                    CustomFormFieldGame(
                      initialValue: '',
                      isLabelEnabled: false,
                      controller: _rankController,
                      focusNode: widget.rankFocusNode,
                      keyboardType: TextInputType.number,
                      inputAction: TextInputAction.next,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please rank the game ';
                        } else if (value.length < 0) {
                          return 'Enter a valid ranking';
                        }

                        // return null;
                        getRank = value;
                      },
                      label: 'Rank',
                      hint: 'Rank the game from 0-100',
                    ),
                    Divider(
                      height: 25,
                    ),
                    Text(
                      'No Of Players:',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        letterSpacing: 1,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Divider(
                      height: 5,
                    ),
                    CustomFormFieldGame(
                      initialValue: '',
                      isLabelEnabled: false,
                      controller: _noOfPlayersController,
                      focusNode: widget.noOfPlayersFocusNode,
                      keyboardType: TextInputType.number,
                      inputAction: TextInputAction.next,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter no of players ';
                        }

                        // return null;
                        getNoOfPlayers = value;
                      },
                      label: 'No Of Players',
                      hint: 'Enter the no of players',
                    ),
                    Divider(
                      height: 25,
                    ),
                    Text(
                      'Description:',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        letterSpacing: 1,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Divider(
                      height: 10,
                    ),
                    CustomFormFieldGame(
                      initialValue: "",
                      isLabelEnabled: false,
                      controller: _descriptionController,
                      focusNode: widget.descriptionFocusNode,
                      keyboardType: TextInputType.text,
                      inputAction: TextInputAction.next,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a description  ';
                        }
                        // return null;
                        getDescription = value;
                      },
                      label: 'Description',
                      hint: 'Enter the game description',
                    ),
                  ],
                )),
            Divider(
              height: 60,
            ),
            _isProcessing
                ? Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.orangeAccent),
                    ),
                  )
                : Container(
                    width: double.maxFinite,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.amberAccent),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                      ),
                      onPressed: () async {
                        widget.gameNameFocusNode.unfocus();
                        widget.categoryFocusNode.unfocus();
                        widget.developerFocusNode.unfocus();
                        widget.priceFocusNode.unfocus();
                        widget.rankFocusNode.unfocus();
                        widget.noOfPlayersFocusNode.unfocus();
                        widget.descriptionFocusNode.unfocus();

                        if (_addGameDetailsFormKey.currentState!.validate()) {
                          setState(() {
                            _isProcessing = true;
                          });

                          if (_isUploading) {
                            getImagePath = await uploadPic(context);
                          }
                          SnackBar(
                            content:
                                const Text('Game Details Added Successfully'),
                          );

                          await Game_Database.addGameDetails(
                            gameImage: getImagePath,
                            gameName: getGameName,
                            category: getCategory,
                            developer: getDeveloper,
                            price: getPrice,
                            rank: getRank,
                            noOfPlayers: getNoOfPlayers,
                            description: getDescription,
                          );

                          setState(() {
                            _isProcessing = false;
                            _isUploading = false;
                          });
                          final snackBar = SnackBar(
                            content: const Text('Game Details Added !'),
                            action: SnackBarAction(
                              label: 'Undo',
                              onPressed: () {},
                            ),
                          );

                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ShowDetails(),
                            ),
                          );
                          //Navigator.of(context).pop();
                        }
                      },
                      child: Padding(
                          padding: EdgeInsets.fromLTRB(60, 20, 60, 20),
                          child: Text('Submit',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                                letterSpacing: 2,
                              ))),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
