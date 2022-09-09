import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:motivational_leadership/providers/coach/subtype/coach_action_provider.dart';
import 'package:motivational_leadership/providers/coach/subtype/coach_future_provider.dart';
import 'package:motivational_leadership/providers/coach/subtype/coach_imp_provider.dart';
import 'package:motivational_leadership/providers/coach/subtype/coach_io_provider.dart';
import 'package:motivational_leadership/providers/coach/subtype/coach_oc_provider.dart';
import 'package:motivational_leadership/providers/coach/subtype/coach_si_provider.dart';
import 'package:motivational_leadership/ui/coach/widgets/subtype/categories_tile/coach_action_tile.dart';
import 'package:motivational_leadership/ui/coach/widgets/subtype/categories_tile/coach_future_tile.dart';
import 'package:motivational_leadership/ui/coach/widgets/subtype/categories_tile/coach_imp_tile.dart';
import 'package:motivational_leadership/ui/coach/widgets/subtype/categories_tile/coach_io_tile.dart';
import 'package:motivational_leadership/ui/coach/widgets/subtype/categories_tile/coach_oc_tile.dart';
import 'package:motivational_leadership/ui/coach/widgets/subtype/categories_tile/coach_si_tile.dart';
import 'package:motivational_leadership/ui/student/widgets/my_button_box.dart';
import 'package:motivational_leadership/utility/colors.dart';
import 'package:motivational_leadership/utility/utils.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;

class CoachFeedbackSubTypeSelection extends StatefulWidget {
  final String userID;
  final String questionType;
  const CoachFeedbackSubTypeSelection(
      {super.key, required this.userID, required this.questionType});
  @override
  State<CoachFeedbackSubTypeSelection> createState() =>
      _CoachFeedbackSubTypeSelectionState();
}

