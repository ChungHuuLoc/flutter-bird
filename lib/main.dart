import 'package:flutter/material.dart';
import './screens/game.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Game(),
        theme: ThemeData(
          fontFamily: 'Botsmatic',
          textTheme: const TextTheme(
            headline3: TextStyle(
                fontSize: 50.0,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.normal),
          ),
        ));
  }
}
