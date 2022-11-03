import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:third_eye/add_question/add_question.dart';
import 'package:third_eye/database_setup/database.dart';
import 'package:image_picker/image_picker.dart';
import 'package:third_eye/database_setup/model/question_details.dart';
import 'package:third_eye/database_setup/model/plane_categories.dart';
import 'package:third_eye/drawer/my_drawer.dart';
import 'package:third_eye/question_list_page/question_list_page.dart';
import 'package:third_eye/utils/Animation/FadeAnimation.dart';
import 'package:third_eye/utils/Strings.dart';
import 'package:third_eye/utils/colors.dart';
import 'package:third_eye/utils/constants.dart';
import 'package:third_eye/utils/size_config.dart';
import 'package:third_eye/utils/styling.dart';

class QuestionDescription extends StatefulWidget {
  final systemListName;
  final systemId;
  final description;
  final question;
  final answer;
  final isVisible;
  final currentIndex;
  final isAddQuestion;
  final id;
  final systemListId;
  final systemTitle;
  final planeId;
  final image;
  final showonly;

  const QuestionDescription(
      {Key? key,
        this.systemListName,
        this.systemId,
        this.description,
        this.question,
        this.answer,
        this.isVisible,
        this.id,
        this.isAddQuestion,
        this.currentIndex,
        this.systemListId,
        this.systemTitle,
        this.planeId,
        this.image,
        this.showonly})
      : super(key: key);

  @override
  _QuestionDescriptionState createState() => _QuestionDescriptionState();
}

