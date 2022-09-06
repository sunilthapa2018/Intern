import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:motivational_leadership/providers/student/type/student_autonomy_provider.dart';
import 'package:motivational_leadership/providers/student/type/student_belonging_provider.dart';
import 'package:motivational_leadership/providers/student/type/student_competence_provider.dart';
import 'package:motivational_leadership/ui/common/widget/verticle_spacer.dart';
import 'package:motivational_leadership/ui/student/widgets/student_navigation_drawer.dart';
import 'package:motivational_leadership/ui/student/widgets/type/student_autonomy_tile.dart';
import 'package:motivational_leadership/ui/student/widgets/type/student_belonging_tile.dart';
import 'package:motivational_leadership/ui/student/widgets/type/student_competence_tile.dart';
import 'package:motivational_leadership/utility/colors.dart';
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
    // String name = loadName().toString();
    log("student home build ");
    log(MediaQuery.of(context).size.height.toString());
    log(MediaQuery.of(context).size.width.toString());
    // addAllQuestionsToDatabase();
    // setPortraitOnlyOrientation();
    return Scaffold(
      drawer: const StudentNavigationDrawerWidget(),
      appBar: _buildAppBar(context),
      body: FutureBuilder(
          future: _loadInitialData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return buildMainBody(context);
          }),
    );
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
      backgroundColor: Colors.transparent,
      elevation: 0,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      actions: [
        IconButton(
            onPressed: () {
              _refresh(context);
            },
            icon: const Icon(Icons.refresh)),
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
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: Column(
          children: [
            letsStart(),
            verticleSpacer(spacer),
            const StudentAutonomyTile(),
            verticleSpacer(spacer),
            const StudentBelongingTile(),
            verticleSpacer(spacer),
            const StudentCompetenceTile(),
            verticleSpacer(spacer),
            _buildButtonLogo()
          ],
        ),
      ),
    );
  }

  Padding _buildButtonLogo() {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(),
      child: Image.asset(
        'assets/complete_logo.png',
        width: width - (20 / 100 * width),
        fit: BoxFit.contain,
      ),
    );
  }

  letsStart() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        "Let's Start",
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
  }
}
