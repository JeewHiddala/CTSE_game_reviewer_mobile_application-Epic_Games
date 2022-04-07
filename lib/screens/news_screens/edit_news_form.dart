import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:game_reviewer_application/custom_form_field_news.dart';
import '../../validators/news_database.dart';
import '../../validators/validators.dart';
import 'newsList.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class EditNewsForm extends StatefulWidget {
  final String documentId;
  final String currentTitle;
  final String currentDescription;
  final String currentImage;

  final FocusNode titleFocusNode;
  final FocusNode descriptionFocusNode;

  const EditNewsForm({
    required this.documentId,
    required this.currentTitle,
    required this.currentDescription,
    required this.currentImage,
    required this.titleFocusNode,
    required this.descriptionFocusNode,
  });

  @override
  _EditNewsFormState createState() => _EditNewsFormState();
}

class _EditNewsFormState extends State<EditNewsForm> {
  final _addItemFormKey = GlobalKey<FormState>();
  XFile? _image;

  bool _isuploading = false;
  bool _isProcessing = false;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String updateTitle = "";
  String updateDescription = "";


  @override
  Widget build(BuildContext context) {
    String updateImagePath = widget.currentImage;
    print("asa"+widget.currentImage);
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
      //StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(fileName);
      await FirebaseStorage.instance
      .ref('news_images/$fileName')
          .putFile(File(_image!.path));
      // StorageTaskSnapshot taskSnapshot=await uploadTask.onComplete;
      updateImagePath = fileName;
      setState(() {
        print("News image uploaded");
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text('News image Uploaded')));
      });
    }

    Future<String> downloadURL(String imageName) async {
      String downloadURL = await FirebaseStorage.instance
          .ref('news_images/$imageName')
          .getDownloadURL();

      return downloadURL;
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Builder(
        builder: (context) => SingleChildScrollView(
          child: Form(
            key: _addItemFormKey,
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.only(
                      left: 8.0,
                      right: 8.0,
                      bottom: 24.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: 10.0, top: 25.0, right: 80.0, bottom: 10.0),
                          child: Text(
                            'Edit News Details',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 30,
                            ),
                          ),
                        ),
                        SizedBox(height: 24.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            FutureBuilder(
                                future: downloadURL(widget.currentImage),
                                builder: (BuildContext context,
                                    AsyncSnapshot<String> snapshot) {
                                  if (snapshot.connectionState ==
                                          ConnectionState.done &&
                                      snapshot.hasData) {
                                    return Align(
                                      alignment: Alignment.center,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8.0),
                                        child: new SizedBox(
                                          width: 200.0,
                                          height: 180.0,
                                          child: (_image != null)
                                              ? Image.file(
                                                  File(_image!.path),
                                                  fit: BoxFit.fill,
                                                )
                                              : Image.network(
                                                  snapshot.data!,
                                                  fit: BoxFit.fill,
                                                ),
                                        ),
                                      ),
                                    );
                                  }
                                  else {
                                    return const CircularProgressIndicator();
                                  }
                                }
                                ),
                            Padding(
                              padding: EdgeInsets.only(top: 60.0),
                              child: IconButton(
                                icon: Icon(
                                  FontAwesomeIcons.camera,
                                  size: 30.0,
                                  color: Colors.white,
                                ),
                                onPressed: () async {
                                  setState(() {
                                    _isuploading = true;
                                  });
                                  getImage();
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          'Title',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22.0,
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        CustomFormField(
                          initialValue: widget.currentTitle,
                          isLabelEnabled: false,
                          controller: _titleController,
                          focusNode: widget.titleFocusNode,
                          keyboardType: TextInputType.text,
                          inputAction: TextInputAction.next,
                          validator: (value) {
                            Validator.validateField(value: value);
                            updateTitle = value;
                          },
                          label: 'Title',
                          hint: 'Write your title',
                        ),
                        SizedBox(height: 24.0),
                        Text(
                          'Description',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22.0,
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        CustomFormField(
                          initialValue: widget.currentDescription,
                          maxLines: 5,
                          isLabelEnabled: false,
                          controller: _descriptionController,
                          focusNode: widget.descriptionFocusNode,
                          keyboardType: TextInputType.text,
                          inputAction: TextInputAction.next,
                          validator: (value) {
                            Validator.validateField(value: value);
                            updateDescription = value;
                          },
                          label: 'Description',
                          hint: 'Write your description',
                        ),
                        SizedBox(height: 24.0),
                        // RaisedButton(
                        //   color: Color(0xff476cfb),
                        //   onPressed: () {},
                        // ),
                      ],
                    )),
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
                                MaterialStateProperty.all(Colors.amber),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                          ),
                          onPressed: () async {
                            widget.titleFocusNode.unfocus();
                            widget.descriptionFocusNode.unfocus();

                            if (_addItemFormKey.currentState!.validate()) {
                              setState(() {
                                _isProcessing = true;
                              });
                              if (_isuploading) {
                                await uploadPic(context);
                              }
                              await Database.updateNews(
                                  docId: widget.documentId,
                                  title: updateTitle,
                                  description: updateDescription,
                                  newsImage: updateImagePath);

                              setState(() {
                                _isProcessing = false;
                                _isuploading = false;
                              });
                              Fluttertoast.showToast(
                                //Toast Message
                                msg: "News Details Updated Successfully",
                                fontSize: 16,
                                backgroundColor: Colors.white,
                                textColor: Colors.black,
                              );
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NewsList(),
                                ),
                              );
                            }
                          },
                          child: Padding(
                              padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                              child: Text('Update News Details',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    letterSpacing: 1,
                                  ))),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
