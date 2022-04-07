import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:game_reviewer_application/db/database_review.dart';
import 'package:game_reviewer_application/pages/review_list.dart';
import '../db/database_review.dart';

//Referred Coding Cafe To do list app in flutter & SQLite 7 th video for developing insertion page.
//Referred Flutter rating bar readme in the flutter pub.dev site to create rating bar
class AddReview extends StatefulWidget {
  static const String routeName = '/addReview';
  const AddReview({ Key? key }) : super(key: key);
  @override
  _AddReviewState createState() => _AddReviewState();
}

class _AddReviewState extends State<AddReview> {
  final _reviewFormKey = GlobalKey<FormState>();

  var title = " ";
  var userName = " ";
  var description = " ";
  var rating = 0.0;

  @override
  void dispose() {
    titleController.dispose();
    userNameController.dispose();
    ratingController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  final titleController = TextEditingController();
  final ratingController = TextEditingController();
  final userNameController = TextEditingController();
  final descriptionController = TextEditingController();

  addReview() async{
      await ReviewDatabase.addReview(title: title, rating: rating, userName: userName, description: description );
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.blueGrey,
        content: Text(
          'Review added successfully',
          style: TextStyle(
              fontSize: 20.0
          ),
        ),
      ));
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ReviewList()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(left: 50.0, top: 5.0),
          child: Text(
            'Epic Game Reviewer',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 25,
            ),
          ),
        ),
      ),
      body: Form(
        key: _reviewFormKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child: ListView(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Text(
                  'Add Review',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 30,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20.0, top: 20.0),
                child:
                Text(
                  'Title',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20.0, top: 10.0),
                height: 40,
                child: TextFormField(
                  autofocus: false,
                  cursorHeight: 20.0,
                  cursorColor: Colors.black,
                  textAlignVertical: TextAlignVertical.center,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    errorStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                  controller: titleController,
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20.0, top: 20.0),
                child:
                Text(
                  'User Name',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20.0, top: 10.0),
                height: 40,
                child: TextFormField(
                  autofocus: false,
                  cursorHeight: 20.0,
                  cursorColor: Colors.black,
                  textAlignVertical: TextAlignVertical.center,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    errorStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                  controller: userNameController,
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return 'Please enter user name';
                    }
                    return null;
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20.0, top: 20.0),
                child:
                Text(
                  'Rating',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            Container(
              margin: const EdgeInsets.only(left: 20.0, top: 10.0),
              decoration: const BoxDecoration(
                  color: Colors.white
              ),
              child: RatingBar.builder(
                initialRating: 1,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,

                ),
                onRatingUpdate: (rating) {
                  ratingController.text = rating.toStringAsFixed(0);
                },
              ),
            ),
              const Padding(
                padding: EdgeInsets.only(left: 20.0, top: 20.0),
                child:
                Text(
                  'Description',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20.0, top: 10.0),
                height: 100,
                child: TextFormField(
                  autofocus: false,
                  cursorHeight: 20.0,
                  cursorColor: Colors.black,
                  textAlignVertical: TextAlignVertical.center,
                  maxLines: null,
                  expands: true,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    errorStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                  controller: descriptionController,
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: (){
                      if(_reviewFormKey.currentState!.validate()){
                        setState(() {
                          title = titleController.text;
                          userName = userNameController.text;
                          rating = double.parse(ratingController.text) ;
                          description = descriptionController.text;
                        });
                        addReview();
                      }
                    },
                    child: const Text(
                      'Save',
                      style: TextStyle(
                          fontSize: 18.0
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}