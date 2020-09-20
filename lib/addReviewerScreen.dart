import 'package:flutter/material.dart';
import 'package:restaurantreviewrev2/DBHelper.dart';
import 'package:restaurantreviewrev2/Reviewer.dart';

class ReviewerScreen extends StatefulWidget {
  _ReviewerScreenState createState() => _ReviewerScreenState();
}

class _ReviewerScreenState extends State<ReviewerScreen> {
  final DBHelper db = DBHelper();
  final name = TextEditingController();

  void addReviewer() async{
    String a = name.text;
    Reviewer rev = Reviewer(a);
    await db.addUser(rev);
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Reviewer"),
      ),
      body: Column(children: [
        TextField(
          controller: name,
          decoration: InputDecoration(
              border: InputBorder.none, hintText: 'Enter reviewer name'),
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
