import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motivational_leadership/services/database.dart';
import 'package:motivational_leadership/ui/coach/coach_feedback_type_selection_page.dart';
import 'package:motivational_leadership/ui/coach/widgets/coach_navigation_drawer.dart';
import 'package:motivational_leadership/utility/base_utils.dart';
import 'package:motivational_leadership/utility/colors.dart';
import 'package:motivational_leadership/utility/utils.dart';
import 'package:motivational_leadership/utility/values.dart';

class CoachHome extends StatefulWidget {
  const CoachHome({Key? key}) : super(key: key);

  @override
  State<CoachHome> createState() => _CoachHomeState();
}

class _CoachHomeState extends State<CoachHome> {
  String selectedStatus = "Feedback Not Given";
  final coachNavigatorKey = GlobalKey<NavigatorState>();
  TextEditingController searchController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  List userSubmissionList = [];
  bool btnSearchClicked = false;
  @override
  Widget build(BuildContext context) {
    log("Coach home build");
    return Scaffold(
        backgroundColor: coachBackgroundColor,
        drawer: const CoachNavigationDrawerWidget(),
        appBar: myAppBar(),
        body: myBody(context));
  }

  @override
  void initState() {
    super.initState();
    titleController.text = selectedStatus;
    setLandscapeOnlyOrientation();
  }

  myBody(BuildContext context) {
    return ListView(
      children: [
        myRow(),
        listView(),
      ],
    );
  }

  myRow() {
    return Container(
      color: Colors.white,
      child: Row(
        children: [
          Expanded(child: txtSearch()),
          searchButton(),
        ],
      ),
    );
  }

  searchButton() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: GestureDetector(
        onTap: () {
          if (searchController.text == "") {
            btnSearchClicked = false;
            Utils.showSnackBar("Name feild is empty");
          } else {
            btnSearchClicked = true;
            // fetchDatabaseList();
            setState(() {});
          }
        },
        child: buttonDesign(),
      ),
    );
  }

  buttonDesign() {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          width: buttonXSmallWidth,
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
              color: buttonColor, borderRadius: BorderRadius.circular(25)),
          child: Text(
            "Search",
            style: TextStyle(fontSize: 16.sp, color: Colors.white),
          ),
        ),
      ],
    );
  }

  txtSearch() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: TextFormField(
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.normal,
          color: Colors.black,
        ),
        controller: searchController,
        decoration: const InputDecoration(
          labelText: "Search Student by First Name",
          hintText: "First Name",
        ),
      ),
    );
  }

  FutureBuilder<List<dynamic>> listView() {
    return FutureBuilder(
        future: fetchDatabaseList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              color: coachBackgroundColor,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return bodyContainer();
        });
  }

  Container bodyContainer() {
    return Container(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: userSubmissionList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
            child: Card(
              color: Colors.white,
              child: GestureDetector(
                child: ListTile(
                    title: FutureBuilder(
                      future: getUserData(index),
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
                        var data = snapshot.data.toString();
                        var splitted = data.split(',');
                        return Row(
                          children: [
                            Expanded(
                              child: Text(
                                splitted[0],
                                style: TextStyle(fontSize: 16.sp),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                splitted[1],
                                style: TextStyle(fontSize: 16.sp),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    onTap: () async {
                      String userId =
                          userSubmissionList.elementAt(index).toString().trim();
                      navigateTo(
                          context: context,
                          nextPage: CoachFeedbackTypeSelection(
                            userID: userId,
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

  AppBar myAppBar() {
    return AppBar(
      title: myTitle(),
      backgroundColor: coachAppBarColor,
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
            return {'Feedback Given', 'Feedback Not Given'}
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

  TextField myTitle() {
    return TextField(
      enabled: false,
      controller: titleController,
      style: TextStyle(fontSize: 16.sp, color: Colors.white),
      decoration: const InputDecoration(
        border: InputBorder.none,
      ),
    );
  }

  void handleClick(String value) {
    switch (value) {
      case 'Feedback Given':
        searchController.text = "";
        btnSearchClicked = false;
        selectedStatus = "Feedback Given";
        titleController.text = "Feedback Given";
        setState(() {});
        break;
      case 'Feedback Not Given':
        searchController.text = "";
        btnSearchClicked = false;
        selectedStatus = "Feedback Not Given";
        titleController.text = "Feedback Not Given";
        setState(() {});
        break;
    }
  }

  Future<List> fetchDatabaseList() async {
    dynamic resultant;
    log("btnSearchClicked = $btnSearchClicked");
    if (btnSearchClicked) {
      resultant =
          await DatabaseService.searchStudentListNyName(searchController.text);
      log("i am here");
    } else {
      log(selectedStatus);
      if (selectedStatus == "Feedback Given") {
        resultant = await DatabaseService.getFeedbackGivenUserList();
      } else {
        resultant = await DatabaseService.getFeedbackNotGivenUserList();
      }
    }
    log("resultant $resultant");

    if (resultant == null) {
      userSubmissionList = [];
    } else {
      userSubmissionList = resultant;
    }
    FlutterNativeSplash.remove();
    return userSubmissionList;
  }

  Future<void> _refresh(BuildContext context) async {
    fetchDatabaseList();
    setState(() {});
  }

  Future getUserData(int index) async {
    String uID = userSubmissionList[index].toString().trim();

    dynamic userName = await DatabaseService.getUserName(uID);
    dynamic userEmail = await DatabaseService.getUserEmail(uID);

    return userName + " , " + userEmail;
  }
}
