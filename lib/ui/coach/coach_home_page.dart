import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:motivational_leadership/services/database.dart';
import 'package:motivational_leadership/ui/coach/coach_feedback_type_selection_page.dart';
import 'package:motivational_leadership/ui/coach/widgets/coach_navigation_drawer.dart';
import 'package:motivational_leadership/utility/colors.dart';

String uid = FirebaseAuth.instance.currentUser!.uid;

class CoachHome extends StatefulWidget {
  const CoachHome({Key? key}) : super(key: key);

  @override
  State<CoachHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<CoachHome> {
  List userSubmissionList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        drawer: const CoachNavigationDrawerWidget(),
        appBar: myAppBar(),
        body: myBody());
  }

  RefreshIndicator myBody() {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: Container(
        padding: const EdgeInsets.only(top: 5, bottom: 5),
        child: ListView.builder(
          itemCount: userSubmissionList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
              child: Card(
                child: GestureDetector(
                  child: ListTile(
                      // title: Text(getName(index).toString()),
                      title: FutureBuilder(
                        future: getName(index),
                        builder: (context, snapshot) {
                          return Text(snapshot.data.toString());
                        },
                      ),
                      onTap: () async {
                        String userId =
                            await DatabaseService.getUserId("fullName");
                        FeedbackTypeSelection(
                          userID: userId,
                        );
                        log("ListTile");
                      }),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  AppBar myAppBar() {
    return AppBar(
      title: const Text("Students"),
      backgroundColor: appBarColor,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    );
  }

  @override
  void initState() {
    super.initState();
    fetchDatabaseList();
    // print(userSubmissionList);
  }

  Future<void> fetchDatabaseList() async {
    dynamic resultant = await DatabaseService.getUserList();
    if (resultant == null) {
      log("MYTAG: unable to retreive");
    } else {
      setState(() {
        userSubmissionList = resultant;
      });
    }
  }

  Future<void> _refresh() async {
    await fetchDatabaseList();
    setState(() {});
  }

  Future getName(int index) async {
    String uID = userSubmissionList[index].toString().trim();
    log("MYTAG : getName : uID = $uID");
    dynamic userName = await DatabaseService.getUserName(uID);
    log("MYTAG : getName : userName = $userName");
    return userName;
  }
}
