import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Pipe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 85,
      height: 500,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/pipe1.png"),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
