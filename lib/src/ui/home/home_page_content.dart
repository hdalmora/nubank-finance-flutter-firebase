import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_finance/src/ui/widgets/bottom_action_button.dart';

const double minTop = 200;
const double maxQuickActionsMargin = 80;
const double minQuickActionsMargin = -170;

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
        return Stack(
          children: <Widget>[
            Positioned(
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
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  margin: const EdgeInsets.only(left: 15.0, right: 15.0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(8), bottom: Radius.circular(8)),
                  ),
                  child: Container(), //TODO: Home Finance card content
                ),
              ),
            ),

            Positioned(
              height: MediaQuery.of(context).size.height*.17,
              left: 0,
              right: 0,
              bottom: lerp(maxQuickActionsMargin, minQuickActionsMargin),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  BottomActionButton(
                    icon: Icons.money_off,
                    iconSize: 32.0,
                    actionText: "Incluir despesa",
                  ),
                  BottomActionButton(
                    icon: Icons.attach_money,
                    iconSize: 32.0,
                    actionText: "Incluir ganho",
                  ),
                  BottomActionButton(
                    icon: Icons.monetization_on,
                    iconSize: 32.0,
                    actionText: "Budget mensal",
                  ),
                  BottomActionButton(
                    icon: Icons.group_add,
                    iconSize: 32.0,
                    actionText: "Indicar amigos",
                  ),
                  BottomActionButton(
                    icon: Icons.help_outline,
                    iconSize: 32.0,
                    actionText: "Sobre",
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
