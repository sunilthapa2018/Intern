import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motivational_leadership/ui/common/app_bar.dart';
import 'package:motivational_leadership/utility/colors.dart';
import 'package:motivational_leadership/utility/utils.dart';

class StudentFeedback extends StatefulWidget {
  final String questionType;
  final String questionSubType;

  const StudentFeedback({
    super.key,
    required this.questionType,
    required this.questionSubType,
  });

  @override
  State<StudentFeedback> createState() => _StudentFeedbackState();
}

class _StudentFeedbackState extends State<StudentFeedback> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBar(context, "Coach's Feedback"),
      body: myBody(context),
    );
  }

  late String questionType;
  late String questionSubType;

  SingleChildScrollView myBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          feedbackPart(),
          contactButton(context),
          verticalSpacing(),
        ],
      ),
    );
  }

  @override
  initState() {
    super.initState();
    questionType = widget.questionType;
    questionSubType = widget.questionSubType;
  }

  SizedBox verticalSpacing() {
    return const SizedBox(
      height: 10,
    );
  }

  Padding feedbackPart() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.blue,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(3))),
        child: Align(alignment: Alignment.topLeft, child: loadFeedback()),
      ),
    );
  }

  FutureBuilder<String> loadFeedback() {
    return FutureBuilder<String>(
        future: getFeedback(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              log("Connection State = Waiting $snapshot");
              if (snapshot.hasData) {
                String data = snapshot.data!;
                return feedbackText(data);
              } else {
                return feedbackText("Loading Feedback from database...");
              }
            case ConnectionState.done:
            default:
              log("Connection State = done $snapshot");
              if (snapshot.hasError) {
                final error = snapshot.error;
                return Text("$error");
              } else if (snapshot.hasData) {
                String data = snapshot.data!;
                if (data.isEmpty) {
                  return feedbackText("Feedback has not yet been given.");
                } else {
                  // answerController.text = answerText(data).toString();
                  return feedbackText(data);
                }
              } else {
                return feedbackText('no data');
              }
          }
        });
  }

  Text feedbackText(String label) {
    return Text(
      label,
      style: TextStyle(
        color: Colors.black87,
        fontSize: 18.sp,
      ),
    );
  }

  Future<String> getFeedback() async {
    log("I am here");
    final String uID = FirebaseAuth.instance.currentUser!.uid;
    String feedback = "Feedback not Found on the database.";
    log("$this || uID = $uID , questionType = $questionType , questionSubType = $questionSubType");
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('feedbacks')
        .where('student_id', isEqualTo: uID)
        .where('type', isEqualTo: questionType)
        .where('sub type', isEqualTo: questionSubType)
        .get();
    for (var doc in snapshot.docs) {
      if (snapshot.docs.isNotEmpty) {
        feedback = doc.get('feedback');
        log('MYTAG : Feedback Found on the database');
        return feedback;
      } else {
        log('MYTAG : Feedback not Found on the database');
        feedback = "Feedback not Found on the database.";
        return feedback;
      }
    }
    return feedback;
  }

  GestureDetector contactButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        try {} on FirebaseAuthException catch (e) {
          log(e.toString());
          Utils.showSnackBar(e.message);
        }
      },
      child: Container(
        margin: const EdgeInsets.all(0),
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width / 2,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        decoration: BoxDecoration(
            color: buttonColor, borderRadius: BorderRadius.circular(30)),
        child: Text(
          "Contact Coach",
          style: TextStyle(fontSize: 16.sp, color: Colors.white),
        ),
      ),
    );
  }
}
