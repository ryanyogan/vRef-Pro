import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:third_eye/about_page/about_page.dart';
import 'package:third_eye/add_question/add_question.dart';
import 'package:third_eye/add_system/add_system.dart';
import 'package:third_eye/help/HelpPage.dart';
import 'package:third_eye/luancher_page/launcherPage.dart';
import 'package:third_eye/system_list/system_list.dart';
import 'package:third_eye/utils/Strings.dart';
import 'package:third_eye/utils/colors.dart';
import 'package:third_eye/utils/constants.dart';
import 'package:third_eye/utils/my_preference.dart';

import 'drawer-tile.dart';

class MaterialDrawer extends StatefulWidget {
  final String currentPage;
  bool isSystemListToDisplay = true;
  bool isAddSystemToDisplay = false;
  bool isAddQueToDisplay = false;
  String title = "";
  int planeId = 0;

  MaterialDrawer.defaulter({required this.currentPage});

  MaterialDrawer.fromIntro({required this.currentPage, required this.isSystemListToDisplay});
  MaterialDrawer.fromHelp({required this.currentPage, required this.isSystemListToDisplay});

  MaterialDrawer.system(
      {required this.currentPage,
      required this.isAddSystemToDisplay,
      required this.planeId});

  MaterialDrawer.addquestion(
      {required this.currentPage,
      required this.isAddQueToDisplay,
      required this.title});

  @override
  _MaterialDrawerState createState() => _MaterialDrawerState();
}

class _MaterialDrawerState extends State<MaterialDrawer> {
  SharedPreferences? preferences;
  String Fname = "";
  String Lname = "";
  int? planesId;
  String email = "";

  @override
  void initState() {
    _get();
    // TODO: implement initState
    super.initState();
  }

  Future<void> _get() async {
    Fname = await MyPreference.getStringToSF(MyPreference.Fname);
    Lname = await MyPreference.getStringToSF(MyPreference.Lname);
    email = await MyPreference.getStringToSF(MyPreference.email);
    setState(() {
      this.Fname = Fname;
      this.Lname = Lname;
      this.email = email;
    });
  }

  void _logout() async {
    preferences = await SharedPreferences.getInstance();
    preferences!.setBool(Constants.keyIsLogin, false);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
          child: Column(children: [
        UserAccountsDrawerHeader(
          decoration: BoxDecoration(
            color: MyColor.primary,
          ),
          accountName: Text(
            Fname + " " + Lname,
          ),
          accountEmail: Text(
            email,
          ),
        ),
        Expanded(
            child: ListView(
          padding: EdgeInsets.only(top: 8, left: 8, right: 8),
          children: [
            DrawerTile(
                icon: Icons.home,
                onTap: () {
                  if (widget.currentPage != Strings.home)
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LauncherPage()),
                    );
                },
                iconColor: Colors.black,
                title: Strings.home,
                isSelected: widget.currentPage == Strings.home ? true : false),
            Visibility(
              visible: this.widget.isSystemListToDisplay,
              child: DrawerTile(
                  icon: Icons.grain,
                  onTap: () {
                    if (widget.currentPage != "System")
                      planesId=preferences!.getInt('PlaneId');
                      if(planesId==null){
                        planesId=0;
                      }
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => SystemList(
                             planeId: planesId!,
                          )
                        ),
                      );
                  },
                  iconColor: Colors.black,
                  title: "System",
                  isSelected: widget.currentPage == "System" ? true : false),
            ),
            this.widget.isAddSystemToDisplay
                ? DrawerTile(
                    icon: Icons.library_add,
                    onTap: () {
                      if (widget.currentPage != "Add System")
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddSystem(
                                    planeId: widget.planeId,
                                  )),
                        );
                    },
                    iconColor: Colors.black,
                    title: "Add System",
                    isSelected:
                        widget.currentPage == "Add System" ? true : false)
                : Padding(padding: EdgeInsets.zero),
            /*this.widget.isAddQueToDisplay
                ? DrawerTile(
                    icon: Icons.library_add,
                    onTap: () {
                      if (widget.currentPage != "Add Question")
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddQuestion(
                                    systemId: widget.systemId,
                                    title: widget.title,
                                  )),
                        );
                    },
                    iconColor: Colors.black,
                    title: "Add Question",
                    isSelected:
                        widget.currentPage == "Add Question" ? true : false)
                : Padding(padding: EdgeInsets.zero),*/
            DrawerTile(
                icon: Icons.help_center_outlined,
                onTap: () {
                  if (widget.currentPage != Strings.help)
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HelpPage()),
                    );
                },
                iconColor: Colors.black,
                title: Strings.help,
                isSelected: widget.currentPage == Strings.help ? true : false),
            DrawerTile(
                icon: Icons.info_outline,
                onTap: () {
                  if (widget.currentPage != Strings.about)
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => AboutPage()),
                    );
                },
                iconColor: Colors.black,
                title: Strings.about,
                isSelected: widget.currentPage == Strings.about ? true : false),
           /* DrawerTile(
                icon: Icons.exit_to_app,
                onTap: () {
                  if (widget.currentPage != "Exit") {
                    _logout();
                    Future.delayed(const Duration(milliseconds: 1000), () {
                      SystemChannels.platform
                          .invokeMethod('SystemNavigator.pop');
                    });
                  }
                },
                iconColor: Colors.black,
                title: "Exit",
                isSelected: widget.currentPage == "Exit" ? true : false),*/
          ],
        ))
      ])),
    );
  }
}
