import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/material.dart';

const double minTop = 200;

class HomePageContent extends StatefulWidget {
  @override
  _HomePageContentState createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent>
  with SingleTickerProviderStateMixin {

  AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    _controller.value += details.primaryDelta / minTop;
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_controller.isAnimating || _controller.status == AnimationStatus.completed)
      return;

    final double flingVelocity = details.velocity.pixelsPerSecond.dy / MediaQuery.of(context).size.height*.8;

    if(flingVelocity < 0.0)
      _controller.fling(velocity:  math.min(-2, -flingVelocity));
    else
      _controller.fling(velocity:  math.max(2, -flingVelocity));
  }

  double lerp(double min, double max) =>
      lerpDouble(min, max, _controller.value);

  @override
  Widget build(BuildContext context) {

    double maxTop = MediaQuery.of(context).size.height*.8;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Positioned(
          height: MediaQuery.of(context).size.height*.45,
          left: 0,
          right: 0,
          top: lerp(minTop, maxTop),
          child: GestureDetector(
            onVerticalDragUpdate: _handleDragUpdate,
            onVerticalDragEnd: _handleDragEnd,
            onTap: () {
            },
            child: Container(
              width: MediaQuery.of(context).size.width*.90,
              padding: const EdgeInsets.symmetric(horizontal: 32),
              margin: const EdgeInsets.only(left: 15.0, right: 15.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(8), bottom: Radius.circular(8)),
              ),
              child: Container(), //TODO: Home Finance card content
            ),
          ),
        );
      },
    );
  }
}
