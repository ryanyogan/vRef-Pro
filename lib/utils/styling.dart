import 'package:flutter/material.dart';
import 'package:third_eye/utils/size_config.dart';

import 'colors.dart';

class AppTheme {
  AppTheme._();

  static const Color appBackgroundColorLight = MyColor.white;
  static const Color appBarBackgroundColorLight = MyColor.primaryDark;
  static const Color iconColorLight = MyColor.white;
  static const Color textTitleColorLight = MyColor.textColor;
  static const Color subtextTitleColorLight = MyColor.textColor;
  static const Color cursorColor = MyColor.primary;

  static final ThemeData lightTheme = ThemeData(
    fontFamily: 'Montserrat-Regular',
    scaffoldBackgroundColor: appBackgroundColorLight,
    appBarTheme: AppBarTheme(
      shadowColor: MyColor.primaryDark,
      color: appBarBackgroundColorLight,
      iconTheme: IconThemeData(
        color: iconColorLight,
      ),
      textTheme: TextTheme(
        headline2: TextStyle(
          color: textTitleColorLight,
          fontSize: 2.7 * SizeConfig.textMultiplier,
        ),
      ),
    ),
    colorScheme: ColorScheme.light(
      primary: appBackgroundColorLight,
      onPrimary: Colors.white,
      primaryVariant: Colors.white38,
      secondary: appBarBackgroundColorLight,
    ),
    cardTheme: CardTheme(
      color: appBackgroundColorLight,
    ),
    iconTheme: IconThemeData(
      color: iconColorLight,
    ),
    textTheme: TextTheme(
      headline6: TextStyle(
        color: textTitleColorLight,
        fontSize: 2.7 * SizeConfig.textMultiplier,
      ),
      subtitle1: TextStyle(
        color: subtextTitleColorLight,
        fontSize: 2.2 * SizeConfig.textMultiplier,
      ),
      subtitle2: TextStyle(
        color: subtextTitleColorLight,
        fontSize: 2.0 * SizeConfig.textMultiplier,
      ),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: MyColor.primary,
      textTheme: ButtonTextTheme.accent,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(
          side: BorderSide(
              color: MyColor.white, width: 4, style: BorderStyle.solid),
        ),
        elevation: 5.0,
        primary: MyColor.primaryDark,
      ),
    ),
  );
  static ButtonStyle buttonStyle(BuildContext context) {
    ButtonStyle textStyle = ElevatedButton.styleFrom(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
      elevation: 5.0,
      primary: MyColor.primaryDark,
      textStyle: Theme.of(context).textTheme.subtitle1!.copyWith(color: MyColor.white)
    );
    return textStyle;
  }
}
