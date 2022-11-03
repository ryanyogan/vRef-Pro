import 'dart:math';

import 'package:flutter/material.dart';
import 'package:third_eye/database_setup/database.dart';
import 'package:third_eye/database_setup/model/question_details.dart';
import 'package:third_eye/drawer/my_drawer.dart';
import 'package:third_eye/question_description/question_descripion.dart';
import 'package:third_eye/question_list_page/question_list_page.dart';
import 'package:third_eye/database_setup/model/plane_categories.dart';
import 'package:third_eye/utils/Animation/FadeAnimation.dart';
import 'package:third_eye/utils/Strings.dart';
import 'package:third_eye/utils/colors.dart';
import 'package:third_eye/utils/constants.dart';
import 'package:third_eye/utils/size_config.dart';
import 'package:third_eye/utils/styling.dart';

class AddQuestion extends StatefulWidget {
  final currentIndex;
  final question;
  final id;
  final answer;
  final image;
  final description;
  final lastIndex;
  final isAddQuestion;
  final title;
  final systemId;
  final systemListId;
  final systemTitle;
  final planeId;

  const AddQuestion(
      {Key? key,
        this.currentIndex,
        this.question,
        this.lastIndex,
        this.isAddQuestion,
        this.answer,
        this.description,
        this.id,
        this.image,
        this.title,
        this.systemId,
        this.systemListId,
        this.systemTitle,
        this.planeId})
      : super(key: key);

  @override
  _AddQuestionState createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var _question;
  var _answer;
  List<String> image = [];
  var _description = "";
  var _currentIndex;
  bool isLoading = false;
  TextEditingController questionCon = new TextEditingController();
  TextEditingController answerCon = new TextEditingController();
  TextEditingController descriptionCon = new TextEditingController();

