import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PipeDown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 85,
      height: 500,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/pipe_down.png"),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
