import 'package:flutter/material.dart';
import 'package:flutter_finance/src/utils/values/colors.dart';

class ButtonTransparentMain extends StatelessWidget {
  final VoidCallback callback;
  final String text;
  final double marginLeft;
  final double marginRight;
  final double height;
  final double width;
  final double fontSize;

  const ButtonTransparentMain({
    @required this.callback,
    @required this.text,
    @required this.marginLeft,
    @required this.marginRight,
    @required this.height,
    @required this.width,
    @required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        margin: EdgeInsets.only(left: marginLeft, right: marginRight),
        alignment: Alignment.center,
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(
                width: 1,
                color: ColorConstant.colorMainPurple
            )
        ),
        child: Text(
          text,
          style: TextStyle(
              color: ColorConstant.colorMainPurple,
              fontWeight: FontWeight.w400,
              fontSize: fontSize
          ),
        ),
      ),
    );
  }
}