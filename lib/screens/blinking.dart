import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Blinking extends StatefulWidget {
  var isBlinking;

  Blinking({Key? key, required this.isBlinking}) : super(key: key);
  @override
  _BlinkingState createState() => _BlinkingState();
}

class _BlinkingState extends State<Blinking>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    if (widget.isBlinking) {
      _animationController = new AnimationController(
          vsync: this, duration: Duration(milliseconds: 80));
      _animationController.repeat();
      // _animationController.addListener(() => setState(() {}));
      // TickerFuture tickerFuture = _animationController.repeat();
      // tickerFuture.timeout(Duration(milliseconds: 80), onTimeout: () {
      //   _animationController.stop(canceled: true);
      // });
    } else {
      _animationController = new AnimationController(vsync: this);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animationController,
      child: Scaffold(
        backgroundColor: Colors.white,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
