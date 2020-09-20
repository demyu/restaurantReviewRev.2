import 'package:flutter/material.dart';
import 'package:restaurantreviewrev2/DBHelper.dart';
import 'package:restaurantreviewrev2/Reviewer.dart';

import 'Restaurant.dart';

class RestaurantScreen extends StatefulWidget {
  _RestaurantScreenState createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  final DBHelper db = DBHelper();
  final name = TextEditingController();

  void addReviewer(){
    String a = name.text;
    Restaurant rev = Restaurant(a);
    db.addRestaurant(rev);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Restaurant"),
      ),
      body: Column(children: [
        TextField(
          controller: name,
          decoration: InputDecoration(
              border: InputBorder.none, hintText: 'Enter restaurant name'),
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: Column(children: [
              RaisedButton(
                onPressed: () {
                  addReviewer();
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
