import 'package:flutter/material.dart';
import 'package:flutter_finance/src/utils/values/colors.dart';

class FormFieldMain extends StatelessWidget {
  final Key key;
  final double marginLeft;
  final double marginRight;
  final double marginTop;
  final TextInputType textInputType;
  final String hintText;
  final bool obscured;
  final void Function(void) onChanged;
  final String errorText;

  const FormFieldMain({
    this.key,
    @required this.obscured,
    @required this.marginLeft,
    @required this.marginRight,
    @required this.marginTop,
    @required this.textInputType,
    @required this.hintText,
    this.onChanged,
    this.errorText
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: marginLeft, right: marginRight, top: marginTop),
      child: TextField(
        key: key,
        onChanged: onChanged,
        keyboardType: textInputType,
        obscureText: obscured,
        decoration: InputDecoration(
          errorText: errorText,
          filled: true,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 1,
                  color: Color(0xCC000000)
              ),
              borderRadius: BorderRadius.all(Radius.circular(0))
          ),
          fillColor: Colors.white,
          hintText: hintText,
          labelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: ColorConstant.colorMainPurple),
          ),
        ),
      ),
    );
  }
}