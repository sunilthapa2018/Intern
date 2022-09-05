import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:motivational_leadership/providers/student/feedback/subtype/student_feedback_action_provider.dart';
import 'package:motivational_leadership/providers/student/feedback/subtype/student_feedback_future_provider.dart';
import 'package:motivational_leadership/providers/student/feedback/subtype/student_feedback_imp_provider.dart';
import 'package:motivational_leadership/providers/student/feedback/subtype/student_feedback_io_provider.dart';
import 'package:motivational_leadership/providers/student/feedback/subtype/student_feedback_oc_provider.dart';
import 'package:motivational_leadership/providers/student/feedback/subtype/student_feedback_si_provider.dart';
import 'package:motivational_leadership/providers/student/subtype/student_feedback_action_provider.dart';
import 'package:motivational_leadership/providers/student/subtype/student_feedback_future_provider.dart';
import 'package:motivational_leadership/providers/student/subtype/student_feedback_imp_provider.dart';
import 'package:motivational_leadership/providers/student/subtype/student_feedback_io_provider.dart';
import 'package:motivational_leadership/providers/student/subtype/student_feedback_oc_provider.dart';
import 'package:motivational_leadership/providers/student/subtype/student_feedback_si_provider.dart';
import 'package:motivational_leadership/services/database.dart';
import 'package:motivational_leadership/ui/student/feedback/subtype/categories_tile/student_feedback_action_tile.dart';
import 'package:motivational_leadership/ui/student/feedback/subtype/categories_tile/student_feedback_future_tile.dart';
import 'package:motivational_leadership/ui/student/feedback/subtype/categories_tile/student_feedback_imp_tile.dart';
import 'package:motivational_leadership/ui/student/feedback/subtype/categories_tile/student_feedback_io_tile.dart';
import 'package:motivational_leadership/ui/student/feedback/subtype/categories_tile/student_feedback_oc_tile.dart';
import 'package:motivational_leadership/ui/student/feedback/subtype/categories_tile/student_feedback_si_tile.dart';
import 'package:motivational_leadership/utility/colors.dart';
import 'package:motivational_leadership/utility/utils.dart';
import 'package:provider/provider.dart';

class StudentFeedbackSubTypeSelection extends StatefulWidget {
  final String questionType;

  const StudentFeedbackSubTypeSelection(
      {super.key, required this.questionType});
  @override
  _StudentFeedbackSubTypeSelectionState createState() =>
      _StudentFeedbackSubTypeSelectionState();
}

