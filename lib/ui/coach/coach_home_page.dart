import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motivational_leadership/services/database.dart';
import 'package:motivational_leadership/ui/coach/coach_feedback_type_selection_page.dart';
import 'package:motivational_leadership/ui/coach/widgets/coach_navigation_drawer.dart';
import 'package:motivational_leadership/utility/base_utils.dart';
import 'package:motivational_leadership/utility/colors.dart';
import 'package:motivational_leadership/utility/utils.dart';
import 'package:timezone/data/latest.dart' as tz;

String uid = FirebaseAuth.instance.currentUser!.uid;
String selectedStatus = "Feedback Not Given";
final coachNavigatorKey = GlobalKey<NavigatorState>();
TextEditingController searchController = TextEditingController();

class CoachHome extends StatefulWidget {
  const CoachHome({Key? key}) : super(key: key);

  @override
  State<CoachHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<CoachHome> {
  List userSubmissionList = [];
  bool btnSearchClicked = false;
  @override
  Widget build(BuildContext context) {
    setLandscapeOnlyOrientation();
    return Scaffold(
        backgroundColor: coachBackgroundColor,
        drawer: const CoachNavigationDrawerWidget(),
        appBar: myAppBar(),
        body: myBody(context));
  }

  storeNotificationToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    log("token = $token");
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({'token': token}, SetOptions(merge: true));
  }

  @override
  void initState() {
    super.initState();
    storeNotificationToken();
    tz.initializeTimeZones();
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
          width: 100,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
              color: buttonColor, borderRadius: BorderRadius.circular(25)),
          child: const Text(
            "Search",
            style: TextStyle(fontSize: 16, color: Colors.white),
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
        autofocus: true,
        textInputAction: TextInputAction.next,
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
      title: const Text("Students"),
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

  void handleClick(String value) {
    switch (value) {
      case 'Feedback Given':
        searchController.text = "";
        btnSearchClicked = false;
        selectedStatus = "Feedback Given";
        setState(() {});
        break;
      case 'Feedback Not Given':
        searchController.text = "";
        btnSearchClicked = false;
        selectedStatus = "Feedback Not Given";
        setState(() {});
        break;
    }
  }

  Future<List> fetchDatabaseList() async {
    dynamic resultant;
    log(btnSearchClicked.toString());
    if (btnSearchClicked) {
      resultant =
          await DatabaseService.searchStudentList(searchController.text);
      log("i am here");
    } else {
      if (selectedStatus == "Feedback Given") {
        resultant = await DatabaseService.getFeedbackGivenUserList();
      } else {
        resultant = await DatabaseService.getFeedbackNotGivenUserList();
      }
    }
    log(resultant.toString());

    if (resultant == null) {
      userSubmissionList = [];
    } else {
      userSubmissionList = resultant;
    }

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
