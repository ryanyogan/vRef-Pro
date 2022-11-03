import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:third_eye/database_setup/database.dart';
import 'package:third_eye/database_setup/model/other_details.dart';
import 'package:third_eye/utils/colors.dart';
import 'package:third_eye/utils/constants.dart';
import 'package:third_eye/utils/my_text_field_border_widget.dart';
import 'package:third_eye/utils/size_config.dart';

typedef void CallbackAction(String value);

class MyDisclaimerFormBody extends StatefulWidget {
  final TextEditingController controllerFName;
  final TextEditingController controllerLName;
  final TextEditingController controllerEmail;
  final CallbackAction stringCallBackFName;
  final CallbackAction stringCallBackLName;
  final CallbackAction stringCallBackEmail;
  final VoidCallback myCallBackFunc;
  final ScrollController scrollController;

  MyDisclaimerFormBody(
      {required this.controllerFName,
      required this.controllerLName,
      required this.controllerEmail,
      required this.stringCallBackFName,
      required this.stringCallBackLName,
      required this.stringCallBackEmail,
      required this.myCallBackFunc,
      required this.scrollController});

  @override
  _MyDisclaimerFormBodyState createState() => _MyDisclaimerFormBodyState();
}

class _MyDisclaimerFormBodyState extends State<MyDisclaimerFormBody> {
  List<OtherDetails> questionDetails = [];
  String disclaimer = "";

  @override
  initState() {
    // TODO: implement initState
    super.initState();
    _getOtherDetails();
  }

  Future<void> _getOtherDetails() async {
    await DBProvider.db.getOtherDetails().then((value) {
      disclaimer = value[0].disclaimer!;
      setState(() {
        disclaimer = disclaimer;
        print("disclaimer $disclaimer");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 0,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: MyTextFieldBorder.primary(
                hint: "Enter First Name",
                label: "First Name",
                controller: widget.controllerFName,
                StringCallBack: (value) {
                  widget.stringCallBackFName(value);
                },
              ),
            ),
          ),
          Expanded(
            flex: 0,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: MyTextFieldBorder.primary(
                hint: "Enter Last Name",
                label: "Last Name",
                controller: widget.controllerLName,
                StringCallBack: (value) {
                  widget.stringCallBackLName(value);
                },
              ),
            ),
          ),
          Expanded(
            flex: 0,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: MyTextFieldBorder.secondry(
                hint: "Enter Email",
                label: "Email",
                controller: widget.controllerEmail,
                txtInputAction: TextInputAction.done,
                txtInputType: TextInputType.emailAddress,
                StringCallBack: (value) {
                  widget.stringCallBackEmail(value);
                },
              ),
            ),
          ),
          Expanded(
            flex: 0,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(
                  color: MyColor.primary,
                )),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Disclaimer",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: MyColor.primary,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.fromLTRB(5.0, 0, 5.0, 0),
              child: Card(
                elevation: Constants.cardElevation,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    child: SingleChildScrollView(
                      child: Text(
                        disclaimer,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