class _StudentFeedbackSubTypeSelectionState
    extends State<StudentFeedbackSubTypeSelection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: backgroundColor,
        appBar: appBar(context),
        body: FutureBuilder(
            future: _loadInitialData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  color: backgroundColor,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              return myBody(context);
            }));
  }

  late String _questionType = "";

  ListView myBody(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        planSection(context),
        reflectSection(context),
      ],
    );
  }

  Stack reflectSection(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.fromLTRB(10, 15, 10, 10),
          padding: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            border: Border.all(color: itemColor, width: 1),
            borderRadius: BorderRadius.circular(10),
            shape: BoxShape.rectangle,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              StudentFeedbackImplementationTile(questionType: _questionType),
              StudentFeedbackIOTile(questionType: _questionType),
              StudentFeedbackFutureTile(questionType: _questionType),
            ],
          ),
        ),
        reflectBorder(),
      ],
    );
  }

  Stack planSection(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.fromLTRB(10, 20, 10, 10),
          padding: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            border: Border.all(color: itemColor, width: 1),
            borderRadius: BorderRadius.circular(10),
            shape: BoxShape.rectangle,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              StudentFeedbackActionTile(questionType: _questionType),
              StudentFeedbackOCTile(questionType: _questionType),
              StudentFeedbackSITile(questionType: _questionType),
            ],
          ),
        ),
        planBorder(),
      ],
    );
  }

  Positioned reflectBorder() {
    return Positioned(
        left: 50,
        top: 7,
        child: Container(
          padding: const EdgeInsets.only(left: 10, right: 10),
          color: backgroundColor,
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

  GestureDetector reflectSubmitButton(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        String txtDValue =
            context.read<StudentImplementationProvider>().completedText;
        String txtEValue = context.read<StudentIOProvider>().completedText;
        String txtFValue = context.read<StudentFutureProvider>().completedText;
        bool dCompleted = getCompletedStatus(txtDValue);
        bool eCompleted = getCompletedStatus(txtEValue);
        bool fCompleted = getCompletedStatus(txtFValue);
        log("MYTAG : $dCompleted , $eCompleted , $fCompleted");
        String uid = FirebaseAuth.instance.currentUser!.uid;
        if (dCompleted & eCompleted & fCompleted) {
          bool dataAlreadyPresent =
              await DatabaseService.hasThisDocument("submissions", uid);
          log("Mytag : dataAlreadyPresent = $dataAlreadyPresent");
          if (dataAlreadyPresent) {
            //edit data in database
            DatabaseService.updateSubmissions("reflect", "true");
            Utils.showSnackBar(
                "Your answer has been Edited and re-submitted for Reflect section");
            log("MYTAG : updateSubmissions Completed ...");
          } else {
            //write new data to database
            DatabaseService.addSubmissions("false", "true");
            Utils.showSnackBar(
                "Your answer has been submitted for Reflect section");
            log("MYTAG : addSubmissions Completed ...");
          }
        } else {
          Utils.showSnackBar(
              "Please complete all sections of REFLECT before you can submit");
          log("MYTAG : Not Completed");
        }
      },
      child: UnconstrainedBox(
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width / 3,
          margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
              color: appBarColor, borderRadius: BorderRadius.circular(30)),
          child: const Text(
            "Submit",
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Positioned planBorder() {
    return Positioned(
        left: 50,
        top: 12,
        child: Container(
          padding: const EdgeInsets.only(left: 10, right: 10),
          color: backgroundColor,
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

  GestureDetector planSubmitButton(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        String txtAValue = context.read<StudentActionProvider>().completedText;
        String txtBValue = context.read<StudentOCProvider>().completedText;
        String txtCValue = context.read<StudentSIProvider>().completedText;

        bool aCompleted = getCompletedStatus(txtAValue);
        bool bCompleted = getCompletedStatus(txtBValue);
        bool cCompleted = getCompletedStatus(txtCValue);
        log("MYTAG : $aCompleted , $bCompleted , $cCompleted");
        String uid = FirebaseAuth.instance.currentUser!.uid;
        if (aCompleted & bCompleted & cCompleted) {
          bool dataAlreadyPresent =
              await DatabaseService.hasThisDocument("submissions", uid);
          log("Mytag : dataAlreadyPresent = $dataAlreadyPresent");
          if (dataAlreadyPresent) {
            //edit data in database
            DatabaseService.updateSubmissions("plan", "true");
            Utils.showSnackBar(
                "Your answer has been Edited and re-submitted for PLAN section");
            // log("MYTAG : updateSubmissions Completed ...");
          } else {
            //write new data to database
            DatabaseService.addSubmissions("true", "false");
            Utils.showSnackBar(
                "Your answer has been submitted for PLAN section");
            // log("MYTAG : addSubmissions Completed ...");
          }
        } else {
          Utils.showSnackBar(
              "Please complete all sections of PLAN before you can submit");
          // log("MYTAG : Not Completed");
        }
      },
      child: UnconstrainedBox(
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width / 3,
          margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
              color: appBarColor, borderRadius: BorderRadius.circular(30)),
          child: const Text(
            "Submit",
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      title: const Text("Question Type Selection"),
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

  @override
  initState() {
    super.initState();
    _questionType = widget.questionType;
  }

  bool getCompletedStatus(String value) {
    final split = value.split(':');
    final split2 = split[1].split('/');
    String completed = split2[0].trim();
    String total = split2[1].trim();
    if (completed == total) {
      return true;
    } else {
      return false;
    }
  }

  Text loadingText() {
    return const Text(
      "Loading...",
      style: TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
    );
  }

  _refresh(BuildContext context) async {
    context
        .read<StudentFeedbackActionProvider>()
        .getData(type: widget.questionType, notify: true, subType: "Actions");
    context.read<StudentFeedbackOCProvider>().getData(
        type: widget.questionType,
        notify: true,
        subType: "Overcoming Challenges");
    context.read<StudentFeedbackSIProvider>().getData(
        type: widget.questionType,
        notify: true,
        subType: "Success Indicators (KPIs)");
    context.read<StudentFeedbackImplementationProvider>().getData(
        type: widget.questionType, notify: true, subType: "Implementation");
    context.read<StudentFeedbackIOProvider>().getData(
        type: widget.questionType, notify: true, subType: "Impact and Outcome");
    context
        .read<StudentFeedbackFutureProvider>()
        .getData(type: widget.questionType, notify: true, subType: "Future");
  }

  _loadInitialData() async {
    await context
        .read<StudentFeedbackActionProvider>()
        .getData(type: widget.questionType, notify: false, subType: "Actions");
    await context.read<StudentFeedbackOCProvider>().getData(
        type: widget.questionType,
        notify: false,
        subType: "Overcoming Challenges");
    await context.read<StudentFeedbackSIProvider>().getData(
        type: widget.questionType,
        notify: false,
        subType: "Success Indicators (KPIs)");
    await context.read<StudentFeedbackImplementationProvider>().getData(
        type: widget.questionType, notify: false, subType: "Implementation");
    await context.read<StudentFeedbackIOProvider>().getData(
        type: widget.questionType,
        notify: false,
        subType: "Impact and Outcome");
    await context
        .read<StudentFeedbackFutureProvider>()
        .getData(type: widget.questionType, notify: false, subType: "Future");
  }
}
