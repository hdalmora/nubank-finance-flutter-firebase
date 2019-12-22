import 'package:flutter/material.dart';

class OptionsButton extends StatelessWidget {
  final IconData icon;
  final String text;

  const OptionsButton({
    @required this.icon,
    @required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return
      Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              color: Colors.white70,
              size: 32.0,
            ),
            SizedBox(width: 12.0,),
            Text(
              text,
              style: TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.w400,
                  fontSize: 23.0),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white70,
                  size: 16.0,
                ),
              ),
            ),
          ],
        ),
      );
  }
}
