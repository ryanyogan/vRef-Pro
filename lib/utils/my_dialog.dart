import 'package:flutter/material.dart';
import 'package:third_eye/utils/colors.dart';

class DisclaimerDialog extends StatelessWidget {
  late String title, content;
  final VoidCallback voidCallbackCancel, voidCallbackOkay;

  DisclaimerDialog(
      {this.title = "",
      this.content = "",
      required this.voidCallbackCancel,
      required this.voidCallbackOkay});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: TextStyle(
          color: MyColor.textColor,
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ), //here fontFamily = theme applied fonts
      ),
      content: Scrollbar(
        isAlwaysShown: true,
        showTrackOnHover: true,
        interactive: true,
        thickness: 5,
        radius: Radius.circular(10),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Text(
            content,
            style: TextStyle(
//              fontFamily: 'FiraSans',
//              fontStyle: FontStyle.italic,
              color: MyColor.textColor,
              fontSize: 18,
            ), //here fontFamily = assigned
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: voidCallbackCancel,
          child: Text('CANCEL',style: Theme.of(context).textTheme.subtitle2,),
          style: TextButton.styleFrom(
            textStyle: TextStyle(
              // this will make italic
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ), //here fontFamily = theme applied fonts
          ),
        ),
        TextButton(
          onPressed: voidCallbackOkay /*() => Navigator.pop(context)*/,
          child: Text('OKAY',style: Theme.of(context).textTheme.subtitle2),
          style: TextButton.styleFrom(
            textStyle: TextStyle(
              fontWeight: FontWeight.w600,
              // This will be semi bold
              fontSize: 16,
            ), //here fontFamily = assigned
          ),
        ),
      ],
    );
  }
}
