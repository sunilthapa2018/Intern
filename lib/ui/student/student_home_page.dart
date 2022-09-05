import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:motivational_leadership/providers/student/type/student_autonomy_provider.dart';
import 'package:motivational_leadership/providers/student/type/student_belonging_provider.dart';
import 'package:motivational_leadership/providers/student/type/student_competence_provider.dart';
import 'package:motivational_leadership/ui/student/widgets/student_navigation_drawer.dart';
import 'package:motivational_leadership/ui/student/widgets/type/student_autonomy_tile.dart';
import 'package:motivational_leadership/ui/student/widgets/type/student_belonging.dart';
import 'package:motivational_leadership/ui/student/widgets/type/student_competence.dart';
import 'package:motivational_leadership/utility/colors.dart';
import 'package:provider/provider.dart';

class StudentHome extends StatefulWidget {
  const StudentHome({Key? key}) : super(key: key);
  @override
  State<StudentHome> createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  @override
  Widget build(BuildContext context) {
    log("student home build ");
    log(MediaQuery.of(context).size.height.toString());
    log(MediaQuery.of(context).size.width.toString());

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
            return _buildMainBody(context);
          }),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text("Home"),
      backgroundColor: appBarColor,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      actions: [
        IconButton(
            onPressed: () {
              _refresh(context);
            },
            icon: const Icon(Icons.refresh)),
      ],
    );
  }

  _buildMainBody(BuildContext context) {
    return Container(
      color: backgroundColor,
      height: double.infinity,
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: Column(
          children: [
            const StudentAutonomyTile(),
            const StudentBelongingTile(),
            const StudentCompetenceTile(),
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
    await context
        .read<StudentAutonomyProvider>()
        .getData(type: "Autonomy", notify: false);
    await context
        .read<StudentBelongingProvider>()
        .getData(type: "Belonging", notify: false);
    await context
        .read<StudentCompetenceProvider>()
        .getData(type: "Competence", notify: false);
  }
}
