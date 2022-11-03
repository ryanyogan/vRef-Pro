import 'package:flutter/material.dart';
import 'package:third_eye/utils/colors.dart';

typedef void CallbackAction(String value);

class MyTextFieldBorder extends StatefulWidget {
  final TextEditingController controller;
  String hint = "", label = "";
  final CallbackAction StringCallBack;
  TextInputAction txtInputAction = TextInputAction.next;
  TextInputType txtInputType = TextInputType.text;
  Color txtcolor = MyColor.textColor;

  MyTextFieldBorder.primary(
      {this.hint = "",
      this.label = "",
      required this.controller,
      required this.StringCallBack});

  MyTextFieldBorder.secondry(
      {this.hint = "",
      this.label = "",
      required this.controller,
      required this.txtInputAction,
      required this.txtInputType,
      required this.StringCallBack});

  MyTextFieldBorder.HLCC({
    this.hint = "",
    this.label = "",
    required this.controller,
    required this.txtInputAction,
    required this.txtInputType,
    required this.StringCallBack,
    this.txtcolor = MyColor.textColor,
  });

  @override
  _MyTextFieldBorderState createState() => _MyTextFieldBorderState();
}

class _MyTextFieldBorderState extends State<MyTextFieldBorder> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: (value) {
        widget.StringCallBack(value);
      },
      onChanged: (value) {
        widget.StringCallBack(value);
      },
      textInputAction: widget.txtInputAction,
      keyboardType: widget.txtInputType,
      controller: widget.controller,
      cursorColor: MyColor.primary,
      style: TextStyle(
        color: widget.txtcolor,
      ),
      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: TextStyle(
          color: MyColor.lightGrey,
        ),
        labelText: widget.label,
        labelStyle: TextStyle(
          color: MyColor.primary,
        ),
        border: OutlineInputBorder(
          borderSide: new BorderSide(color: MyColor.primary),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: MyColor.primary),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: MyColor.primary),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.redAccent),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.redAccent),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: MyColor.lightGrey),
        ),
      ),
    );
  }
}
