import 'package:flutter/material.dart';
import 'package:restaurantreviewrev2/DBHelper.dart';
import 'package:restaurantreviewrev2/Restaurant.dart';
import 'package:restaurantreviewrev2/Reviewer.dart';
import 'package:restaurantreviewrev2/Reviews.dart';
import 'mainScreen.dart';

class AddReviewScreen extends StatefulWidget {
  final MainScreenState mainScreen;
  AddReviewScreen(this.mainScreen);
  _AddReviewScreenState createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  DBHelper db = DBHelper();
  List<Reviewer> reviewers;
  List<String> rev, res;
  List<Restaurant> restaurant;
  String resValue, revValue, stars;
  final revi = TextEditingController();

  void getGroups() async {
    rev = List();
    res = List();
    restaurant = List();
    reviewers = List();

    reviewers = await db.getUserList();
    for (int i = 0; i < reviewers.length; i++) {
      rev.add(reviewers[i].getUsername());
    }
    restaurant = await db.getRestaurantList();
    for (int i = 0; i < restaurant.length; i++) {
      res.add(restaurant[i].getUsername());
    }

    setState(() {
      res=res;
      rev = rev;
    });
  }

  void addToDb() async{
    String review = revi.text;

    Reviews x = Reviews(resValue, revValue, review, int.parse(stars));
    await db.addReview(x);
  }

  @override
  Widget build(BuildContext context) {
    if(res == null){
      getGroups();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Review"),
      ),
      body: Column(children: [
        DropdownButton<String>(
            value: revValue,
            items: rev.map((String val) {
              return new DropdownMenuItem<String>(
                value: val,
                child: new Text(val),
              );
            }).toList(),
            onChanged: (newVal) {
              this.setState(() {
                revValue=newVal;
              });
            }),
        DropdownButton<String>(
            value: resValue,
            items: res.map((String val) {
              return new DropdownMenuItem<String>(
                value: val,
                child: new Text(val),
              );
            }).toList(),
            onChanged: (newVal) {
              this.setState(() {
                resValue = newVal;
              });
            }),
        DropdownButton<String>(
          value: stars,
          items: <String>['1', '2', '3', '4', '5'].map((String value) {
            return  DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              stars = value;
            });
          },
        ),


        TextField(
          controller: revi,
          decoration: InputDecoration(
              border: InputBorder.none, hintText: 'Enter Review here'),
        ),

        Align(
            alignment: Alignment.bottomCenter,
            child: Column(children: [
              RaisedButton(
                onPressed: () {
                  addToDb();
                  widget.mainScreen.refresh();
                  Navigator.pop(context);
                },
                child: const Text('Save', style: TextStyle(fontSize: 20)),
                color: Colors.blue,
                textColor: Colors.white,
                elevation: 5,
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.pop(context);
              },
                child: const Text('Back', style: TextStyle(fontSize: 20)),
                color: Colors.blue,
                textColor: Colors.white,
                elevation: 5,
              ),
            ]))
      ]),
    );
  }
}
