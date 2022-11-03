import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:third_eye/database_setup/database.dart';
import 'package:third_eye/database_setup/model/plane_categories.dart';
import 'package:third_eye/drawer/my_drawer.dart';
import 'package:third_eye/system_list/system_list.dart';
import 'package:third_eye/utils/Strings.dart';
import 'package:third_eye/utils/colors.dart';
import 'package:third_eye/utils/constants.dart';
import 'package:third_eye/utils/my_asset_image.dart';
import 'package:third_eye/utils/size_config.dart';
import 'package:third_eye/utils/styling.dart';

class IntroductoryPage extends StatefulWidget {
  @override
  _IntroductoryPageState createState() => _IntroductoryPageState();
}

class _IntroductoryPageState extends State<IntroductoryPage> {
  late SharedPreferences sharedPreferences;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  List<PlaneCategories> planeCategories = [];

  @override
  void initState() {
    super.initState();
    initializePreference();
  }

  Future<void> initializePreference() async {
    sharedPreferences = await SharedPreferences.getInstance();
    DBProvider.db.getPlaneCategories().then((value) async {
      if (value.length > 0) {
        setState(() {
          planeCategories.addAll(value);
        });
      } else {
        await DBProvider.db.planeCategories(
          PlaneCategories(id: 0, name: ""),
        );
        DBProvider.db.getPlaneCategories().then((value) {
          setState(() {
            planeCategories.addAll(value);
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        drawer: MaterialDrawer.fromIntro(
          currentPage: Strings.home,
          isSystemListToDisplay: false,
        ),
        backgroundColor: Color(0xFFFFFFFF),
        appBar: AppBar(
          title: Text(Strings.home),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: planeCategories.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    InkWell(
                      onTap: () async {
                        await sharedPreferences
                            .setInt('PlaneID', planeCategories[index].id!)
                            .then((value) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SystemList(
                                        planeId: planeCategories[index].id,
                                      )));
                        });
                      },
                      child: MyAssetImage("assets/images/plane1.jpg", 500),
                    ),
                    // ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      planeCategories[index].name,
                      style: TextStyle(
                        color: MyColor.textColor,
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                      ),
                    )
//              _createButton(),
                  ],
                );
              },
            ),
          ),
        ));
  }

  Container _createButton() {
    double c_width = MediaQuery.of(context).size.width * 0.9;

    return Container(
      height: 50.0,
      width: c_width,
      child: ElevatedButton(
        style: AppTheme.buttonStyle(context),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SystemList()),
          );
        },
        child: Container(
          alignment: Alignment.center,
          child: Text(
            "Next",
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
