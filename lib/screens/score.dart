import 'package:flutter/material.dart';

class Score extends StatelessWidget {
  final score;

  const Score({Key? key, this.score}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Text(
      "$score",
      style: TextStyle(
          fontFamily: 'Botsmatic', fontSize: 40, backgroundColor: Colors.white),
    ));
  }
}
