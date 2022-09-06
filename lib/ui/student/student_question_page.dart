import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:motivational_leadership/ui/common/widget/type_decoration_box_1.dart';
import 'package:motivational_leadership/ui/common/widget/verticle_spacer.dart';
import 'package:motivational_leadership/utility/base_utils.dart';
import 'package:motivational_leadership/utility/colors.dart';
import 'package:motivational_leadership/utility/utils.dart';

class Question extends StatefulWidget {
  final String questionType;
  final String questionSubType;
  final int questionNumber;
  const Question(
      {super.key,
      required this.questionType,
      required this.questionSubType,
      required this.questionNumber});
  @override
  State<Question> createState() => _QuestionState();
}

int totalQuestion = 0;

class _QuestionState extends State<Question> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.white));
    return WillPopScope(
      onWillPop: () async {
        String anwerField = answerController.text.toString();
        final isEditedPage = _answer != answerController.text.toString();
        if (isEditedPage && anwerField != "") {
          final shouldPop = await showWarning(context);
          return shouldPop ?? false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: appBar(context),
        body: myBody(context),
      ),
    );
  }

  Future<bool?> showWarning(BuildContext context) async => showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
            title: const Text("Discard Changes"),
            content: const Text("Changes on this page will not be saved."),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.pop(context, false),
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor,
                ),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor,
                ),
                child: const Text("Discard"),
              ),
            ],
          ));
  late String _questionType;
  late String _questionSubType;
  late int _questionNumber;
  late String _answer = "Answer will be here";
  late Future<String> dataFuture;
  late Future<String> answerFuture;
  late Future<String> totalFuture;
  TextEditingController answerController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String uid = FirebaseAuth.instance.currentUser!.uid;
  bool hasAnswer = false;
  late String questionId;
  late String answerId;

  myBody(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: Column(
          children: [
            question(),
            verticleSpacer(32),
            answer(),
            verticleSpacer(6),
            saveButton(context),
          ],
        ),
      ),
    );
  }

  GestureDetector saveButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (answerController.text.trim().isNotEmpty) {
          try {
            if (hasAnswer) {
              updateAnswer();
              loadDataToTextbox();
              Utils.showSnackBar('Your Answer has been updated');
            } else {
              saveAnswer();
              loadDataToTextbox();
              Utils.showSnackBar('Your answer has been saved');
            }
          } on FirebaseAuthException catch (e) {
            log(e.toString());
            Utils.showSnackBar(e.message);
          }
        } else {
          Utils.showSnackBar('Please answer the question to save data.');
        }
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, 8, 0, 8),
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width / 2,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        decoration: myTypeBoxDecoration1(),
        child: const Text(
          "Save",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }

  TextField answer() {
    return TextField(
      keyboardType: TextInputType.multiline,
      minLines: 16,
      maxLines: null,
      controller: answerController,
      style: myTextStyle2(),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        border: const OutlineInputBorder(),
        hintText: "Enter your Answer here",
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: iconColor, width: 1.0),
          // borderRadius: BorderRadius.circular(20.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: iconColor, width: 1.0),
          // borderRadius: BorderRadius.circular(20.0),
        ),
        prefixIconColor: iconColor,
      ),
    );
  }

  Align question() {
    return Align(
      alignment: Alignment.centerLeft,
      child: FutureBuilder<String>(
          future: dataFuture,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                if (snapshot.hasData) {
                  String data = snapshot.data!;
                  return Text(
                    data,
                    style: myTextStyle(),
                  );
                } else {
                  return Text(
                    "Loading question from database...",
                    style: myTextStyle(),
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
                    return Text(
                      "Question field error!!! Question missing some fields. Report Admin",
                      style: myTextStyle(),
                    );
                  } else {
                    return Text(
                      data,
                      style: myTextStyle(),
                    );
                  }
                } else {
                  return const Text("No Data");
                }
            }
          }),
    );
  }

  TextStyle myTextStyle() {
    return const TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black87,
      fontWeight: FontWeight.w400,
      fontSize: 20,
    );
  }

  TextStyle myTextStyle2() {
    return const TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black87,
      fontWeight: FontWeight.w300,
      fontSize: 16,
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      title: appBarTitle(),
      elevation: 0,
      backgroundColor: appBarColor,
      iconTheme: IconThemeData(color: iconColor),
      actions: <Widget>[
        Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                if (_questionNumber < totalQuestion) {
                  navigateTo(
                      context: context,
                      nextPage: Question(
                        questionType: _questionType,
                        questionSubType: _questionSubType,
                        questionNumber: _questionNumber + 1,
                      ),
                      currentPage: widget);
                } else {
                  Utils.showSnackBar(
                      "No more questions! You can always go back.");
                }
              },
              // child: const Icon(
              //   Icons.arrow_forward,
              //   size: 26.0,
              // ),
              child: appBarNextButton(),
            )),
      ],
    );
  }

  FutureBuilder<void> appBarNextButton() {
    return FutureBuilder<String>(
        future: totalFuture,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.done:
            default:
              if (snapshot.hasError) {
                final error = snapshot.error;
                return Text("$error");
              } else if (snapshot.hasData) {
                String data = snapshot.data!;
                int dataTemp = int.tryParse(data) ?? 0;
                if (_questionNumber < dataTemp) {
                  return myIcon();
                }
              }
              return Container();
          }
        });
  }

  Icon myIcon() {
    return const Icon(
      Icons.arrow_forward,
      size: 26.0,
    );
  }

  FutureBuilder<String> appBarTitle() {
    return FutureBuilder<String>(
        future: totalFuture,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              if (snapshot.hasData) {
                String data = snapshot.data!;
                return Text(
                  "Question $_questionNumber/$data",
                  style: Theme.of(context).textTheme.headline4,
                );
              } else {
                return Text(
                  "Question 0/0",
                  style: Theme.of(context).textTheme.headline4,
                );
              }
            case ConnectionState.done:
            default:
              if (snapshot.hasError) {
                final error = snapshot.error;
                return Text("$error");
              } else if (snapshot.hasData) {
                String data = snapshot.data!;
                return Text(
                  "Question $_questionNumber/$data",
                  style: Theme.of(context).textTheme.headline4,
                );
              } else {
                return Text(
                  "No Data",
                  style: Theme.of(context).textTheme.headline4,
                );
              }
          }
        });
  }

  @override
  initState() {
    super.initState();
    _questionType = widget.questionType;
    _questionSubType = widget.questionSubType;
    _questionNumber = widget.questionNumber;

    questionId = "000";
    loadDataToTextbox();
    dataFuture = getQuestion();
    totalFuture = getTotalQuestion();
  }

  Future<void> loadDataToTextbox() async {
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

  Future<void> updateAnswer() async {
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
    if (!mounted) return;
    Navigator.of(context).pop();
  }

  Future saveAnswer() async {
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
      log(e.toString());
      Utils.showSnackBar(e.message);
    }
    if (!mounted) return;
    Navigator.of(context).pop();
  }
}
