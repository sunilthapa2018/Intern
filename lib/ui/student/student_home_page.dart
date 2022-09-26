import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:motivational_leadership/providers/student/type/student_autonomy_provider.dart';
import 'package:motivational_leadership/providers/student/type/student_belonging_provider.dart';
import 'package:motivational_leadership/providers/student/type/student_competence_provider.dart';
import 'package:motivational_leadership/ui/common/widget/copyright_text.dart';
import 'package:motivational_leadership/ui/common/widget/verticle_spacer.dart';
import 'package:motivational_leadership/ui/student/widgets/student_navigation_drawer.dart';
import 'package:motivational_leadership/ui/student/widgets/type/student_autonomy_tile.dart';
import 'package:motivational_leadership/ui/student/widgets/type/student_belonging_tile.dart';
import 'package:motivational_leadership/ui/student/widgets/type/student_competence_tile.dart';
import 'package:motivational_leadership/utility/colors.dart';
import 'package:motivational_leadership/widget/circular_progress_indicator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentHome extends StatefulWidget {
  const StudentHome({Key? key}) : super(key: key);
  @override
  State<StudentHome> createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  @override
  Widget build(BuildContext context) {
    log("Student Home page Built");
    return FutureBuilder(
      future: _loadInitialData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return myCircularProgressIndicator(context);
        }
        return Scaffold(
          drawer: const StudentNavigationDrawerWidget(),
          appBar: _buildAppBar(context),
          body: buildMainBody(context),
        );
      },
    );
  }

  storeNotificationToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set(
      {'token': token},
      SetOptions(merge: true),
    );
  }

  @override
  void initState() {
    super.initState();
    storeNotificationToken();
  }

  Future<String> loadName() async {
    final prefs = await SharedPreferences.getInstance();
    final savedName = prefs.getString('name').toString();
    return savedName;
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      toolbarHeight: 36,
      iconTheme: IconThemeData(color: iconColor),
      backgroundColor: appBarColor,
      elevation: 0,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      actions: [
        IconButton(
          iconSize: 30.sp,
          padding: const EdgeInsets.only(right: 8),
          onPressed: () {
            _refresh(context);
          },
          icon: Icon(
            FontAwesomeIcons.arrowRotateRight,
            color: iconColor,
            size: 20,
          ),
        ),
      ],
    );
  }

  buildMainBody(BuildContext context) {
    double spacer = 16;
    return Container(
      padding: const EdgeInsets.all(0),
      color: backgroundColor,
      height: double.infinity,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(0),
        child: Column(
          children: [
            Stack(
              children: [
                mainImage(),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                  ),
                  child: Column(
                    children: [
                      heading(),
                      verticleSpacer(6),
                      firstText(),
                      secondText(),
                      verticleSpacer(spacer),
                      verticleSpacer(spacer),
                      const StudentAutonomyTile(),
                      verticleSpacer(spacer),
                      const StudentBelongingTile(),
                      verticleSpacer(spacer),
                      const StudentCompetenceTile(),
                      verticleSpacer(spacer),
                      verticleSpacer(spacer),
                      copyrightText(),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Text firstText() {
    return Text(
        "This app guides leaders in an evidence-based approach to building highly motivated workplace behaviour. Leaders receive individual coaching in the practical application of Self-Determination Theory (Deci 1989), a theory of human motivation.",
        style: myTextStyle(),
        textAlign: TextAlign.justify);
  }

  RichText secondText() {
    return RichText(
      textAlign: TextAlign.justify,
      text: TextSpan(
        children: [
          TextSpan(
            text: "By working through an action plan for the ",
            style: myTextStyle(),
          ),
          TextSpan(
            text: "A",
            style: myTextStyle2(),
          ),
          TextSpan(
            text: "utonomy, ",
            style: myTextStyle(),
          ),
          TextSpan(
            text: "B",
            style: myTextStyle2(),
          ),
          TextSpan(
            text: "elonging and ",
            style: myTextStyle(),
          ),
          TextSpan(
            text: "C",
            style: myTextStyle2(),
          ),
          TextSpan(
            text:
                "ompetence modules below, we help leaders apply what we call the ABC of motivational leadership in their workplace.",
            style: myTextStyle(),
          ),
        ],
      ),
    );
  }

  TextStyle myTextStyle() {
    return TextStyle(
      fontWeight: FontWeight.w400,
      fontFamily: 'Roboto',
      fontSize: 16.sp,
      color: Colors.black87,
      decoration: TextDecoration.none,
    );
  }

  TextStyle myTextStyle2() {
    return TextStyle(
      fontWeight: FontWeight.w800,
      fontFamily: 'Roboto',
      fontSize: 16.sp,
      color: orangeColor,
      decoration: TextDecoration.none,
    );
  }

  mainImage() {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Image.asset(
        'assets/main_image.png',
        width: width,
        fit: BoxFit.contain,
        color: Colors.white.withOpacity(0.3),
        colorBlendMode: BlendMode.modulate,
      ),
    );
  }

  heading() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        "Let's begin",
        style: Theme.of(context).textTheme.headline3,
      ),
    );
  }

  _refresh(BuildContext context) async {
    context
        .read<StudentAutonomyProvider>()
        .getData(type: "Autonomy", notify: true);
    context
        .read<StudentBelongingProvider>()
        .getData(type: "Belonging", notify: true);
    context
        .read<StudentCompetenceProvider>()
        .getData(type: "Competence", notify: true);
  }

  _loadInitialData() async {
    await Future.wait([
      context
          .read<StudentAutonomyProvider>()
          .getData(type: "Autonomy", notify: false),
      context
          .read<StudentBelongingProvider>()
          .getData(type: "Belonging", notify: false),
      context
          .read<StudentCompetenceProvider>()
          .getData(type: "Competence", notify: false),
    ]);
    FlutterNativeSplash.remove();
  }

  void checkAndHandlePersmission() async {
    await [
      Permission.notification,
    ].request();
  }
}
