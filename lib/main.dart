import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:third_eye/utils/constants.dart';
import 'package:third_eye/utils/size_config.dart';
import 'package:third_eye/utils/styling.dart';

import 'database_setup/database.dart';
import 'database_setup/model/other_details.dart';
import 'disclaimer/disclaimerpage.dart';
import 'intro_category/introductoryPage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  try {
    DBProvider.db.readFromLocalAssets();
  } catch (e) {
    print(e);
  }

  if (prefs.getBool(Constants.keyIsLogin) != null) {
    runApp(MyApp(prefs.getBool(Constants.keyIsLogin)!));
  } else {
    runApp(MyApp(false));
  }
}

class MyApp extends StatelessWidget {
  late bool isLoggedIn;

  MyApp(this.isLoggedIn);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: "ThingsLinker",
              theme: AppTheme.lightTheme,
              // ThemeData(primarySwatch: Colors.blue),
              //darkTheme: AppTheme.darkTheme,
              // ThemeData(primarySwatch: Colors.blue),
              home: (isLoggedIn ? IntroductoryPage() : DisclaimerPage()),
              routes: <String, WidgetBuilder>{
                //Routes.driver_info: (BuildContext context) => new DriverInfo(),
              },
            );
          },
        );
      },
    );
  }
}
