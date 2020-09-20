import 'package:flutter/material.dart';
import 'package:restaurantreviewrev2/DBHelper.dart';
import 'package:restaurantreviewrev2/Restaurant.dart';
import 'package:restaurantreviewrev2/ReviewScreen.dart';
import 'package:restaurantreviewrev2/Reviewer.dart';
import 'dart:async';

import 'package:restaurantreviewrev2/Reviews.dart';

class Pair extends StatefulWidget {
  PairState createState() => PairState();

}

class PairState extends State<Pair> {
  final DBHelper db = DBHelper();
  List<Reviews> reviews;
  List<String> stringer;

  void load() async {
    reviews = List();
    stringer = List();

    reviews = await db.getReviewsList();
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    if (reviews == null) {
      load();
      setState(() {});
    }
    return Container(
        height: MediaQuery.of(context).size.height / 4,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
            itemCount: reviews.length,
            itemBuilder: (BuildContext contect, int index) {
              final review = reviews[index];
              return GestureDetector(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    color: Colors.red[300],
                    child: Center(
                      child: Text(reviews[index].getReviewer() +
                          "---" +
                          reviews[index].getRestaurant()),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => ReviewScreen(
                                  review: review,
                                )));
                  });
            }));
  }
}