class _CoachFeedbackSubTypeSelectionState
    extends State<CoachFeedbackSubTypeSelection> {
  @override
  Widget build(BuildContext context) {
    myWidth = MediaQuery.of(context).size.width / 2;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    return Scaffold(
      appBar: appBar(context),
      body: FutureBuilder(
          future: _loadInitialData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                color: coachBackgroundColor,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            return body(context);
          }),
    );
  }

  late double myWidth = 300;
  late String _questionType = "";

  AppBar appBar(BuildContext context) {
    return AppBar(
      title: const Text("Sub Type Selection"),
      backgroundColor: coachAppBarColor,
      actions: [
        IconButton(
            onPressed: () {
              _refresh(context);
            },
            icon: const Icon(Icons.refresh)),
      ],
    );
  }

  Future<String> getData(String subType) async {
    if (FirebaseAuth.instance.currentUser != null) {
      String uid = FirebaseAuth.instance.currentUser!.uid;

      final QuerySnapshot qSnapshot = await FirebaseFirestore.instance
          .collection('questions')
          .where('type', isEqualTo: _questionType)
          .where('sub type', isEqualTo: subType)
          .get();
      final int qDocuments = qSnapshot.docs.length;

      final QuerySnapshot aSnapshot = await FirebaseFirestore.instance
          .collection('answers')
          .where('uid', isEqualTo: uid)
          .where('type', isEqualTo: _questionType)
          .where('sub type', isEqualTo: subType)
          .get();
      final int aDocuments = aSnapshot.docs.length;
      String returnText = "Completed : $aDocuments/$qDocuments";
      return returnText;
    }
    return "nodata";
  }

  @override
  initState() {
    super.initState();
    _questionType = widget.questionType;
    tz.initializeTimeZones();
  }

  Text txtLoading() {
    return const Text(
      "Loading...",
      style: TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
    );
  }

  Container body(BuildContext context) {
    return Container(
      color: coachBackgroundColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Align(
            alignment: Alignment.center,
            child: Stack(
              children: [
                Container(
                  width: myWidth,
                  margin: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                  padding: const EdgeInsets.only(bottom: 10, top: 6),
                  decoration: BoxDecoration(
                    border: Border.all(color: itemColor, width: 1.sp),
                    borderRadius: BorderRadius.circular(10),
                    shape: BoxShape.rectangle,
                  ),
                  child: Column(
                    children: [
                      CoachActionTile(
                        userID: widget.userID,
                        questionType: _questionType,
                      ),
                      CoachOCTile(
                          userID: widget.userID, questionType: _questionType),

                      CoachSITile(
                          userID: widget.userID, questionType: _questionType),
                      planSubmitButton(context),
                      // overcomingChallenges(context),
                    ],
                  ),
                ),
                planSection(),
              ],
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Stack(
              children: [
                Container(
                  width: myWidth,
                  margin: const EdgeInsets.fromLTRB(10, 15, 10, 10),
                  padding: const EdgeInsets.only(bottom: 10, top: 6),
                  decoration: BoxDecoration(
                    border: Border.all(color: itemColor, width: 1.sp),
                    borderRadius: BorderRadius.circular(10),
                    shape: BoxShape.rectangle,
                  ),
                  child: Column(
                    children: [
                      CoachImplementationTile(
                          userID: widget.userID, questionType: _questionType),
                      CoachIOTile(
                          userID: widget.userID, questionType: _questionType),
                      CoachFutureTile(
                          userID: widget.userID, questionType: _questionType),
                      reflectSubmitButton(context),
                    ],
                  ),
                ),
                reflectSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  GestureDetector planSubmitButton(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        String txtAValue = context.read<CoachActionProvider>().completedText;
        String txtBValue = context.read<CoachOCProvider>().completedText;
        String txtCValue = context.read<CoachSIProvider>().completedText;

        bool aCompleted = getCompletedStatus(txtAValue);
        bool bCompleted = getCompletedStatus(txtBValue);
        bool cCompleted = getCompletedStatus(txtCValue);
        log("MYTAG : $aCompleted , $bCompleted , $cCompleted");
        // String uid = FirebaseAuth.instance.currentUser!.uid;

        if (aCompleted & bCompleted & cCompleted) {
          // Map<String, String> data = HashMap<String, String>();
          // data.putIfAbsent("key", () => "null");

          // NotificationService().showNotification(
          //     1, "Feedback", "Your Coach had given you a feedback", 1);
          // NotificationApi.showNotification(
          //     title: "Sunil Thapa", body: "I got you", payload: "sunil");
          //push notification
        } else {
          Utils.showSnackBar(
              "Please complete all sections of PLAN before you can submit");
          // log("MYTAG : Not Completed");
        }
      },
      child: submitButton(context),
    );
  }

  Future<void> sendPushMessage() async {
    FirebaseMessaging fm = FirebaseMessaging.instance;
    String? token = await fm.getToken();
    if (token == null) {
      log('Unable to send FCM message, no token exists.');
      return;
    }

    try {
      await http.post(
        Uri.parse('https://api.rnfirebase.io/messaging/send'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: constructFCMPayload(token),
      );
      log('FCM request for device sent!');
    } catch (e) {
      log(e.toString());
    }
  }

  String constructFCMPayload(String? token) {
    return jsonEncode({
      'token': token,
      'data': {
        'via': 'FlutterFire Cloud Messaging!!!',
        'count': 1,
      },
      'notification': {
        'title': 'Hello FlutterFire!',
        'body': 'This notification (#1) was created via FCM!',
      },
    });
  }

  GestureDetector reflectSubmitButton(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        String txtDValue =
            context.read<CoachImplementationProvider>().completedText;
        String txtEValue = context.read<CoachIOProvider>().completedText;
        String txtFValue = context.read<CoachFutureProvider>().completedText;

        bool dCompleted = getCompletedStatus(txtDValue);
        bool eCompleted = getCompletedStatus(txtEValue);
        bool fCompleted = getCompletedStatus(txtFValue);

        String uid = FirebaseAuth.instance.currentUser!.uid;
        if (dCompleted & eCompleted & fCompleted) {
          //push notification
        } else {
          Utils.showSnackBar(
              "Please complete all sections of REFLECT before you can submit");
          // log("MYTAG : Not Completed");
        }
      },
      child: submitButton(context),
    );
  }

  bool getCompletedStatus(String value) {
    if (value == "Feedback Given") {
      return true;
    } else {
      return false;
    }
  }

  UnconstrainedBox submitButton(BuildContext context) {
    return UnconstrainedBox(
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width / 3,
        margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: myButtonBox(),
        child: Text(
          "Push Student Notification",
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
    );
  }

  Positioned planSection() {
    return Positioned(
        left: 50,
        top: 12,
        child: Container(
          padding: const EdgeInsets.only(left: 10, right: 10),
          color: coachBackgroundColor,
          child: Text(
            'Plan',
            style: TextStyle(
              color: itemColor,
              fontWeight: FontWeight.w800,
              fontSize: 16,
            ),
          ),
        ));
  }

  Positioned reflectSection() {
    return Positioned(
        left: 50,
        top: 7,
        child: Container(
          padding: const EdgeInsets.only(left: 10, right: 10),
          color: coachBackgroundColor,
          child: Text(
            'Reflect',
            style: TextStyle(
              color: itemColor,
              fontWeight: FontWeight.w800,
              fontSize: 16,
            ),
          ),
        ));
  }

  _refresh(BuildContext context) async {
    context.read<CoachActionProvider>().getData(
        studentId: widget.userID,
        type: widget.questionType,
        notify: true,
        subType: "Actions");
    context.read<CoachOCProvider>().getData(
        studentId: widget.userID,
        type: widget.questionType,
        notify: true,
        subType: "Overcoming Challenges");
    context.read<CoachSIProvider>().getData(
        studentId: widget.userID,
        type: widget.questionType,
        notify: true,
        subType: "Success Indicators (KPIs)");
    context.read<CoachImplementationProvider>().getData(
        studentId: widget.userID,
        type: widget.questionType,
        notify: true,
        subType: "Implementation");
    context.read<CoachIOProvider>().getData(
        studentId: widget.userID,
        type: widget.questionType,
        notify: true,
        subType: "Impact and Outcome");
    context.read<CoachFutureProvider>().getData(
        studentId: widget.userID,
        type: widget.questionType,
        notify: true,
        subType: "Future");
  }

  _loadInitialData() async {
    await Future.wait([
      context.read<CoachActionProvider>().getData(
          studentId: widget.userID,
          type: widget.questionType,
          notify: false,
          subType: "Actions"),
      context.read<CoachOCProvider>().getData(
          studentId: widget.userID,
          type: widget.questionType,
          notify: false,
          subType: "Overcoming Challenges"),
      context.read<CoachSIProvider>().getData(
          studentId: widget.userID,
          type: widget.questionType,
          notify: false,
          subType: "Success Indicators (KPIs)"),
      context.read<CoachImplementationProvider>().getData(
          studentId: widget.userID,
          type: widget.questionType,
          notify: false,
          subType: "Implementation"),
      context.read<CoachIOProvider>().getData(
          studentId: widget.userID,
          type: widget.questionType,
          notify: false,
          subType: "Impact and Outcome"),
      context.read<CoachFutureProvider>().getData(
          studentId: widget.userID,
          type: widget.questionType,
          notify: false,
          subType: "Future"),
    ]);
  }
}
