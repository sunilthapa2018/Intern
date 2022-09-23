import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motivational_leadership/services/database.dart';
import 'package:motivational_leadership/ui/admin/widgets/admin_navigation_drawer.dart';
import 'package:motivational_leadership/ui/common/widget/type_decoration_box_1.dart';
import 'package:motivational_leadership/ui/common/widget/verticle_spacer.dart';
import 'package:motivational_leadership/utility/colors.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    log("Admin home Built");
    return Scaffold(
        drawer: const AdminNavigationDrawerWidget(),
        appBar: myAppBar(),
        body: myBody());
  }

  myBody() {
    return Container(
      color: adminBackgroundColor,
      child: Align(
        alignment: Alignment.center,
        child: Column(
          children: [
            Wrap(
              children: [
                totalUsers(),
                totalStudents(),
                totalCoach(),
              ],
            ),
            Wrap(
              children: [
                totalQuestion(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  totalUsers() {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(right: 16, top: 16),
      child: Container(
        width: width / 4.9,
        padding: const EdgeInsets.all(24),
        decoration: myTypeBoxDecoration1(),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: FutureBuilder(
                  future: getDataFromDatabase("users", "", ""),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return textTotal("Loading...");
                    }
                    return textTotal(snapshot.data.toString());
                  }),
            ),
            verticleSpacer(20),
            totalText("Total Users"),
          ],
        ),
      ),
    );
  }

  Future<String> getDataFromDatabase(
    String document,
    String field,
    String fieldData,
  ) async {
    String data = await DatabaseService.getTotalDataInThisDocument(
        document, field, fieldData);
    return data;
  }

  totalStudents() {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(right: 16, top: 16),
      child: Container(
        width: width / 4.9,
        padding: const EdgeInsets.all(24),
        decoration: myTypeBoxDecoration1(),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: FutureBuilder(
                  future: getDataFromDatabase("users", "type", "Student"),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return textTotal("Loading...");
                    }
                    return textTotal(snapshot.data.toString());
                  }),
            ),
            verticleSpacer(20),
            totalText("Total Students"),
          ],
        ),
      ),
    );
  }

  totalCoach() {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(right: 16, top: 16),
      child: Container(
        width: width / 4.9,
        padding: const EdgeInsets.all(24),
        decoration: myTypeBoxDecoration1(),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: FutureBuilder(
                  future: getDataFromDatabase("users", "type", "Coach"),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return textTotal("Loading...");
                    }
                    return textTotal(snapshot.data.toString());
                  }),
            ),
            verticleSpacer(20),
            totalText("Total Coach"),
          ],
        ),
      ),
    );
  }

  totalQuestion() {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(right: 16, top: 16),
      child: Container(
        width: width / 4.9,
        padding: const EdgeInsets.all(24),
        decoration: myTypeBoxDecoration1(),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: FutureBuilder(
                  future: getDataFromDatabase("questions", "", ""),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return textTotal("Loading...");
                    }
                    FlutterNativeSplash.remove();
                    return textTotal(snapshot.data.toString());
                  }),
            ),
            verticleSpacer(20),
            totalText("Total Questions"),
          ],
        ),
      ),
    );
  }

  Text textTotal(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: 36.sp,
      ),
    );
  }

  Align totalText(String text) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 24.sp,
        ),
      ),
    );
  }

  AppBar myAppBar() {
    return AppBar(
      title: const Text("Admin Home"),
      backgroundColor: adminAppBarColor,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      actions: [
        IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: const Icon(Icons.refresh)),
      ],
    );
  }

  @override
  void initState() {
    // addAllQuestionsToDatabase();

    super.initState();
  }
}
