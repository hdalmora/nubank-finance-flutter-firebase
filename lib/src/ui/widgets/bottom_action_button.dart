import 'package:flutter/material.dart';

import '../../utils/values/colors.dart';

class BottomActionButton extends StatelessWidget {
  final IconData icon;
  final double iconSize;
  final String actionText;
  final VoidCallback callback;

  const BottomActionButton({
    @required this.icon,
    @required this.iconSize,
    @required this.actionText,
    @required this.callback,
  });


  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: callback,
      child: Container(
        width: 150.0,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(left: 25.0, right: 5.0),
        decoration: const BoxDecoration(
          color: ColorConstant.colorAccentPurple,
          borderRadius: BorderRadius.vertical(top: Radius.circular(8), bottom: Radius.circular(8)),
        ),
        alignment: Alignment.topLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Icon(
              icon,
              color: Colors.white70,
              size: iconSize,
              semanticLabel: 'Quick Action for $actionText',
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  actionText,
                  style: TextStyle(
                      color: Colors.white70,
                      fontWeight: FontWeight.w400,
                      fontSize: 20.0
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
