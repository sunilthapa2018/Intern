import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motivational_leadership/services/database.dart';
import 'package:motivational_leadership/services/notification_service_one_signal.dart';
import 'package:motivational_leadership/ui/coach/coach_feedback_type_selection_page.dart';
import 'package:motivational_leadership/ui/coach/widgets/coach_navigation_drawer.dart';
import 'package:motivational_leadership/utility/base_utils.dart';
import 'package:motivational_leadership/utility/colors.dart';
import 'package:timezone/data/latest.dart' as tz;

String uid = FirebaseAuth.instance.currentUser!.uid;
String selectedStatus = "Feedback Not Given";
final coachNavigatorKey = GlobalKey<NavigatorState>();

class CoachHome extends StatefulWidget {
  const CoachHome({Key? key}) : super(key: key);

  @override
  State<CoachHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<CoachHome> {
  List userSubmissionList = [];
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
    // tz.initializeTimezones();
  }

  FutureBuilder myBody(BuildContext context) {
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
                      future: getName(index),
                      builder: (context, snapshot) {
                        return Text(
                          snapshot.data.toString(),
                          style: TextStyle(fontSize: 16.sp),
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
        IconButton(
            onPressed: () {
              sendToAllNotification(
                content: "asdasdasdasd",
                heading: "gsadasd",
              );
            },
            icon: const Icon(Icons.person)),
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
        selectedStatus = "Feedback Given";
        fetchDatabaseList();
        setState(() {});
        break;
      case 'Feedback Not Given':
        selectedStatus = "Feedback Not Given";
        fetchDatabaseList();
        setState(() {});
        break;
    }
  }

  Future<List> fetchDatabaseList() async {
    dynamic resultant;
    if (selectedStatus == "Feedback Given") {
      resultant = await DatabaseService.getFeedbackGivenUserList();
    } else {
      resultant = await DatabaseService.getFeedbackNotGivenUserList();
    }

    if (resultant == null) {
      return userSubmissionList;
    } else {
      userSubmissionList = resultant;
      return userSubmissionList;
    }
  }

  Future<void> _refresh(BuildContext context) async {
    fetchDatabaseList();
    setState(() {});
  }

  Future getName(int index) async {
    String uID = userSubmissionList[index].toString().trim();

    dynamic userName = await DatabaseService.getUserName(uID);

    return userName;
  }
}
