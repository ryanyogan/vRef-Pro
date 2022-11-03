import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:third_eye/utils/colors.dart';

abstract class MyTheme {
  static final BoxDecoration boxDecorationAppBar = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[MyColor.primary, MyColor.primaryDark],
    ),
  );

  static final BoxDecoration boxDecorationContainerRadius = BoxDecoration(
    borderRadius: BorderRadius.circular(10.0),
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[MyColor.primary, MyColor.primaryDark]
    ),
  );

  static final BoxDecoration boxDecorationContainer = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[MyColor.primary, MyColor.primaryDark]
    ),
  );

  static final BoxDecoration boxDecorationContainerCircle = BoxDecoration(
    shape: BoxShape.circle,
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[MyColor.primary, MyColor.primaryDark]
    ),
  );

  static final BoxDecoration boxDecorationFloat = BoxDecoration(
    shape: BoxShape.circle,
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[MyColor.primary, MyColor.primaryDark]
    ),
  );

  static final BoxDecoration boxDecorationContainerChartRadius = BoxDecoration(
    borderRadius: BorderRadius.circular(10.0),
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[MyColor.white, MyColor.lightGrey],
    ),
  );
}
