import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:game_reviewer_application/db/database_review.dart';



class EditReview extends StatefulWidget {

  final String title;
  final String userName;
  final String description;
  final double rating;
  final String docId;

  const EditReview({Key? key,
    required this.title,
    required this.userName,
    required this.description,
    required this.rating,
    required this.docId,
  }) : super(key: key);
  @override
  _EditReviewState createState() => _EditReviewState();
}

class _EditReviewState extends State<EditReview> {
  final _updateReviewFormKey = GlobalKey<FormState>();

  var title = " ";
  var userName = " ";
  var description = " ";
  var rating = 0.0;
  var docId;

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

  updateReview() async{
    await ReviewDatabase.updateReview(title: title, rating: rating, userName: userName, description: description, docId: docId);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      backgroundColor: Colors.blueGrey,
      content: Text(
        'Updated successfully.',
        style: TextStyle(
            fontSize: 20.0
        ),
      ),
    ));
    Navigator.of(context).pop();
    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ReviewList()));
  }

  @override
  Widget build(BuildContext context) {
    docId = widget.docId;
    titleController.text = widget.title;
    descriptionController.text = widget.description;
    userNameController.text = widget.userName;
    ratingController.text = widget.rating.toStringAsFixed(0);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(left: 50.0, top: 5.0),
          child: Text(
            'Game Reviewer',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 25,
            ),
          ),
        ),
      ),
        body: Form(
          key: _updateReviewFormKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            child: ListView(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Update Review',
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
                    initialRating: widget.rating ,
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
                        if(_updateReviewFormKey.currentState!.validate()){
                          setState(() {
                            title = titleController.text;
                            userName = userNameController.text;
                            rating = double.parse(ratingController.text);
                            description = descriptionController.text;
                          });
                          updateReview();
                        }
                      },
                      child: const Text(
                        'Update',
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