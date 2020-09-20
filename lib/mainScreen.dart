import 'package:flutter/material.dart';
import 'package:restaurantreviewrev2/addReviewScreen.dart';

import 'DBHelper.dart';
import 'ReviewScreen.dart';
import 'Reviews.dart';
import 'Widgets/Pair.dart';
import 'addRestaurantScreen.dart';
import 'addReviewerScreen.dart';

class MainScreen extends StatefulWidget {
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  final DBHelper db = DBHelper();
  List<Reviews> reviews;
  List<String> stringer;

  void load() async {
    reviews = List();
    stringer = List();

    reviews = await db.getReviewsList();
    setState(() {});
  }

  void refresh() {
    load();
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    if (reviews == null) {
      load();
      setState(() {});
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Restaurant Review"),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
              width: MediaQuery.of(context).size.width,
              height: 300.00,
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: ExactAssetImage('assets/logo/logo.jpg'),
                  fit: BoxFit.fitHeight,
                ),
              )),
          SizedBox(height: 50),
          Container(
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
                  })),
          RaisedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => RestaurantScreen()));
            },
            child: Text("Add Restaurant"),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => ReviewerScreen()));
            },
            child: Text("Add Reviewer"),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => AddReviewScreen(this)));
            },
            child: Text("Add Review"),
          ),
        ]),
      ),
    );
  }
}
