import 'dart:math';

import 'package:flutter/material.dart';
import 'package:third_eye/database_setup/database.dart';
import 'package:third_eye/database_setup/model/system_list.dart';
import 'package:third_eye/drawer/my_drawer.dart';
import 'package:third_eye/system_list/system_list.dart';
import 'package:third_eye/utils/Animation/FadeAnimation.dart';
import 'package:third_eye/utils/Strings.dart';
import 'package:third_eye/utils/colors.dart';
import 'package:third_eye/utils/constants.dart';
import 'package:third_eye/utils/my_asset_image.dart';
import 'package:third_eye/utils/size_config.dart';
import 'package:third_eye/utils/styling.dart';

class AddSystem extends StatefulWidget {

  final planeId;

  const AddSystem({Key? key, this.planeId}) : super(key: key);


  @override
  _AddSystemState createState() => _AddSystemState();
}

class _AddSystemState extends State<AddSystem> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var _systemName;
  bool isLoading = false;
  TextEditingController nameCon = new TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameCon = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  SystemList(planeId: widget.planeId,)),
        );
        return false;
      },
      child: GestureDetector(
        onTap: (){
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          drawer: MaterialDrawer.defaulter(currentPage: Strings.system),
          appBar: AppBar(
            title: Text(
              "ADD SYSTEM",
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: MyColor.white),
            ),
          ),
          bottomNavigationBar: Container(
            width: SizeConfig.widthMultiplier * 80,
            padding: EdgeInsets.symmetric(
                horizontal: 9 * SizeConfig.widthMultiplier,
                vertical: 3 * SizeConfig.heightMultiplier),
            child: FadeAnimation(
              2,
              isLoading
                  ? Center(
                child: CircularProgressIndicator(),
              )
                  : Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () async {
                      Navigator.pop(context);
                    },
                    child: Container(
                      child:Text("BACK",style: Theme.of(context).textTheme.headline6!.copyWith(fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,color: MyColor.primary),),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      if (!_formKey.currentState!
                          .validate()) {
                        return;
                      }
                      _formKey.currentState!.save();
                      /* if (!widget.isAddQuestion) {
                                                  await DBProvider.db
                                                      .updateClient(
                                                    QuestionDetails(
                                                      id: widget.id,
                                                      systemId: widget.systemId,
                                                      question: _question,
                                                      answer: _answer,
                                                      description: _description,
                                                    ),
                                                  );
                                                } else {*/
                      Random random = new Random();
                      int randomNumber =
                      random.nextInt(1000);
                      await DBProvider.db.newSystemList(
                        SystemListModel(
                          planeId: widget.planeId,
                          name: _systemName,
                          status: 0,
                        ),
                      );
                      //}
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                SystemList(planeId: widget.planeId,)),
                      );
                    },
                    child: Container(
                      child:Text("SAVE",style: Theme.of(context).textTheme.headline6!.copyWith(fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,color: MyColor.primary),),
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            child: Stack(
              children: [
                Container(
                  child: Card(
                    color: Colors.white54,
                  ),
                ),
                Container(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: FadeAnimation(
                        1.8,
                        Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              SizedBox(
                                height: 0.5 * SizeConfig.heightMultiplier,
                              ),
                               Container(
                                color: Colors.white,
                                child: Image.asset(
                                  "assets/images/ic_appicon.png",
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.contain,
                                  height: Constants.imageSize,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(40.0),
                                child: Text("...NOW ADD A SYSTEM DESCRIPTION FOR YOUR NEW SYSTEM"),
                              ),
                              SizedBox(
                                height: 0.5 * SizeConfig.heightMultiplier,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: new TextFormField(
                                  textCapitalization: TextCapitalization.characters,
                                  controller: nameCon,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(10),
                                    labelText: 'Enter System Name',
                                    labelStyle:
                                    TextStyle(color: MyColor.textColor),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: MyColor.textColor),
                                      //  when the TextFormField in unfocused
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: MyColor.textColor),
                                      //  when the TextFormField in focused
                                    ),
                                    border: OutlineInputBorder(),
                                  ),
                                  // decoration: inputDecorationRequestTitle,
                                  cursorColor: AppTheme.cursorColor,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(
                                      color: MyColor.primaryDark,
                                      fontSize: SizeConfig.webAppBarSize),
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'System name is required';
                                    }
                                    return null;
                                  },
                                  onSaved: (String? value) {
                                    _systemName = value;
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 4.0 * SizeConfig.heightMultiplier,
                              ),

                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
