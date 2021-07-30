import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:new_app/screens/bird.dart';
import 'package:new_app/screens/blinking.dart';
import 'package:new_app/screens/game_over.dart';
import 'package:new_app/screens/ground.dart';
import 'package:new_app/screens/pipe.dart';
import 'package:new_app/screens/pipe_down.dart';
import 'package:new_app/screens/score.dart';
import 'package:new_app/screens/tutorial.dart';
import 'package:new_app/shared/challenge.dart';
import 'package:new_app/shared/pipe_height.dart';

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  late Timer gameLoop;
  late Timer pipeGenerator;
  late Timer birdFall;
  late Timer checkGame;

  bool isShowTutorial = true;
  int score = 0;
  bool isBlinking = false;
  double yBird = 370;
  double rBird = 0;
  String status = "starting";
  double leftPipe = 400;
  List<PipeHeight> pipes = [
    PipeHeight(topHeight: 310),
  ];
  List<Widget> stack = [];

  void _restartGame() {
    setState(() {
      score = 0;
      isBlinking = false;
      yBird = 370;
      rBird = 0;
      status = "starting";
      leftPipe = 240;
      pipes = [
        PipeHeight(topHeight: 310),
      ];
      stack.removeLast();
      gameLoop.cancel();
      pipeGenerator.cancel();
      birdFall.cancel();
      checkGame.cancel();
    });
  }

  void _handleOnTap() {
    if (status == "starting" && leftPipe == 400) {
      setState(() {
        isShowTutorial = false;
      });
    }
    _fly();
    _start();
  }

  void _fly() {
    setState(() {
      yBird -= 65;
      rBird = -40 * pi / 180;
    });
  }

  void _fall() {
    setState(() {
      yBird += 30;
      rBird = 15 * pi / 180;
      if (status == "game-over") {
        yBird += 15;
      }
    });
  }

  void _running() {
    setState(() {
      leftPipe -= 10;
    });
  }

  void _generate() {
    var _random = new Random();
    setState(() {
      pipes = [
        ...pipes,
        PipeHeight(topHeight: _random.nextDouble() * 300 + 70)
      ];
    });
  }

  void _gameOver() {
    setState(() {
      status = "game-over";
    });
  }

  void _start() {
    if (status == "starting") {
      gameLoop = Timer.periodic(new Duration(milliseconds: 150), (timer) {
        _running();

        if (status == "game-over") {
          gameLoop.cancel();
        }
      });

      pipeGenerator = Timer.periodic(new Duration(milliseconds: 3000), (timer) {
        _generate();
        if (status == "game-over") {
          pipeGenerator.cancel();
        }
      });

      birdFall = Timer.periodic(new Duration(milliseconds: 200), (timer) {
        _fall();

        if (yBird > 580 && status == "game-over") {
          birdFall.cancel();
          setState(() {
            isBlinking = false;
            rBird = 90 * pi / 180;
          });
        }
      });

      checkGame = Timer.periodic(new Duration(milliseconds: 250), (timer) {
        _check();

        if (yBird > 580 && status == "game-over") {
          isBlinking = false;
          checkGame.cancel();
        }
      });
    }

    if (status != "game-over") {
      setState(() {
        status = "playing";
      });
    }
  }

  void _check() {
    List<Challenge> challenge = [];

    for (var i = 0; i < pipes.length; i++) {
      challenge.add(Challenge(
          x1: leftPipe + i * 360,
          y1: pipes[i].topHeight,
          x2: leftPipe + i * 360,
          y2: pipes[i].topHeight + 150));
    }

    challenge = challenge
        .where((element) => element.x1 > 0 && element.x1 < 360)
        .toList();

    if (yBird > 580) {
      _gameOver();
      setState(() {
        isBlinking = true;
      });
    }

    if (challenge.length > 0) {
      var x1 = challenge[0].x1;
      var y1 = challenge[0].y1;
      var x2 = challenge[0].x2;
      var y2 = challenge[0].y2;

      if ((x1 <= 195 && 120 <= x1 + 85 && yBird - 5 <= y1) ||
          (x2 <= 195 && 120 <= x2 + 85 && yBird + 52 >= y2)) {
        _gameOver();
        setState(() {
          isBlinking = true;
        });
      }

      if (x1 + 85 < 120 && 120 < x1 + 105 && status == "playing") {
        setState(() {
          score++;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    stack = <Widget>[
      // background
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),

      // pipes
      ...pipes
          .asMap()
          .map((i, pipeHeight) => MapEntry(
              i,
              AnimatedPositioned(
                  child: Stack(
                    children: [
                      Positioned(
                          top: -190.0 - (310.0 - pipeHeight.topHeight),
                          left: leftPipe + i * 360,
                          child: PipeDown()),
                      Positioned(
                          top: pipeHeight.topHeight + 150.0,
                          left: leftPipe + i * 360,
                          child: Pipe()),
                    ],
                  ),
                  duration: Duration(milliseconds: 300))))
          .values
          .toList(),

      // ground
      Positioned(bottom: 0, child: Ground()),

      // bird
      AnimatedPositioned(
          key: UniqueKey(), // redraw the bird when state is changed
          duration: Duration(milliseconds: 150),
          top: yBird,
          left: 120,
          child: Transform.rotate(
            angle: rBird,
            child: Bird(),
          )),
      // blinking effect
      Blinking(isBlinking: isBlinking, key: UniqueKey()),

      Align(
          alignment: Alignment(0, -0.90),
          child: Score(
            score: score,
            key: UniqueKey(),
          )),

      if (isShowTutorial) Tutorial()
    ];

    if (status == 'game-over') {
      stack.add(GameOver(
        score: score,
        restartGame: _restartGame,
      ));
    }

    return Scaffold(
        body: GestureDetector(
      onTap: status == "game-over" ? null : _handleOnTap,
      child: Stack(children: stack),
    ));
  }
}
