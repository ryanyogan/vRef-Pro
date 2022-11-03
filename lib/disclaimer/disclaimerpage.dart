import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:third_eye/database_setup/database.dart';
import 'package:third_eye/database_setup/model/other_details.dart';
import 'package:third_eye/intro_category/introductoryPage.dart';
import 'package:third_eye/luancher_page/launcherPage.dart';
import 'package:third_eye/utils/colors.dart';
import 'package:third_eye/utils/constants.dart';
import 'package:third_eye/utils/my_dialog.dart';
import 'package:third_eye/utils/my_preference.dart';

import 'disclaimer_form.dart';

class DisclaimerPage extends StatefulWidget {
  @override
  _DisclaimerPageState createState() => _DisclaimerPageState();
}

class _DisclaimerPageState extends State<DisclaimerPage> {
  var _Fname = "";
  var _Lname = "";
  var _email = "";
  TextEditingController _controllerFName = TextEditingController();
  TextEditingController _controllerLname = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  ScrollController _scrollController = ScrollController();
  bool isChecked = false;
  SharedPreferences? preferences;

  void onSubmitOfFNamedTextField(String value) {
    print("onSubmitted: $value");
    setState(() {
      _Fname = _controllerFName.text;
    });
  }

  void onSubmitOfLNamedTextField(String value) {
    print("onSubmitted: $value");
    setState(() {
      _Lname = _controllerLname.text;
    });
  }

  void onSubmitOfEmailedTextField(String value) {
    print("onSubmitted: $value");
    setState(() {
      _email = _controllerEmail.text;
    });
  }

  void onInfoBtnClicked() {
    String help = "";
    DBProvider.db.getOtherDetails().then((value) {
      help = value[0].help!;
    });

    showDialog(
      context: context,
      builder: (BuildContext Context) => DisclaimerDialog(
        title: "Info",
        content: help,
        voidCallbackCancel: () => Navigator.pop(context),
        voidCallbackOkay: () => Navigator.pop(context),
      ),
      barrierDismissible: false,
    );
  }

  void onDisclaimerBtnClicked() {
//    print("Name ${_name} & Email ${_email}");

    String disclaimer = "";
    DBProvider.db.getOtherDetails().then((value) {
      disclaimer = value[0].disclaimer!;
    });

    showDialog(
      context: context,
      builder: (BuildContext Context) => DisclaimerDialog(
        title: "Disclaimer",
        content: disclaimer,
        voidCallbackCancel: () => Navigator.pop(context),
        voidCallbackOkay: () => Navigator.pop(context),
      ),
      barrierDismissible: false,
    );
  }

  @override
  void initState() {
    super.initState();
    initializePreference().whenComplete(() {
      setState(() {});
    });
  }

  Future<void> initializePreference() async {
    this.preferences = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        leading: IconButton(
          alignment: Alignment.center,
          onPressed: onInfoBtnClicked,
          icon: SvgPicture.asset(
            'assets/images/info.svg',
            height: 30,
            width: 30,
            color: Colors.white,
            matchTextDirection: true,
          ),
          tooltip: 'About',
        ),
        centerTitle: true,
        title: Text(
          'VrefPro',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: MyDisclaimerFormBody(
        controllerFName: _controllerFName,
        controllerLName: _controllerLname,
        controllerEmail: _controllerEmail,
        scrollController: _scrollController,
        stringCallBackFName: (value) {
          print("stringCallBackEmail $value");
          onSubmitOfFNamedTextField(value);
        },
        stringCallBackLName: (covariant) {
          print("stringCallBackEmail $covariant");
          onSubmitOfFNamedTextField(covariant);
        },
        stringCallBackEmail: (value) {
          print("stringCallBackEmail $value");
          onSubmitOfEmailedTextField(value);
        },
        myCallBackFunc: onDisclaimerBtnClicked,
      ),
      bottomNavigationBar: SingleChildScrollView(
        child: Container(
          color: MyColor.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(
                  value: isChecked,
                  onChanged: (newValue) async {
                    if (_controllerFName.text.isEmpty) {
                      Constants.toast("Enter First Name");
                      return;
                    }
                    if (_controllerLname.text.isEmpty) {
                      Constants.toast("Enter Last Name");
                      return;
                    }
                    if (_controllerEmail.text.isEmpty) {
                      Constants.toast("Enter Email");
                      return;
                    }
                    if (!RegExp(Constants.regExp).hasMatch(_controllerEmail.text)) {
                      Constants.toast("Please enter a valid email Address");
                      return;
                    }

                    await MyPreference.addStringToSF(
                        MyPreference.Fname, _controllerFName.text);
                    await MyPreference.addStringToSF(
                        MyPreference.Lname, _controllerLname.text);
                    await MyPreference.addStringToSF(
                        MyPreference.email, _controllerEmail.text);
                    setState(() {
                      isChecked = newValue!;
                    });
                    preferences?.setBool(Constants.keyIsLogin, isChecked);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => IntroductoryPage()),
                    );
                  },
                ),
                Text(
                  "I accept and continue",
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
