import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:third_eye/disclaimer/disclaimerpage.dart';
import 'package:third_eye/intro_category/introductoryPage.dart';
import 'package:third_eye/utils/constants.dart';

class LauncherPage extends StatefulWidget {
  @override
  _LauncherPageState createState() => _LauncherPageState();
}

class _LauncherPageState extends State<LauncherPage> {
  late SharedPreferences preferences;
  late bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    initializePreference().whenComplete(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return (isLoggedIn ? IntroductoryPage() : DisclaimerPage());
  }

  Future<void> initializePreference() async {
    preferences = await SharedPreferences.getInstance();
    isLoggedIn = preferences.getBool(Constants.keyIsLogin)!;
  }
}
