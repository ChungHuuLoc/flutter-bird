import 'package:flutter/material.dart';

class Bird extends StatefulWidget {
  @override
  _BirdState createState() => _BirdState();
}

class _BirdState extends State<Bird> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 75,
      height: 45,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/yellowbird-midflap.png"),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
