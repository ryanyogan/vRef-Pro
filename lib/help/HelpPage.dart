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

class HelpPage extends StatefulWidget {
  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  late SharedPreferences sharedPreferences;
  String help = "";

  @override
  void initState() {
    super.initState();
    initializePreference();
  }

  Future<void> initializePreference() async {
    sharedPreferences = await SharedPreferences.getInstance();

    await DBProvider.db.getOtherDetails().then((value) {
      help = value[0].help!;
      setState(() {
        help = help;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MaterialDrawer.fromHelp(
        currentPage: Strings.help,
        isSystemListToDisplay: false,
      ),
      appBar: AppBar(
        title: Text(
          Constants.title_Help,
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
                Constants.title_VREF_Help,
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
                      help,
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
