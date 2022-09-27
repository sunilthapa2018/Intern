import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motivational_leadership/services/database.dart';
import 'package:motivational_leadership/utility/base_utils.dart';
import 'package:motivational_leadership/utility/colors.dart';
import 'package:motivational_leadership/utility/utils.dart';

String uid = FirebaseAuth.instance.currentUser!.uid;
String selectedStatus = "Both";
final coachNavigatorKey = GlobalKey<NavigatorState>();
TextEditingController searchController = TextEditingController();
TextEditingController titleController = TextEditingController();

class EditUsers extends StatefulWidget {
  const EditUsers({Key? key}) : super(key: key);

  @override
  State<EditUsers> createState() => _EditUsersState();
}

class _EditUsersState extends State<EditUsers> {
  List userSubmissionList = [];
  bool btnSearchClicked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: adminBackgroundColor,
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
    return Column(
      children: [
        myRowForSearch(),
        Expanded(
          child: listView(),
        )
      ],
    );
  }

  myRowForSearch() {
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
            Utils.showSnackBar("Email feild is empty");
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
          labelText: "Search User by Email",
          hintText: "Email",
        ),
      ),
    );
  }

  listView() {
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
                        String name = splitted[0].trim();
                        String type = splitted[2].trim();
                        String email = splitted[1].trim();
                        return Row(
                          children: [
                            Expanded(
                              child: Text(
                                "$name     [$type]",
                                style: TextStyle(fontSize: 16.sp),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                email,
                                style: TextStyle(fontSize: 16.sp),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                child: myButtonDesign(
                                    "Reset Password", Colors.green, 200),
                                onTap: () {
                                  try {
                                    FirebaseAuth.instance
                                        .sendPasswordResetEmail(email: email);
                                    Utils.showSnackBar(
                                        "Password reset link has been sent to the user");
                                  } on FirebaseAuthException catch (e) {
                                    Utils.showSnackBar(
                                        "Failed Error Message: $e.message");
                                  }
                                },
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                child:
                                    myButtonDesign("Delete", Colors.red, 100),
                                onTap: () async {
                                  try {
                                    String userId = userSubmissionList[index];
                                    final shouldPop =
                                        await showWarning(context, userId);
                                    shouldPop ?? false;
                                    searchController.text = "";
                                    setState(() {});
                                    Utils.showSnackBar(
                                        "All user Data has been Deleted");
                                  } on FirebaseAuthException catch (e) {
                                    Utils.showSnackBar(
                                        "Failed Error Message: $e.message");
                                  }
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    onTap: null),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<bool?> showWarning(BuildContext context, String userId) async =>
      showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(
            "!!! Warning !!!",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
              "Are you sure you want to delete this User? This Data cannot be retained!!!"),
          actions: [
            ElevatedButton(
              onPressed: () {
                DatabaseService.deleteAllUserData(userId);
                Navigator.pop(context, true);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text("Yes"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, false),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: const Text("No"),
            ),
          ],
        ),
      );

  myButtonDesign(String text, Color color, double size) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          width: size,
          padding: const EdgeInsets.symmetric(vertical: 16),
          margin: const EdgeInsets.only(left: 16),
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(5)),
          child: Text(
            text,
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ],
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
            return {
              'Both',
              'Student',
              'Coach',
            }.map((String choice) {
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
      case 'Both':
        searchController.text = "";
        btnSearchClicked = false;
        selectedStatus = "Both";
        titleController.text = "Both";
        setState(() {});
        break;
      case 'Student':
        searchController.text = "";
        btnSearchClicked = false;
        selectedStatus = "Student";
        titleController.text = "Student";
        setState(() {});
        break;
      case 'Coach':
        searchController.text = "";
        btnSearchClicked = false;
        selectedStatus = "Coach";
        titleController.text = "Coach";
        setState(() {});
        break;
    }
  }

  Future<List> fetchDatabaseList() async {
    dynamic resultant;
    log(btnSearchClicked.toString());
    if (btnSearchClicked) {
      resultant =
          await DatabaseService.searchStudentListNyEmail(searchController.text);
      log("i am here");
    } else {
      if (selectedStatus == "Student") {
        resultant = await DatabaseService.getAllUserList("Student");
      } else if (selectedStatus == "Coach") {
        resultant = await DatabaseService.getAllUserList("Coach");
      } else {
        resultant = await DatabaseService.getAllUserList("Both");
      }
    }
    log(resultant.toString());

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
    dynamic userType = await DatabaseService.getUserType(uID);

    return userName + " , " + userEmail + " , " + userType;
  }
}
