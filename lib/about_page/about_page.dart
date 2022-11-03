import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:third_eye/database_setup/database.dart';
import 'package:third_eye/drawer/my_drawer.dart';
import 'package:third_eye/intro_category/introductoryPage.dart';
import 'package:third_eye/utils/Strings.dart';
import 'package:third_eye/utils/constants.dart';
import 'package:third_eye/utils/my_asset_image.dart';
import 'package:third_eye/utils/my_text_button.dart';
import 'package:third_eye/utils/my_text_widget.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  late SharedPreferences sharedPreferences;
  String about = "";

  @override
  void initState() {
    super.initState();
    initializePreference();
  }

  Future<void> initializePreference() async {
    sharedPreferences = await SharedPreferences.getInstance();

    await DBProvider.db.getOtherDetails().then((value) {
      about = value[0].about!;
      setState(() {
        about = about;
        print("about $about");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MaterialDrawer.fromHelp(
        currentPage: Strings.about,
        isSystemListToDisplay: false,
      ),
      appBar: AppBar(
        title: Text(
          Strings.about,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: 0,
              child: Container(
                child: Image.asset(
                  "assets/images/ic_appicon.png",
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.contain,
                  height: Constants.imageSize,
                ),
              ),
            ),
            Expanded(
              flex: 0,
              child: MyText.Secondry(
                Constants.title_VREF_About,
                18,
              ),
            ),
            Expanded(
              flex: 0,
              child: Padding(
                padding: EdgeInsets.all(5),
              ),
            ),
            Expanded(
              flex: 1,
              child: Card(
                elevation: Constants.cardElevation,
                child: Container(
                  padding: EdgeInsets.all(10),
                  height: MediaQuery.of(context).size.height,
                  child: SingleChildScrollView(
                    child: Text(
                      about,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: MyTextButton(
            btnText: Constants.title_Back,
            myCallBackFunc: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => IntroductoryPage(),
                ),
              );
            }),
      ),
    );
  }
}
