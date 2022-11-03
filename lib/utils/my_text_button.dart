import 'package:flutter/material.dart';
import 'package:third_eye/utils/colors.dart';

class MyTextButton extends StatelessWidget {
  String btnText;
  final VoidCallback myCallBackFunc;

  MyTextButton({required this.btnText, required this.myCallBackFunc});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(
        btnText,
      ),
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          EdgeInsets.all(15),
        ),
        textStyle: MaterialStateProperty.all<TextStyle>(
          TextStyle(
            fontSize: 22,
          ),
        ),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        backgroundColor: MaterialStateProperty.all<Color>(MyColor.primary),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            side: BorderSide(
              color: Colors.white,
            ),
          ),
        ),
      ),
      onPressed: myCallBackFunc,
    );
  }
}
