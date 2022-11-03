import 'package:flutter/material.dart';
class MyAssetImage extends StatelessWidget {
  String assetPath = "";
  double height = 100;

  MyAssetImage(this.assetPath, this.height);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      assetPath,
      width: MediaQuery.of(context).size.width,
      fit: BoxFit.cover,
      height: height,
    );
  }
}
