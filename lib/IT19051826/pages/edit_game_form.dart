import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

import '../database/game_details_database.dart';
import '../styleguide/custom_form_field_game.dart';

class EditGameDetailsForm extends StatefulWidget {
  final String documentId;
  final String currentGameName;
  final String currentCategory;
  final String currentDeveloper;
  final String currentPrice;
  final String currentRank;
  final String currentNoOfPlayers;
  final String currentDescription;


  final FocusNode gameNameFocusNode;
  final FocusNode categoryFocusNode;
  final FocusNode developerFocusNode;
  final FocusNode priceFocusNode;
  final FocusNode rankFocusNode;
  final FocusNode noOfPlayersFocusNode;
  final FocusNode descriptionFocusNode;

  const EditGameDetailsForm({
    required this.documentId,
    required this.currentGameName,
    required this.currentCategory,
    required this.currentDeveloper,
    required this.currentPrice,
    required this.currentRank,
    required this.currentNoOfPlayers,
    required this.currentDescription,
    required this.gameNameFocusNode,
    required this.categoryFocusNode,
    required this.developerFocusNode,
    required this.priceFocusNode,
    required this.rankFocusNode,
    required this.noOfPlayersFocusNode,
    required this.descriptionFocusNode,
  });

  @override
  _EditGameDetailsFormState createState() => _EditGameDetailsFormState();
}

class _EditGameDetailsFormState extends State<EditGameDetailsForm> {
  final _editGameDetailsFormKey = GlobalKey<FormState>();

  bool _isProcessing = false;

  final TextEditingController _gameNameController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _developerController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _rankController = TextEditingController();
  final TextEditingController _noOfPlayersController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  XFile? _image;
  String updateGameName = "";
  String updateCategory = "";
  String updateDeveloper = "";
  String updatePrice = "";
  String updateRank = "";
  String updateNoOfPlayers = "";
  String updateDescription = "";
  String updateImagePath = '';

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
                key: _editGameDetailsFormKey,
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
                                'Game Details',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22.0,
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.normal,
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
                                                    ? //snapshot.data
                                                     Image.file(
                                                    (File(_image!.path)))
                                              : Image.asset(
                                              'assets/images/fortnite.jpg',
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
                                        backgroundColor:
                                        MaterialStateProperty.all(
                                            Colors.amberAccent),
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                              borderRadius: BorderRadius
                                                  .circular(20),
                                            )),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          //_isUploading = true;
                                        });
                                        getImage();
                                      },
                                      child: Text('Upload File'),
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
                              initialValue: widget.currentGameName,
                              isLabelEnabled: false,
                              focusNode: widget.gameNameFocusNode,
                              keyboardType: TextInputType.text,
                              controller: _gameNameController,
                              inputAction: TextInputAction.next,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter game';
                                }
                                // return null;
                                updateGameName = value;
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
                              initialValue: widget.currentCategory,
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
                                updateCategory = value;
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
                              initialValue: widget.currentDeveloper,
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
                                updateDeveloper = value;
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
                              initialValue: widget.currentPrice,
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
                                updatePrice = value;
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
                              initialValue: widget.currentRank,
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
                                updateRank = value;
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
                              initialValue: widget.currentNoOfPlayers,
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
                                updateNoOfPlayers = value;
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
                              height: 5,
                            ),
                            CustomFormFieldGame(
                              initialValue: widget.currentDescription,
                              isLabelEnabled: false,
                              controller: _descriptionController,
                              focusNode: widget.descriptionFocusNode,
                              keyboardType: TextInputType.text,
                              inputAction: TextInputAction.next,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter a description ';
                                }
                                // return null;
                                updateDescription = value;
                              },
                              label: 'Description',
                              hint: 'Enter the description',
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
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.orangeAccent),
                      ),
                    )
                        : Container(
                      width: double.maxFinite,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all(Colors.amberAccent),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
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

                          if (_editGameDetailsFormKey.currentState!
                              .validate()) {
                            setState(() {
                              _isProcessing = true;

                              SnackBar(
                                content: const Text('Game Details Updated'),
                              );
                            });

                            await Game_Database.updateGameDetails(
                                docId: widget.documentId,
                                gameName: updateGameName,
                                category: updateCategory,
                                developer: updateDeveloper,
                                price: updatePrice,
                                rank: updateRank,
                                noOfPlayers: updateNoOfPlayers,
                                description: updateDescription);

                            setState(() {
                              _isProcessing = false;
                            });

                            final snackBar = SnackBar(
                              content: const Text('Game Details Updated!'),
                              action: SnackBarAction(
                                label: 'Undo',
                                onPressed: () {
                                  // Some code to undo the change.
                                },
                              ),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            Navigator.of(context).pop();
                          }
                        },
                        child: Padding(
                            padding:
                            EdgeInsets.only(top: 16.0, bottom: 16.0),
                            child: Text('Update Data',
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