  int line = 6;
  List<QuestionDetails> questionDetails = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.question != null) {
      questionCon = new TextEditingController(text: widget.question);
      answerCon = new TextEditingController(text: widget.answer);
      descriptionCon = new TextEditingController(text: widget.description);
    }
    if(widget.currentIndex != null){
      print("widget.currentIndex ${widget.currentIndex}");
      _currentIndex = widget.currentIndex;

    }
    print("Description ${widget.description}");
    print("Image ${widget.image}");
    _getCategoriesLength();
  }


  // _getReferse() {
  //   DBProvider.db.getAllQuestions(widget.systemId).then((value) {
  //     setState(() {
  //       if (widget.description != null)
  //         _description= widget.description;
  //     });
  //     _description = widget.description;
  //     _answer=widget.answer;
  //     _question=widget.question;
  //     //_currentIndex = widget.currentIndex;
  //     print("questionDetails1222=====");
  //     print(_description);
  //   });
  // }

  _getCategoriesLength() {
    DBProvider.db.getAllQuestions(widget.systemId).then((value) {
      setState(() {
        questionDetails.addAll(value);
        if (widget.description != null)
          _description = widget.description;
        if (widget.image != null) {
          image = widget.image;
          print("Image length ${image.length}");
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => QuestionListPage(
        //             systemListName: widget.title,
        //             systemListId: widget.systemListId,
        //             systemTitle: widget.systemTitle,
        //             planeId: widget.planeId,
        //           )),
        // );
        // _getReferse();
        Navigator.of(context).pop();


        return false;
      },
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          backgroundColor: Color(0xFFEBF2F8),
          drawer: MaterialDrawer.defaulter(currentPage: Strings.system),
          bottomNavigationBar: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
                horizontal: 9 * SizeConfig.widthMultiplier,
                vertical: 2 * SizeConfig.heightMultiplier),
            child: FadeAnimation(
              2,
              isLoading
                  ? Center(
                child: CircularProgressIndicator(),
              )
                  : Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () async {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }
                      _formKey.currentState!.save();
                      if (!widget.isAddQuestion) {
                        print("Question Id ${widget.id}");
                        print("Question Id ${widget.systemId}");
                        await DBProvider.db.updateClient(
                          _question,
                          _answer,
                          _description,
                          widget.id,
                        );
                        if (image.length > 0) {
                          DBProvider.db
                              .deleteClientQuestionImage(widget.id);
                          for (var i = 0; i < image.length; i++) {
                            var im = image[i];
                            print("image====");
                            print(im);
                            await DBProvider.db.addImage(
                              ImageModel(
                                  image: im, question_id: widget.id),
                            );
                          }
                        }
                      } else {
                        String description = "";
                        if (widget.description == null) {
                          description = " ";
                        } else {
                          description = widget.description;
                        }
                        print("System Id ${widget.systemId}");
                        Random random = new Random();
                        int randomNumber = random.nextInt(100);
                        int id = await DBProvider.db.newClient(
                          QuestionDetails(
                              question: _question,
                              answer: _answer,
                              description: description,
                              systemId: widget.systemId),
                        );
                        print("id");
                        print(id);
                        if (image.length > 0) {
                          for (var i = 0; i < image.length; i++) {
                            var im = image[i];
                            print("image====");
                            print(im);
                            await DBProvider.db.addImage(
                              ImageModel(image: im, question_id: id),
                            );
                          }
                        }
                      }
                      // _getReferse();
                      print("currentIndex ${_currentIndex}");
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => QuestionListPage(
                                  systemListName: widget.title,
                                  systemListId: widget.systemListId,
                                  systemTitle: widget.systemTitle,
                                  planeId: widget.planeId,
                                  currentInd: _currentIndex
                                ), ),
                      );



                    },
                    child: Container(

                      height: 65,
                      width: 65,
                      decoration: BoxDecoration(
                          color: Colors.green, shape: BoxShape.circle),
                      child:
                      Icon(Icons.done, color: Colors.white, size: 40),

                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                       if (!_formKey.currentState!.validate()) {
                          return;
                        }
                        _formKey.currentState!.save();

                       Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => QuestionDescription(
                                  systemListName: widget.title,
                                  systemId: widget.systemId,
                                  question: _question,
                                  answer: _answer,
                                  isVisible: true,
                                  currentIndex: _currentIndex,
                                  description: _description,
                                  isAddQuestion: widget.isAddQuestion,
                                  id: widget.id,
                                  systemListId: widget.systemListId,
                                  systemTitle: widget.systemTitle,
                                  planeId: widget.planeId)),
                        );

                      },
                      child: Container(
                        height: 65,
                        width: 65,
                        decoration: BoxDecoration(
                            color: Colors.orangeAccent,
                            shape: BoxShape.circle),
                        child: Icon(Icons.help_outlined,
                            color: Colors.white, size: 40
                        ),

                      ),

                    ),
                  ),
                  Container(
                    height: 65,
                    width: 65,
                    decoration: BoxDecoration(
                        color: Colors.red, shape: BoxShape.circle),
                    child: IconButton(
                      icon: Icon(Icons.close,
                          color: Colors.white, size: 40),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          appBar: AppBar(
            title: Text(
              !widget.isAddQuestion ? "UPDATE QUESTION" : "ADD NEW QUESTION",
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: MyColor.white),
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
                              Container(
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    Container(
                                      child: Image.asset(
                                        "assets/images/ic_appicon.png",
                                        width:
                                        MediaQuery.of(context).size.width,
                                        fit: BoxFit.contain,
                                        height: Constants.imageSize,
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                "${widget.systemTitle}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline6!
                                                    .copyWith(
                                                    color:
                                                    MyColor.textColor),
                                                textAlign: TextAlign.start,
                                              ),
                                              flex: 1,
                                            ),
                                            Expanded(
                                              child: Text(
                                                "${_currentIndex +  1}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline6!
                                                    .copyWith(
                                                    color:
                                                    MyColor.textColor),
                                                textAlign: TextAlign.end,
                                              ),
                                              flex: 1,
                                            ),
                                          ],
                                        ),
                                      ),
                                      flex: 0,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: SizeConfig.heightMultiplier * 2,
                              ),
                              Card(
                                color: MyColor.bg_que,
                                elevation: Constants.cardElevation,
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: new TextFormField(
                                    maxLines: line,
                                    keyboardType: TextInputType.multiline,
                                    textInputAction: TextInputAction.newline,
                                    textCapitalization:
                                    TextCapitalization.characters,
                                    controller: questionCon,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(left: 1),
                                      labelText: 'ENTER QUESTION',
                                      labelStyle:
                                      TextStyle(color: MyColor.textColor),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: MyColor.textColor),
                                        //  when the TextFormField in unfocused
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: MyColor.textColor),
                                        //  when the TextFormField in focused
                                      ),
                                      border: UnderlineInputBorder(),
                                    ),
                                    // decoration: inputDecorationRequestTitle,
                                    cursorColor: AppTheme.cursorColor,
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1!
                                        .copyWith(
                                        color: MyColor.textColor,
                                        fontSize: SizeConfig.webAppBarSize),
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'Question is required';
                                      }
                                      return null;
                                    },
                                    onSaved: (String? value) {
                                      _question = value;
                                    },
                                  ),
                                ),
                              ),
                              Card(
                                color: MyColor.bg_ans,
                                elevation: Constants.cardElevation,
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: new TextFormField(
                                    maxLines: line,
                                    keyboardType: TextInputType.multiline,
                                    textInputAction: TextInputAction.newline,
                                    controller: answerCon,
                                    textCapitalization:
                                    TextCapitalization.characters,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(left: 1),
                                      labelText: 'ENTER ANSWER',
                                      labelStyle:
                                      TextStyle(color: MyColor.textColor),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: MyColor.textColor),
                                        //  when the TextFormField in unfocused
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: MyColor.textColor),
                                        //  when the TextFormField in focused
                                      ),
                                      border: UnderlineInputBorder(),
                                    ),
                                    //decoration: inputDecorationRequestMessage,
                                    cursorColor: AppTheme.cursorColor,
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1!
                                        .copyWith(
                                        color: MyColor.textColor,
                                        fontSize: SizeConfig.webAppBarSize),
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'Answer is required';
                                      }
                                      return null;
                                    },
                                    onSaved: (String? value) {
                                      _answer = value;
                                    },
                                  ),
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

