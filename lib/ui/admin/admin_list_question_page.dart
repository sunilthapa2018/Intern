import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motivational_leadership/services/database.dart';
import 'package:motivational_leadership/ui/admin/admin_edit_question_page.dart';
import 'package:motivational_leadership/ui/common/widget/verticle_spacer.dart';
import 'package:motivational_leadership/utility/base_utils.dart';
import 'package:motivational_leadership/utility/colors.dart';

class AdminListQuestion extends StatefulWidget {
  const AdminListQuestion({Key? key}) : super(key: key);

  @override
  State<AdminListQuestion> createState() => _AdminListQuestionState();
}

class _AdminListQuestionState extends State<AdminListQuestion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(),
      body: myBody(context),
      backgroundColor: adminBackgroundColor,
    );
  }

  List questionList = [];
  String selectedMenu = "All";

  AppBar myAppBar() {
    return AppBar(
      title: const Text("Edit Question"),
      backgroundColor: adminAppBarColor,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      actions: [
        IconButton(
            onPressed: () {
              _refresh(context);
            },
            icon: const Icon(Icons.refresh)),
        PopupMenuButton<String>(
          icon: const Icon(Icons.sort),
          onSelected: handleClick,
          itemBuilder: (BuildContext context) {
            return {'All', 'Autonomy', 'Belonging', 'Competence'}
                .map((String choice) {
              return PopupMenuItem<String>(
                value: choice,
                child: Text(choice),
              );
            }).toList();
          },
        ),
      ],
    );
  }

  FutureBuilder myBody(BuildContext context) {
    return FutureBuilder(
        future: fetchDatabaseList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              color: adminBackgroundColor,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return bodyContainer();
        });
  }

  Container bodyContainer() {
    log(questionList.length.toString());
    return Container(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: questionList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
            child: Card(
              color: Colors.white,
              child: GestureDetector(
                child: ListTile(
                    title: FutureBuilder(
                      future: getQuestionString(index),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Text(
                            "Loading...",
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.black,
                            ),
                          );
                        }
                        if (snapshot.data == null) {}
                        String val = snapshot.data.toString();
                        List<String> arr = val.split('*');
                        String question = arr[0].toString();
                        String type = arr[1].toString();
                        String subType = arr[2].toString();
                        return Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                question,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            verticleSpacer(10),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Type = $type",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Sub Type = $subType",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    onTap: () async {
                      String questionId =
                          questionList.elementAt(index).toString().trim();
                      navigateTo(
                          context: context,
                          nextPage: EditQuestion(
                            questionId: questionId,
                          ),
                          currentPage: widget);
                    }),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<List> fetchDatabaseList() async {
    log(selectedMenu);
    dynamic resultant;
    if (selectedMenu == "All") {
      resultant = await DatabaseService.getAllQuestionList();
    } else {
      resultant = await DatabaseService.getQuestionListByType(selectedMenu);
    }

    if (resultant == null) {
      questionList = [];
      return questionList;
    } else {
      questionList = resultant;
      return questionList;
    }
  }

  Future getQuestionString(int index) async {
    String uID = questionList[index].toString().trim();
    dynamic question = await DatabaseService.getQuestion(uID);
    return question;
  }

  Future<void> _refresh(BuildContext context) async {
    fetchDatabaseList();
    setState(() {});
  }

  void handleClick(String value) {
    switch (value) {
      case 'All':
        selectedMenu = "All";
        fetchDatabaseList();
        setState(() {});
        break;
      case 'Autonomy':
        selectedMenu = "Autonomy";
        fetchDatabaseList();
        setState(() {});
        break;
      case 'Belonging':
        selectedMenu = "Belonging";
        fetchDatabaseList();
        setState(() {});
        break;
      case 'Competence':
        selectedMenu = "Competence";
        fetchDatabaseList();
        setState(() {});
        break;
    }
  }
}
