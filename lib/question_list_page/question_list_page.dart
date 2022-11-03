 import 'package:carousel_slider/carousel_slider.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:third_eye/add_question/add_question.dart';
import 'package:third_eye/costum_dialog/CustomDialog.dart';
import 'package:third_eye/database_setup/database.dart';
import 'package:third_eye/database_setup/model/question_details.dart';
import 'package:third_eye/drawer/my_drawer.dart';
import 'package:third_eye/question_description/question_descripion.dart';
import 'package:third_eye/system_list/system_list.dart';
import 'package:third_eye/tinder_swipe_card/tinder_swipe_card.dart';
import 'package:third_eye/utils/Strings.dart';
import 'package:third_eye/utils/colors.dart';
import 'package:third_eye/utils/constants.dart';
import 'package:third_eye/utils/size_config.dart';

List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

class QuestionListPage extends StatefulWidget {
  List<String> systemListName;
  final systemTitle;
  List<int> systemListId;
  final planeId;
  int currentInd;

  QuestionListPage({
    required this.systemListName,
    required this.planeId,
    required this.systemListId,
    this.systemTitle,
    required this.currentInd,

  });

  @override
  _QuestionListPageState createState() => _QuestionListPageState();
}

class _QuestionListPageState extends State<QuestionListPage>
    with AutomaticKeepAliveClientMixin {
  bool isActive = false;
  int currentIndex = 0;
  final CarouselController _controller = CarouselController();
  int totalQuestion = 0;
  CardController controller = CardController();
  int catIndex = 0;
  int prevSysId = -1;
  int currentIndexTemp = 0;
  Map map = new Map();
  Map mapSystemName = new Map();
  List<QuestionDetails> questionDetails = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //print("currentIndex ${ widget.currentInd}");
    //currentIndex = widget.currentInd;
    if(widget.currentInd != null) {
      currentIndex = widget.currentInd;
      currentIndexTemp = currentIndex;
      print("in ques widget.currentInd ${currentIndex}");
    }
    for (int i = 0; i < widget.systemListId.length; i++) {
      DBProvider.db.getAllQuestions(widget.systemListId[i]).then((value) async {
        if (value.length > 0) {
          setState(() {
            questionDetails.addAll(value);
            var threeValue =
                map.putIfAbsent(widget.systemListId[i], () => value.length);

            mapSystemName.putIfAbsent(
                widget.systemListId[i], () => widget.systemListName[i]);

            print("Map index ${map[2]}");
            if (i == 0) prevSysId = questionDetails[0].systemId;
          });
        }
      });
    }
    for (int j = 0; j < widget.systemListName.length; j++) {
      print("Length index ${map}");
    }
  }

  @override
  Widget build(BuildContext context) {
    double cardHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => SystemList(
                    planeId: widget.planeId,
                  )),
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        drawer: MaterialDrawer.addquestion(
          currentPage: Strings.system,
          isAddQueToDisplay: true,
          title: widget.systemListName.toString(),
        ),
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Q & A",
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: MyColor.white),
              ),
              PopupMenuButton(
                  color: MyColor.white,
                  elevation: 20,
                  enabled: true,
                  onCanceled: () {
                    //do something
                  },
                  onSelected: (value) async {
                    print("value:$value");
                    print("length:$questionDetails.length");

                    if (value == "Add") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddQuestion(
                            //currentIndex:questionDetails.length,
                            currentIndex:   questionDetails.isNotEmpty &&
                                questionDetails[currentIndex].id != null &&
                                questionDetails[currentIndex].id > 0
                                ? questionDetails.length
                                : 0,
                            lastIndex: questionDetails.length,
                            isAddQuestion: true,
                            title: widget.systemListName,
                            systemId: questionDetails.length == 0
                                ? widget.systemListId[0]
                                : questionDetails[currentIndex].systemId,
                            systemListId: widget.systemListId,
                            planeId: widget.planeId,
                            systemTitle: mapSystemName[
                                questionDetails[currentIndex].systemId],
                          ),
                        ),
                      );
                    } else if (value == "Edit") {
                      print("Question Id ${questionDetails[currentIndex].id}");
                      var result= await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddQuestion(
                                  currentIndex: currentIndex,
                                  id: questionDetails[currentIndex].id,
                                  question:
                                      questionDetails[currentIndex].question,
                                  answer: questionDetails[currentIndex].answer,
                                  description:
                                      questionDetails[currentIndex].description,
                                  lastIndex: questionDetails.length,
                                  isAddQuestion: false,
                                  title: widget.systemListName,
                                  systemId:
                                      questionDetails[currentIndex].systemId,
                                  systemListId: widget.systemListId,
                                  planeId: widget.planeId,
                                  systemTitle: mapSystemName[
                                      questionDetails[currentIndex].systemId],
                                )),
                      );
                      print("result");
                      print(result);
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => CustomDialog(
                          child: dialogContent(
                              context, questionDetails[currentIndex].id),
                        ),
                        barrierDismissible: false,
                      );
                    }
                  },
                  itemBuilder: (context) =>
                      questionDetails[currentIndex].id != null &&
                              questionDetails[currentIndex].id > 0
                          ? [
                              PopupMenuItem(
                                child: Text("Add"),
                                value: "Add",
                              ),
                              PopupMenuItem(
                                child: Text("Edit"),
                                value: "Edit",
                              ),
                              PopupMenuItem(
                                child: Text("Delete"),
                                value: "Delete",
                              ),
                            ]
                          : [
                              PopupMenuItem(
                                child: Text("Add"),
                                value: "Add",
                              ),
                            ])
            ],
          ),
        ),
        bottomNavigationBar: SingleChildScrollView(
          child: BottomAppBar(
            child: Stack(
              children: [
                InkWell(
                  onTap: () async {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SystemList(
                                planeId: widget.planeId,
                              )),
                    );
                  },
                  child: Container(
                    alignment: Alignment.bottomLeft,
                    height: 60,
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      "BACK",
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          color: MyColor.primary),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(8.0),
                  child: questionDetails.isNotEmpty &&
                          questionDetails[currentIndex].id != null &&
                          questionDetails[currentIndex].id > 0
                      ? InkWell(
                          onTap: () {
                            setState(() {
                              if (questionDetails.length > 0) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => QuestionDescription(
                                            systemListName:
                                                widget.systemListName,
                                            systemTitle: mapSystemName[
                                                questionDetails[currentIndex]
                                                    .systemId],
                                            systemId:
                                                questionDetails[currentIndex]
                                                    .systemId,
                                            planeId: widget.planeId,
                                            id: questionDetails[currentIndex]
                                                .id,
                                            description:
                                                questionDetails[currentIndex]
                                                    .description,
                                            systemListId: widget.systemListId,
                                            isVisible: false,
                                            isAddQuestion: true,
                                            showonly:"showonly",
                                            currentIndex: (currentIndex),
                                          )),
                                );
                              } else {
                                Constants.toast("Question not found");
                              }
                            });
                          },
                          child: Container(
                            height: 65,
                            width: 65,
                            decoration: BoxDecoration(
                                color: Colors.orangeAccent,
                                shape: BoxShape.circle),
                            child: Icon(Icons.help_outlined,
                                color: Colors.white, size: 40),
                          ),
                        )
                      : Container(
                          height: 65,
                          width: 65,
                        ),
                ),
              ],
            ),
          ),
        ),
        body: Container(
          color: Colors.white,
          child: Column(
            children: [
              Expanded(
                flex: 0,
                child: SizedBox(
                  height: 8.0,
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: Image.asset(
                    "assets/images/ic_appicon.png",
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.contain,
                    height: Constants.imageSize,
                  ),
                ),
                flex: 0,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Text(
                          mapSystemName.isNotEmpty
                              ? "${mapSystemName[questionDetails[currentIndex].systemId]}"
                              : "",
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(color: MyColor.textColor),
                          textAlign: TextAlign.start,
                        ),
                        flex: 1,
                      ),
                      Expanded(
                        child: map != null &&
                                map.isNotEmpty &&
                                questionDetails[currentIndex].id != null &&
                                questionDetails[currentIndex].id > 0
                            ? Text(
                                "${currentIndexTemp + 1} OF ${map[questionDetails[currentIndex].systemId]}",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(color: MyColor.textColor),
                                textAlign: TextAlign.end,
                              )
                            : Text(
                                "0 OF 0",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(color: MyColor.textColor),
                                textAlign: TextAlign.end,
                              ),
                        flex: 1,
                      ),
                    ],
                  ),
                ),
                flex: 0,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    child: Text(
                      questionDetails.isNotEmpty &&
                              questionDetails[currentIndex].id != null &&
                              questionDetails[currentIndex].id > 0
                          ? "Q:${currentIndex + 1}"
                          : "Q:0",
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(color: MyColor.textColor),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
                flex: 0,
              ),
              Expanded(
                flex: 1,
                child: Container(
                  child: CarouselSlider(
                    items: questionDetails.map((item) {
                      return Container(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(15.0, 0, 15.0, 0),
                          child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    width: cardHeight,
                                    height: cardHeight,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color: MyColor.primary),
                                    child: FlipCard(
                                      direction: FlipDirection.VERTICAL,
                                      // default
                                      front: Center(
                                        child: Container(
                                          width: cardHeight,
                                          height: cardHeight,
                                          alignment: Alignment.center,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              item.question,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6!
                                                  .copyWith(
                                                      color: MyColor.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                      back: Center(
                                        child: Container(
                                          width: cardHeight,
                                          height: cardHeight,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                              color: MyColor.bg_description),
                                          alignment: Alignment.center,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(item.answer,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline6!
                                                    .copyWith(
                                                        color:
                                                            MyColor.textColor)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      );
                    }).toList(),
                    options: CarouselOptions(
//                    aspectRatio:1.08,
                      aspectRatio: 1.08,
                      enlargeCenterPage: false,
                      enableInfiniteScroll: false,
                      viewportFraction: 1,
                      initialPage: currentIndex,
                      onPageChanged: (index, reason) {
                        print("reason ${reason}");
                        if(reason == CarouselPageChangedReason.manual){
                        setState(() {
                          if (index > currentIndex) {
                            if (prevSysId == questionDetails[index].systemId) {
                              currentIndexTemp++;
                            } else {
                              currentIndexTemp = 0;
                            }
                          } else if (index < currentIndex) {
                            if (prevSysId == questionDetails[index].systemId) {
                              currentIndexTemp--;
                            } else {
                              currentIndexTemp =
                                  map[questionDetails[index].systemId] - 1;
                            }
                          }

                          prevSysId = questionDetails[index].systemId;
                          print("Index $index");
                          print("Question Id ${questionDetails[index].id}");

                          currentIndex = index;
                        });
                        }
                        else if(reason == CarouselPageChangedReason.controller){
                          setState(() {
                            //index = index + 2;
                            prevSysId = questionDetails[currentIndex].systemId;
                            currentIndexTemp = currentIndex;
                            //index = currentIndex;
                            _controller.jumpToPage(currentIndex);
                            print("currentIndex $currentIndex");
                            print("Index $index");
                            print("Question Id ${questionDetails[currentIndex].id}");
                          });
                        }
                      },
                    ),
                    carouselController: _controller,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget dialogContent(BuildContext context, int questionId) {
    return Container(
      margin: EdgeInsets.only(left: 0.0, right: 0.0),
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              top: 0.0,
            ),
            margin: EdgeInsets.only(top: 13.0, right: 8.0),
            decoration: BoxDecoration(
                color: MyColor.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: MyColor.white,
                    blurRadius: 0.0,
                    offset: Offset(0.0, 0.0),
                  ),
                ]),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(
                    16,
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: new Text(
                          Strings.are_you_sure_you_want_to_delete,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(
                                  letterSpacing: 1,
                                  fontSize: SizeConfig.webAppBarSize),
                        ),
                      ),
                      SizedBox(
                        height: 2 * SizeConfig.heightMultiplier,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "No",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(fontSize: SizeConfig.webAppBarSize),
                            ),
                          ),
                          SizedBox(
                            width: 8 * SizeConfig.widthMultiplier,
                          ),
                          InkWell(
                            onTap: () {
                              print("Question id : $questionId");
                              DBProvider.db.deleteClient(questionId);
                              DBProvider.db
                                  .deleteClientQuestionImage(questionId);
                              setState(() {
                                DBProvider.db
                                    .getAllQuestions(
                                        questionDetails[currentIndex].systemId)
                                    .then((value) {
                                  setState(() {
                                    questionDetails.addAll(value);
                                  });
                                });
                              });
                              Navigator.pop(context);
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => QuestionListPage(
                                          systemListName: widget.systemListName,
                                          systemListId: widget.systemListId,
                                          systemTitle: mapSystemName[
                                              questionDetails[currentIndex]
                                                  .systemId],
                                          planeId: widget.planeId,
                                        currentInd: 0 ,
                                        )),
                              );
                            },
                            child: Text(
                              "Yes",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(fontSize: SizeConfig.webAppBarSize),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 1 * SizeConfig.widthMultiplier,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 0.0,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Align(
                alignment: Alignment.topRight,
                child: CircleAvatar(
                  radius: 14.0,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.close, color: Colors.red),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
