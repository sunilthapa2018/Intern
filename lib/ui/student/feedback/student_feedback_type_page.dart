import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:motivational_leadership/providers/student/feedback/type/student_feedback_autonomy_provider.dart';
import 'package:motivational_leadership/providers/student/feedback/type/student_feedback_belonging_provider.dart';
import 'package:motivational_leadership/providers/student/feedback/type/student_feedback_competence_provider.dart';
import 'package:motivational_leadership/ui/student/feedback/type/student_feedback_autonomy_tile.dart';
import 'package:motivational_leadership/ui/student/feedback/type/student_feedback_belonging.dart';
import 'package:motivational_leadership/ui/student/feedback/type/student_feedback_competence.dart';
import 'package:motivational_leadership/utility/colors.dart';
import 'package:provider/provider.dart';

class StudentFeedbackType extends StatefulWidget {
  const StudentFeedbackType({Key? key}) : super(key: key);
  @override
  State<StudentFeedbackType> createState() => _StudentFeedbackTypeState();
}

class _StudentFeedbackTypeState extends State<StudentFeedbackType> {
  @override
  Widget build(BuildContext context) {
    log("Student Feedback Type Selection Page build ");
    log(MediaQuery.of(context).size.height.toString());
    log(MediaQuery.of(context).size.width.toString());

    // setPortraitOnlyOrientation();
    return Scaffold(
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
      title: const Text("Type Selection"),
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
            const StudentFeedbackAutonomyTile(),
            const StudentFeedbackBelongingTile(),
            const StudentFeedbackCompetenceTile(),
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
        .read<StudentFeedbackAutonomyProvider>()
        .getData(type: "Autonomy", notify: true);
    context
        .read<StudentFeedbackBelongingProvider>()
        .getData(type: "Belonging", notify: true);
    context
        .read<StudentFeedbackCompetenceProvider>()
        .getData(type: "Competence", notify: true);
  }

  _loadInitialData() async {
    await Future.wait([
      context
          .read<StudentFeedbackAutonomyProvider>()
          .getData(type: "Autonomy", notify: false),
      context
          .read<StudentFeedbackBelongingProvider>()
          .getData(type: "Belonging", notify: false),
      context
          .read<StudentFeedbackCompetenceProvider>()
          .getData(type: "Competence", notify: false),
    ]);
  }
}
