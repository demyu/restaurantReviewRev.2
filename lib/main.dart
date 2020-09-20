import 'package:flutter/material.dart';
import 'package:restaurantreviewrev2/mainScreen.dart';

void main() {
  runApp(MyHomePage());
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "Restaurant Review",
      home: MainScreen()
    );
  }

}
