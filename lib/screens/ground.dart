import 'package:flutter/material.dart';

class Ground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360,
      height: 150,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/ground.png"),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
