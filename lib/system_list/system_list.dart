import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:third_eye/database_setup/database.dart';
import 'package:third_eye/database_setup/model/system_list.dart';
import 'package:third_eye/drawer/my_drawer.dart';
import 'package:third_eye/question_list_page/question_list_page.dart';
import 'package:third_eye/utils/Strings.dart';
import 'package:third_eye/utils/colors.dart';
import 'package:third_eye/utils/constants.dart';
import 'package:third_eye/utils/my_asset_image.dart';
import 'package:third_eye/utils/my_text_button.dart';
import 'package:third_eye/utils/size_config.dart';

class SystemList extends StatefulWidget {
  final planeId;

  const SystemList({Key? key, this.planeId}) : super(key: key);

  @override
  _SystemListState createState() => _SystemListState();
}

class _SystemListState extends State<SystemList> {
  List<String> _systemListName = [];
  List<int> _systemListId = [];
  late SharedPreferences sharedPreferences;
  List<SystemModel> _texts = [
    /*SystemModel("GENERAL", false),
    SystemModel("LIMITATIONS", false),
    SystemModel("APU", false),
    SystemModel("FUEL", false),
    SystemModel("HYDRAULICS", false),
    SystemModel("PNEUMATICS", false),
    SystemModel("AIRCONDITIONING", false),
    SystemModel("AVIONICS", false),
    SystemModel("WALK AROUND", false),
    SystemModel("ALL SYSTEMS", false),*/
  ];

  @override
  void initState() {
    super.initState();
    initializePreference();
    _setList();
  }

  Future<void> initializePreference() async {
    sharedPreferences = await SharedPreferences.getInstance();
    print(sharedPreferences.getInt(''));
  }

  Future<void> _setList() async {
    _systemListId.clear();
    _systemListName.clear();
    await DBProvider.db.getAllSystemList(widget.planeId).then((value) async {
      if (value.length > 0) {
        for (int i = 0; i < value.length; i++) {
          if (value[i].status == 0)
            _texts.add(SystemModel(
                value[i].id, value[i].planeId, value[i].name, false));
          else
            _texts.add(SystemModel(
                value[i].id, value[i].planeId, value[i].name, true));
        }

        setState(() {
          _texts = _texts;
        });
      } else {
        print("Plane id ${widget.planeId}");
        if (widget.planeId == 0) {
          await DBProvider.db.newSystemList(
            SystemListModel(
              planeId: widget.planeId,
              name: "GENERAL",
              status: 0,
            ),
          );
          await DBProvider.db.newSystemList(
            SystemListModel(
              planeId: widget.planeId,
              name: "LIMITATIONS",
              status: 0,
            ),
          );
          await DBProvider.db.newSystemList(
            SystemListModel(
              planeId: widget.planeId,
              name: "APU",
              status: 0,
            ),
          );
          await DBProvider.db.newSystemList(
            SystemListModel(
              planeId: widget.planeId,
              name: "FUEL",
              status: 0,
            ),
          );
          await DBProvider.db.newSystemList(
            SystemListModel(
              planeId: widget.planeId,
              name: "HYDRAULICS",
              status: 0,
            ),
          );
          await DBProvider.db.newSystemList(
            SystemListModel(
              planeId: widget.planeId,
              name: "PNEUMATICS",
              status: 0,
            ),
          );
          await DBProvider.db.newSystemList(
            SystemListModel(
              planeId: widget.planeId,
              name: "AIRCONDITIONING",
              status: 0,
            ),
          );
          await DBProvider.db.newSystemList(
            SystemListModel(
              planeId: widget.planeId,
              name: "AVIONICS",
              status: 0,
            ),
          );
          await DBProvider.db.newSystemList(
            SystemListModel(
              planeId: widget.planeId,
              name: "WALK AROUND",
              status: 0,
            ),
          );
          await DBProvider.db.newSystemList(
            SystemListModel(
              planeId: widget.planeId,
              name: "ALL SYSTEMS",
              status: 0,
            ),
          );
        }

        await DBProvider.db.getAllSystemList(widget.planeId).then((value) {
          for (int i = 0; i < value.length; i++) {
            if (value[i].status == 0)
              _texts.add(SystemModel(
                  value[i].id, value[i].planeId, value[i].name, false));
            else
              _texts.add(SystemModel(
                  value[i].id, value[i].planeId, value[i].name, true));
          }
          setState(() {
            _texts = _texts;
          });
        });
      }
      print("Data $_texts");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      drawer: MaterialDrawer.system(
        currentPage: Strings.system,
        isAddSystemToDisplay: true,
        planeId: widget.planeId,
      ),
      appBar: AppBar(
        title: Text(
          Constants.title_system_list,
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
            vertical: 2 * SizeConfig.heightMultiplier),
        child: MyTextButton(
            btnText: Constants.continueSystem,
            myCallBackFunc: () {
              setState(() {
                _systemListId.clear();
                _systemListName.clear();
                for (int i = 0; i < _texts.length; i++) {
                  if (_texts[i].isStatus) {
                    _systemListName.add(_texts[i].name);
                    _systemListId.add(_texts[i].id);
                  }
                }
              });
              if (_systemListId.isNotEmpty) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => QuestionListPage(
                            systemListName: _systemListName,
                            systemListId: _systemListId,
                            planeId: widget.planeId,
                            currentInd: 0,
                          )),
                );
              } else {
                Constants.toast("Select at-least one system category");
              }
            }),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              child: Image.asset(
                "assets/images/ic_appicon.png",
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.contain,
                height: Constants.imageSize,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "FOR TRAINING PURPOSES ONLY",
              style: Theme.of(context).textTheme.subtitle2,
            ),
            SizedBox(
              height: 10,
            ),
            Scrollbar(
              thickness: 10,
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _texts.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      children: [
                        Checkbox(
                          value: _texts[index].isStatus,
                          onChanged: (val) async {
                            await DBProvider.db.updateSystemList(
                              SystemListModel(
                                planeId: _texts[index].planeId,
                                name: _texts[index].name,
                                status: val! ? 1 : 0,
                              ),
                            );
                            setState(
                              () {
                                _texts[index].isStatus = val;
                              },
                            );
                          },
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        InkWell(
                          onTap: () {
                            /*Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => QuestionListPage(
                                        title: _texts[index].name,
                                        systemId: _texts[index].id,
                                      )),
                            );*/
                          },
                          child: Text(
                            _texts[index].name,
                            style:
                                Theme.of(context).textTheme.subtitle1!.copyWith(
                                      color: Colors.black,
                                    ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SystemModel {
  int id = 0;
  String name = "";
  int planeId = 0;
  bool isStatus = false;

  SystemModel(int id, int planeId, String name, bool isStatus) {
    this.id = id;
    this.planeId = planeId;
    this.name = name;
    this.isStatus = isStatus;
  }
}