class _QuestionDescriptionState extends State<QuestionDescription> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var _description;
  var _image;
  bool isLoading = false;
  List<String> getImageList = [];
  List<int> getIdList = [];
  List<int> getQuestionIdList = [];
  TextEditingController descriptionCon = new TextEditingController();
  var _de;

  final ImagePicker _picker = ImagePicker();

  int line = 6;
  XFile? imageFile;
  List<QuestionDetails> questionDetails = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getImageList.clear();
    getIdList.clear();
    getQuestionIdList.clear();
    print(widget.description);
    if (widget.description != null) {
      print("qwerttyyui");
      print(widget.description);
      if(widget.description == "0"){
        descriptionCon = new TextEditingController(text:"");
      }
      else{
        descriptionCon = new TextEditingController(text: widget.description);
      }
    }

    print("id");
    print(widget.id);
    _getCategoriesLength();
    if (widget.id != null) {
      _getImages();
    }
  }

  _getdesciption() {
    DBProvider.db.getDescription(widget.id).then((value) {
      for (var getV in value) {
        _description =getV['description'];
      }
      print("dgfhfhf");
      print(_description);
      descriptionCon = new TextEditingController(text:_description);
      setState(() {});
    });
  }

  _getImages() {
    DBProvider.db.getAllImages().then((value) {
      for (var getV in value) {
        if (getV['question_id'] == widget.id) {
          getImageList.add(getV['image']);
          getIdList.add(getV['id']);
          getQuestionIdList.add(getV['question_id']);
        }
      }
      setState(() {});
    });
    print("get image list");
    print(getImageList);
    print("get id list");
    print(getIdList);
    print("get questionId list");
    print(getQuestionIdList);
  }

  getImages(var value) async {
    if (value == 0) {
      print("caid");
      print(widget.id);
      final XFile? selectedImage =
      await _picker.pickImage(source: ImageSource.camera);
      if (selectedImage!.path.isNotEmpty && widget.id == null) {
        //getImageList.add(selectedImage.path);
      }

      setState(() {
        getImageList.add(selectedImage.path);
      });
      print("imageFileList");
      print(getImageList);
    } else {
      print("gaid");
      print(widget.id);
      final XFile? selectedImage =
      await _picker.pickImage(source: ImageSource.gallery);
      if (selectedImage!.path.isNotEmpty && widget.id == null) {
        //getImageList.add(selectedImage.path);
      }
      setState(() {
        getImageList.add(selectedImage.path);
      });
      print("imageFileList");
      print(getImageList);
    }
  }

  _getCategoriesLength() {
    DBProvider.db.getAllQuestions(widget.systemId).then((value) {
      setState(() {
        questionDetails.addAll(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (imageFile != null) {
      print(imageFile!.path);
    }

    return WillPopScope(
      onWillPop: () async {
        if (widget.isVisible)
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => AddQuestion(
                    currentIndex: widget.currentIndex,
                    title: widget.systemListName,
                    systemTitle: widget.systemTitle,
                    systemId: widget.systemId,
                    description: _description,
                    image: getImageList != null ? getImageList : "",
                    question: widget.question,
                    answer: widget.answer,
                    isAddQuestion: widget.isAddQuestion,
                    id: widget.id,
                    systemListId: widget.systemListId,
                    planeId: widget.planeId)),
          );
        else
          Navigator.of(context).pop();
        return false;
      },
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          drawer: MaterialDrawer.defaulter(currentPage: Strings.system),
          appBar: AppBar(
            title: Text(
              widget.isVisible ? "ADD DESCRIPTION" : "DESCRIPTION",
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
                      if (widget.isVisible)
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddQuestion(
                                  currentIndex: widget.currentIndex,
                                  title: widget.systemListName,
                                  systemTitle: widget.systemTitle,
                                  systemId: widget.systemId,
                                  description: _description,
                                  question: widget.question,
                                  answer: widget.answer,
                                  isAddQuestion: widget.isAddQuestion,
                                  id: widget.id,
                                  image: getImageList,
                                  systemListId: widget.systemListId,
                                  planeId: widget.planeId)),
                        );
                      else
                        Navigator.of(context).pop();
                    },
                    child: Container(
                      child: Text(
                        "BACK",
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            color: MyColor.primary),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: widget.isVisible,
                    child: InkWell(
                      onTap: () {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }
                        _formKey.currentState!.save();
                        print("imageFileList");
                        print(getImageList);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddQuestion(
                                  currentIndex: widget.currentIndex,
                                  title: widget.systemListName,
                                  systemTitle: widget.systemTitle,
                                  systemId: widget.systemId,
                                  description: _description,
                                  question: widget.question,
                                  answer: widget.answer,
                                  image: getImageList,
                                  isAddQuestion: widget.isAddQuestion,
                                  id: widget.id,
                                  systemListId: widget.systemListId,
                                  planeId: widget.planeId)),
                        );
                      },
                      child: Container(
                        child: Text(
                          "SAVE",
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              color: MyColor.primary),
                        ),
                      ),
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
                                                "${widget.currentIndex + 1}",
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
                                color: MyColor.bg_description,
                                elevation: Constants.cardElevation,
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: new TextFormField(
                                    readOnly: (widget.showonly == "showonly") ? true :false,
                                    maxLines: line,
                                    keyboardType: TextInputType.multiline,
                                    textInputAction: TextInputAction.newline,
                                    controller: descriptionCon,
                                    textCapitalization:
                                    TextCapitalization.characters,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(left: 1),
                                      labelText: 'ENTER DESCRIPTION',
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
                                    onSaved: (String? value) {
                                      _description = value;
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 4.0 * SizeConfig.heightMultiplier,
                              ),
                              Container(
                                  child: widget.isVisible
                                      ? Container(
                                    margin: const EdgeInsets.only(
                                        bottom: 20.0),
                                    child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          GestureDetector(
                                            onTap: () => getImages(1),
                                            child: Container(
                                                padding:
                                                EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  color: MyColor.primary,
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(3),
                                                  border: Border.all(
                                                      color:
                                                      Colors.black),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                      "From Gallery",
                                                      style: TextStyle(
                                                          color: Colors
                                                              .white,
                                                          fontSize: 18,
                                                          fontWeight:
                                                          FontWeight
                                                              .bold)),
                                                )),
                                          ),
                                          GestureDetector(
                                            onTap: () => getImages(0),
                                            child: Container(
                                                padding:
                                                EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  //borderRadius: BorderRadius.circular(10),
                                                    color:
                                                    MyColor.primary,
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(3),
                                                    border: Border.all(
                                                        color: Colors
                                                            .black)),
                                                child: Center(
                                                  child: Text(
                                                      "From Camera",
                                                      style: TextStyle(
                                                          color: Colors
                                                              .white,
                                                          fontSize: 18,
                                                          fontWeight:
                                                          FontWeight
                                                              .bold)),
                                                )),
                                          )
                                        ]),
                                  )
                                      : Container()),
                              getImageList.isNotEmpty
                                  ?
                          Container(
                          height: 300,
                          //width: 300,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex:1,
                                // flex:14,
                                child: ListView.builder(
                                  //shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        child: Stack(
                                          children: [
                                            Container(
                                              child:
                                              Card(
                                                  child:
                                                  GestureDetector(
                                                      child:getImageList[index].startsWith('assets/')
                                                          ?
                                                      Image.asset(
                                                        getImageList[index],
                                                        fit: BoxFit.fill,
                                                      )
                                                          :
                                                      Image.file(
                                                        File(getImageList[
                                                        index]),
                                                        fit: BoxFit.fill,
                                                      )
                                                  )
                                              ),
                                            ),
                                            Visibility(
                                              visible: widget.isVisible,
                                              child: Positioned(
                                                  right: 5,
                                                  top: 5,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      showDialog(
                                                        builder: (context){
                                                          return AlertDialog(
                                                            actions: [
                                                              GestureDetector(
                                                                onTap:(){
                                                                  setState(() {
                                                                    DBProvider.db
                                                                        .deleteImage(
                                                                        getImageList[
                                                                        index]);
                                                                    getImageList.removeAt(index);
                                                                  });
                                                                  Navigator.of(context).pop();
                                                                },
                                                                child:
                                                                Container(
                                                                    padding:EdgeInsets.all(8),
                                                                    decoration:BoxDecoration(
                                                                        borderRadius: BorderRadius.circular(3),
                                                                        border: Border.all(color:Colors.black)
                                                                    ),
                                                                    child:
                                                                    Text("Yes",
                                                                        style:Theme.of(context).primaryTextTheme.bodyText1!.copyWith(color: Colors.black,
                                                                            fontSize: 20,
                                                                            fontWeight: FontWeight.bold
                                                                        ))
                                                                ),
                                                                //child: Text("Yes",style:Theme.of(context).primaryTextTheme.bodyText1!.copyWith(color: Colors.black,)),
                                                              ),
                                                              SizedBox(
                                                                width: 19.0 * SizeConfig.heightMultiplier,
                                                              ),
                                                              GestureDetector(
                                                                  onTap: (){
                                                                    Navigator.of(context).pop();
                                                                  },
                                                                  child:
                                                                  Container(
                                                                    padding:EdgeInsets.all(8),
                                                                    decoration:BoxDecoration(
                                                                        borderRadius: BorderRadius.circular(3),
                                                                        border: Border.all(color:Colors.black)
                                                                    ),
                                                                    child: Text(" No ",style:Theme.of(context).primaryTextTheme.bodyText1!.copyWith(color: Colors.black,
                                                                        fontSize: 20,
                                                                        fontWeight: FontWeight.bold
                                                                    )),
                                                                  )
                                                                //child: Text("No",style:Theme.of(context).primaryTextTheme.bodyText1!.copyWith(color: Colors.black,)),
                                                              )
                                                            ],
                                                            content: Text("Are you sure want to delete image?",style:Theme.of(context).primaryTextTheme.headline6!.copyWith(color: Colors.black,)),
                                                          );
                                                        },
                                                        context: context,
                                                      );

                                                    },
                                                    child: CircleAvatar(
                                                        radius: 15,
                                                        backgroundColor: Colors.redAccent,
                                                        child: Icon(
                                                          Icons.delete,
                                                          size: 20,
                                                          color: Colors
                                                              .black,
                                                        )),
                                                  )),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    itemCount: getImageList.length),
                              )
                            ],
                          ),
                        )

                        : Container(),
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

