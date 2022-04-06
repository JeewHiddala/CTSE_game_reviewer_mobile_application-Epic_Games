import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:epic_games_app/custom_form_field_news.dart';
import 'package:epic_games_app/news_screens/newsList.dart';
import 'package:epic_games_app/validators/news_database.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class NewsDetailsForm extends StatefulWidget {
  final FocusNode titleFocusNode;
  final FocusNode descriptionFocusNode;

  const NewsDetailsForm({
    required this.titleFocusNode,
    required this.descriptionFocusNode,
  });

  @override
  _NewsDetailsFormState createState() => _NewsDetailsFormState();
}

class _NewsDetailsFormState extends State<NewsDetailsForm> {
  final _newsDetailsFormKey = GlobalKey<FormState>();
  XFile? _image;

  bool _isuploading = false;
  bool _isProcessing = false;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String getTitle = "";
  String getDescription = "";
  String getImagePath = "";

  @override
  Widget build(BuildContext context) {
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
      await FirebaseStorage.instance.ref('news_images/$fileName').child(fileName).putFile(
          File(_image!.path));
      getImagePath = fileName;
      // StorageTaskSnapshot taskSnapshot=await uploadTask.onComplete;
      setState(() {
        print("News image uploaded");
        Scaffold.of(context).showSnackBar(
            SnackBar(content: Text('News image Uploaded')));
      });
    }
    return Scaffold(
        backgroundColor: Colors.black,
        body: Builder(
        builder: (context) =>  SingleChildScrollView(
      child: Form(
        key: _newsDetailsFormKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12.0,right: 12.0,bottom: 24.0,),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10.0, top: 25.0, right: 80.0,bottom: 10.0),
                    child: Text(
                      'Add New News',
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
                      Align(
                        alignment: Alignment.center,
                        child: CircleAvatar(
                          radius: 10,
                          backgroundColor: Color(0xff476cfb),
                          child: ClipRRect(
                            child: new SizedBox(
                              width: 180.0,
                              height: 180.0,
                              child: (_image!=null)?Image.file(
                                File(_image!.path),
                                // width: 408,
                                // height: 250,
                                fit: BoxFit.fill,
                              ):Image.network(
                                "https://images.unsplash.com/photo-1502164980785-f8aa41d53611?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
                                fit: BoxFit.fill,
                                width: 308,
                                height: 550,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 60.0),
                        child: IconButton(
                          icon: Icon(
                            FontAwesomeIcons.camera,
                            size: 30.0,
                            color:Colors.white,
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
                    initialValue: "",
                    isLabelEnabled:false,
                    controller: _titleController,
                    focusNode:widget.titleFocusNode,
                    keyboardType:TextInputType.text,
                    inputAction:TextInputAction.next,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter the title';
                      }
                      // return null;
                      getTitle = value;
                    },
                    label: 'Title',
                    hint: 'Enter  a Title',
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
                    initialValue: "",
                    maxLines: 5,
                    isLabelEnabled:false,
                    controller: _descriptionController,
                    focusNode:widget.descriptionFocusNode,
                    keyboardType:TextInputType.text,
                    inputAction:TextInputAction.next,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter description';
                      }
                      // return null;
                      getDescription = value;
                    },
                    label: 'Description',
                    hint: 'Enter your Description',
                  ),
                  SizedBox(height: 24.0),
                  // RaisedButton(
                  //   color: Color(0xff476cfb),
                  //   onPressed: () {
                  //     uploadPic(context);
                  //   },
                  // ),
                ],
              ),
            ),
            _isProcessing
                ?Padding(
              padding: const EdgeInsets.all(16.0),
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.orangeAccent),
              ),
            ) : Container(
              width: double.maxFinite,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.amber),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ),
                onPressed:() async{
                  widget.titleFocusNode.unfocus();
                  widget.descriptionFocusNode.unfocus();
                  if(_newsDetailsFormKey.currentState!.validate()){
                    setState(() {
                      _isProcessing = true;
                    });
                    if (_isuploading) {
                       await uploadPic(context);
                    }
                    await Database.addNews(title: getTitle, description: getDescription, newsImage: getImagePath);
                    setState(() {
                      _isProcessing = false;
                      _isuploading = false;
                    });

                    Fluttertoast.showToast(       //Toast Message
                      msg: "News Details Added Successfully",
                      fontSize:16,
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
                  padding: EdgeInsets.only(top: 16.0,bottom: 16.0),
                  child: Text(
                    'Add News',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      letterSpacing: 1,
                    ),
                  ),
                ),
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