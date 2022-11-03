import 'package:flutter/material.dart';
import 'package:third_eye/utils/colors.dart';

class MyText extends StatelessWidget {
  String myString;
  double fontSize = 18;
  Color _color = MyColor.textColor;

  MyText.Default(this.myString);

  MyText.Secondry(this.myString, this.fontSize);

  MyText.TxtSFC(this.myString, this.fontSize, this._color);

  @override
  Widget build(BuildContext context) {
    return Text(
      myString,
      style: TextStyle(
        color: _color,
        fontSize: fontSize,
      ),
    );
  }
}
