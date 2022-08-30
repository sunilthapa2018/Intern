// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motivational_leadership/Utility/colors.dart';
import 'package:motivational_leadership/Utility/utils.dart';

class FeedbackPage extends StatefulWidget {
  final String questionType;
  final String questionSubType;
  const FeedbackPage(
      {required this.questionType, required this.questionSubType});
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

int totalQuestion = 0;

class _FeedbackPageState extends State<FeedbackPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBar(context),
      body: body(context),
    );
  }

  late String _questionType;
  late String _questionSubType;
  late int _questionNumber;
  late String _answer = "Answer will be here";
  late Future<String> dataFuture;
  late Future<String> answerFuture;
  late Future<String> totalFuture;
  TextEditingController answerController = TextEditingController();
  TextEditingController feedbackController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String uid = FirebaseAuth.instance.currentUser!.uid;
  bool hasAnswer = false;
  bool hasFeedback = false;
  late String questionId;
  late String answerId;

  Container body(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 20, 12, 10),
      child: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(right: 30),
                child: Column(
                  children: [
                    const Text(
                      "Give your feedback below",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                    verticalSpacing(),
                    feedback(),
                    verticalSpacing(),
                    const Text(
                      "Give your feedback below",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                    verticalSpacing(),
                    feedback(),
                    const SizedBox(
                      height: 380,
                    ),
                  ],
                ),
              ),
            ),
          ),
          // horizontalSpacing(),
          Expanded(
            child: Column(
              children: [
                const Text(
                  "Give your feedback below",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
                verticalSpacing(),
                feedback(),
                saveButton(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  SizedBox horizontalSpacing() {
    return const SizedBox(
      width: 20,
    );
  }

  SizedBox verticalSpacing() {
    return const SizedBox(
      height: 10,
    );
  }

  GestureDetector saveButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        // if (feedbackController.text.trim().isNotEmpty) {
        //   try {
        //     if (hasFeedback) {
        //       updateFeedback();
        //       Utils.showSnackBar('Your Feedback has been updated');
        //     } else {
        //       saveFeedback();
        //       Utils.showSnackBar('Your Feedback has been saved');
        //     }
        //   } on FirebaseAuthException catch (e) {
        //     log(e);
        //     Utils.showSnackBar(e.message);
        //   }
        // } else {
        //   Utils.showSnackBar('Please answer the question to save data.');
        // }
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, 16, 0, 8),
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        decoration: BoxDecoration(
            color: const Color(0xFF2e3c96),
            borderRadius: BorderRadius.circular(30)),
        child: const Text(
          "Save",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }

  TextField answer() {
    return TextField(
      showCursor: true,
      readOnly: true,
      style: TextStyle(
        color: Colors.black,
        fontSize: 20.sp,
      ),
      keyboardType: TextInputType.none,
      minLines: 10,
      maxLines: 10,
      controller: answerController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: "Enter your Answer here",
        hintText: "Enter your Answer here",
      ),
    );
  }

  TextField feedback() {
    return TextField(
      keyboardType: TextInputType.multiline,
      style: TextStyle(
        color: Colors.black,
        fontSize: 20.sp,
      ),
      minLines: 7,
      maxLines: 7,
      controller: feedbackController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: "Enter your Feedback here",
        hintText: "Enter your Feedback here",
      ),
    );
  }

  FutureBuilder<String> question() {
    return FutureBuilder<String>(
        future: dataFuture,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              if (snapshot.hasData) {
                String data = snapshot.data!;
                return Text(
                  data,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                );
              } else {
                return const Text(
                  "Loading question from database...",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                );
              }
            case ConnectionState.done:
            default:
              if (snapshot.hasError) {
                final error = snapshot.error;
                return Text("$error");
              } else if (snapshot.hasData) {
                String data = snapshot.data!;
                if (data.isEmpty) {
                  return const Text(
                    "Question field error!!! Question missing some fields. Report Admin",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  );
                } else {
                  return Text(
                    data,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  );
                }
              } else {
                return const Text("No Data");
              }
          }
        });
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      title: const Text("Feedback"),
      backgroundColor: appBarColor,
    );
  }

  @override
  initState() {
    super.initState();
    _questionType = widget.questionType;
    _questionSubType = widget.questionSubType;

    questionId = "000";
    // loadAnswerToTextbox();
    dataFuture = getQuestion();
    totalFuture = getTotalQuestion();

    // refreshPage();
  }

  Future<void> refreshPage() async {
    int counter = 0;
    while (counter <= 10) {
      await Future.delayed(const Duration(seconds: 1));
      setState(() {});
      counter++;
    }
  }

  Future<void> loadAnswerToTextbox() async {
    await getQuestionId();
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('answers')
        .where('uid', isEqualTo: uid)
        .where('qid', isEqualTo: questionId)
        .get();
    final int documents = snapshot.docs.length;
    log('MYTAG : From Question/loadDataToTextbox/, uid = $uid , qid = $questionId , total answer = $documents');
    for (var doc in snapshot.docs) {
      if (snapshot.docs.isNotEmpty) {
        _answer = doc.get('answer');
        answerId = doc.id;
        answerController.text = _answer.toString();
        hasAnswer = true;
        log('MYTAG : Answer Found on the database');
      } else {
        hasAnswer = false;
        log('MYTAG : Answer not Found on the database');
      }
    }
  }

  Future<String> getQuestion() async {
    String question = "";
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('questions')
        .where('number', isEqualTo: '$_questionNumber')
        .where('type', isEqualTo: _questionType)
        .where('sub type', isEqualTo: _questionSubType)
        .get();
    // final int documents = snapshot.docs.length;
    // log('MYTAG : From Question/getQuestion/Type = $_questionType , sub type = $_questionSubType , _questionNumber = $_questionNumber , DataCount = $documents' );
    for (var doc in snapshot.docs) {
      if (snapshot.docs.isNotEmpty) {
        question = doc.get('question');
        questionId = doc.id;
        log('MYTAG : question Found on the database, questionId = $questionId');
      } else {
        log('MYTAG : question not Found on the database');
      }
    }

    return question;
  }

  Future<String> getQuestionId() async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('questions')
        .where('number', isEqualTo: '$_questionNumber')
        .where('type', isEqualTo: _questionType)
        .where('sub type', isEqualTo: _questionSubType)
        .get();
    for (var doc in snapshot.docs) {
      if (snapshot.docs.isNotEmpty) {
        questionId = doc.id;
        log('MYTAG : From : getQuestionId $questionId Found on the database : $questionId');
      } else {
        log('MYTAG : questionId not Found on the database');
      }
    }
    return questionId;
  }

  Future<String> getTotalQuestion() async {
    final QuerySnapshot qSnapshot = await FirebaseFirestore.instance
        .collection('questions')
        .where('type', isEqualTo: _questionType)
        .where('sub type', isEqualTo: _questionSubType)
        .get();
    final int qDocuments = qSnapshot.docs.length;
    totalQuestion = qDocuments;
    // log('MYTAG : totalQuestion = $totalQuestion');
    return qDocuments.toString();
  }

  Future<void> updateFeedback() async {
    CollectionReference answers =
        FirebaseFirestore.instance.collection('answers');
    String answer = answerController.text.trim();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    try {
      await answers.doc(answerId).update({'answer': answer});
      Utils.showSnackBar('Your Answer has been updated');
    } on FirebaseAuthException catch (e) {
      log("mytag $e");
      Utils.showSnackBar("Failed to update Answer: $e.message");
    }
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
  }

  Future saveFeedback() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    try {
      String answer = answerController.text.trim();
      final CollectionReference userCollection =
          FirebaseFirestore.instance.collection('answers');
      await userCollection.doc().set({
        'uid': uid,
        'qid': questionId,
        'answer': answer,
        'type': _questionType,
        'sub type': _questionSubType,
      });
    } on FirebaseAuthException catch (e) {
      // ignore: avoid_print
      print(e);
      Utils.showSnackBar(e.message);
    }
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
  }
}
