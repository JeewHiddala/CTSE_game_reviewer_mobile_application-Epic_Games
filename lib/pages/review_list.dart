import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:game_reviewer_application/db/database_review.dart';
import 'package:game_reviewer_application/pages/add_review.dart';
import 'package:game_reviewer_application/pages/update_review.dart';

//Referred Coding Cafe To do list app in flutter & SQLite 6 th video for developing list view page.
//Referred Flutter rating bar readme in the flutter pub.dev site to create rating bar indicator
//Referred 2-ways-to-convert-datetime-to-time-ago-in-flutter in kindacode.com for displaying time elapsed of review creation
class ReviewList extends StatefulWidget {
  static const String routeName = '/review';

  ReviewList({Key? key}) : super(key: key);

  @override
  State<ReviewList> createState() => _ReviewListState();
}

class _ReviewListState extends State<ReviewList> {
  bool _isDeleting = false;

  double overallRating = 0;
  int count = 0;

  Future<void> _showMyDialog(BuildContext context, String docId) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 4,
          // shape: ShapeBorder(),
          backgroundColor: Colors.black,
          title: const Text(
            'Delete ?',
            style: TextStyle(fontSize: 25.0, color: Colors.white),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text(
                  'Would you like to delete review?',
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'OK',
                style: TextStyle(fontSize: 18.0),
              ),
              onPressed: () async {
                setState(() {
                  _isDeleting = true;
                });

                await ReviewDatabase.deleteReview(
                  docId: docId,
                );

                setState(() {
                  _isDeleting = false;
                });

                // Navigator.pop(context, 'OK');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReviewList(),
                  ),
                );
              },
            ),
            TextButton(
              child: const Text(
                'Cancel',
                style: TextStyle(fontSize: 18.0),
              ),
              onPressed: () => Navigator.pop(context, 'Cancel'),
            ),
          ],
        );
      },
    );
  }

  String getTimePassed(DateTime timestamp) {
    Duration passedTime = DateTime.now().difference(timestamp);

    if (passedTime.inDays >= 1) {
      return '${passedTime.inDays} day(s) ago';
    } else if (passedTime.inHours >= 1) {
      return '${passedTime.inHours} hour(s) ago';
    } else if (passedTime.inMinutes >= 1) {
      return '${passedTime.inMinutes} minute(s) ago';
    } else if (passedTime.inSeconds >= 1) {
      return '${passedTime.inSeconds} second(s) ago';
    } else {
      return 'Just now';
    }
  }

  void setOverallRating() {
    Stream<QuerySnapshot> snapshot = ReviewDatabase.readReviewInfo();
  }

  @override
  Widget build(BuildContext context) {
    setOverallRating();
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddReview(),
            ),
          );
        },
        backgroundColor: Colors.amber,
        child: const Icon(
          Icons.add,
          color: Colors.black,
          size: 32,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Container(
              color: Colors.black,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: Text(
                      "Overall Rating",
                      maxLines: 1,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 24.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  StreamBuilder<QuerySnapshot>(
                      stream: ReviewDatabase.readReviewInfo(),
                      builder: (context, snapshot) {
                        count = snapshot.data?.docs.length??0;
                        if (snapshot.hasError) {
                          return const Text('Something went wrong');
                        } else if (count != 0) {
                          var result = 0.0;
                          if(snapshot.hasData) {
                            result = snapshot.data!.docs
                                .map((element) => element['rating'])
                                .reduce((a, b) => a + b) /
                                snapshot.data!.docs.length;
                          }
                          print(snapshot);
                          overallRating = result;

                          return Expanded(
                            flex: 2,
                            child: Container(
                              color: Colors.white,
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20.0, top: 10.0, right: 20.0),
                                        child: Text(
                                          overallRating.toStringAsFixed(1),
                                          maxLines: 1,
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 55.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.amber,
                                            letterSpacing: 1,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(children: [
                                    Container(
                                      margin: const EdgeInsets.only(
                                          left: 20.0, top: 10.0),
                                      child: RatingBarIndicator(
                                        rating: overallRating,
                                        direction: Axis.horizontal,
                                        itemCount: 5,
                                        itemPadding: const EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        itemBuilder: (context, _) => const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                                      child: Text(
                                        "From $count review(s)",
                                        maxLines: 1,
                                        textAlign: TextAlign.start,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.black,
                                          letterSpacing: 1,
                                        ),
                                      ),
                                    ),
                                  ]),
                                ],
                              ),
                            ),
                          );
                        }
                        else if(snapshot.connectionState == ConnectionState.waiting || !snapshot.hasData){
                          return const Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.orangeAccent),
                            ),
                          );
                        }
                        return const Center(
                            child: Text(
                                'No reviews added yet',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.white,
                              ),
                            )
                        );
                      }),
                  const Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text(
                      "User Reviews",
                      maxLines: 1,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 24.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: Container(
              child: StreamBuilder<QuerySnapshot>(
                  stream: ReviewDatabase.readReviewInfo(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Something went wrong');
                    } else if (snapshot.hasData || snapshot.data != null) {
                      return ListView.separated(
                        padding: const EdgeInsets.only(top: 16.0),
                        shrinkWrap: true,

                        separatorBuilder: (context, index) =>
                        const SizedBox(height: 16.0),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          var review = snapshot.data!.docs[index].data()
                          as Map<String, dynamic>;
                          String docId = snapshot.data!.docs[index].id;
                          String title = review['title'];
                          String userName = review['userName'];
                          String description = review['description'];
                          double rating =
                          double.parse(review['rating'].toString());
                          Timestamp timestamp = review['timestamp'];
                          DateTime date = DateTime.fromMillisecondsSinceEpoch(
                              timestamp.millisecondsSinceEpoch);
                          String timePassed = getTimePassed(date);
                          return Ink(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: ListView(
                              shrinkWrap: true,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, top: 10.0, right: 20.0),
                                  child: Text(
                                    title,
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, top: 5.0, right: 20.0),
                                  child: Text(
                                    timePassed,
                                    maxLines: 1,
                                    textAlign: TextAlign.end,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.black,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 20.0, top: 10.0),
                                  child: RatingBarIndicator(
                                    rating: rating,
                                    direction: Axis.horizontal,
                                    itemCount: 5,
                                    itemPadding: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    itemBuilder: (context, _) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20.0, top: 5.0, right: 20.0),
                                      child: SizedBox(
                                        width: 350,
                                        child: Text(
                                          description,
                                          maxLines: null,
                                          overflow: TextOverflow.clip,
                                          style: const TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.black,
                                            letterSpacing: 1,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit),
                                      alignment: Alignment.topRight,
                                      padding: const EdgeInsets.all(8),
                                      iconSize: 40,
                                      color: Colors.black,
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) => EditReview(
                                                  title: title,
                                                  userName: userName,
                                                  description: description,
                                                  rating: rating,
                                                  docId: docId)),
                                        );
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete),
                                      alignment: Alignment.topRight,
                                      padding: const EdgeInsets.all(8),
                                      iconSize: 40,
                                      color: Colors.black,
                                      onPressed: () async {
                                        await _showMyDialog(context, docId);
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                    else if(snapshot.connectionState == ConnectionState.waiting || !snapshot.hasData){
                        return const Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.orangeAccent),
                          ),
                        );
                    }
                    return const Center(
                      child: Text(
                        'No reviews added yet',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                      )
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
