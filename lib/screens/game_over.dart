import 'package:flutter/material.dart';

class GameOver extends StatefulWidget {
  final score;
  final Function restartGame;

  GameOver({Key? key, required this.score, required this.restartGame})
      : super(key: key);

  @override
  _GameOverState createState() => _GameOverState();
}

class _GameOverState extends State<GameOver>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  int score = 0;
  bool buttonDisabled = true;

  @override
  void initState() {
    super.initState();
    score = widget.score;

    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2000),
    )..repeat();

    animationController.addListener(() => setState(() {}));
    TickerFuture tickerFuture = animationController.repeat();
    tickerFuture.timeout(Duration(milliseconds: 1900), onTimeout: () {
      buttonDisabled = false;
      animationController.stop(canceled: true);
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
            child: AnimatedBuilder(
                animation: animationController,
                builder: (context, child) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 250 * animationController.value,
                        height: 55 * animationController.value,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/gameover.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      SizedBox(height: 25),
                      Card(
                          color: Color(0xFFFFECB3),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Colors.black,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          // color: Color(0xDED697),
                          child: Container(
                            height: 150 * animationController.value,
                            width: 280 * animationController.value,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text("Score",
                                    style: TextStyle(
                                        fontFamily: 'FlappyBird',
                                        fontSize:
                                            25 * animationController.value,
                                        fontStyle: FontStyle.normal,
                                        color: Colors.black)),
                                SizedBox(
                                    height: 10 * animationController.value),
                                Text("$score",
                                    style: TextStyle(
                                        fontFamily: 'FlappyBird',
                                        fontSize:
                                            25 * animationController.value,
                                        fontStyle: FontStyle.normal,
                                        color: Colors.white))
                              ],
                            ),
                          )),
                      SizedBox(height: 25 * animationController.value),
                      Container(
                        height: 80 * animationController.value,
                        width: 120 * animationController.value,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage('assets/playbtn.png'))),
                        child: TextButton(
                            onPressed: () {
                              if (!buttonDisabled) {
                                widget.restartGame();
                              }
                            },
                            child: Text('')),
                      ),
                    ],
                  );
                })));
  }
}
