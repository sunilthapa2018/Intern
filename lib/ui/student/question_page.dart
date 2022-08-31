import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';

import '../Utility/utils.dart';

class Question extends StatefulWidget {
  final String questionType;
  final String questionSubType;
  final int questionNumber;
  const Question(
      {required this.questionType,
      required this.questionSubType,
      required this.questionNumber});
  @override
  _QuestionState createState() => _QuestionState();
}

int totalQuestion = 0;

class _QuestionState extends State<Question> {
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

  @override
  Widget build(BuildContext context) {
    // log("MYTAG : Question Type : " + _questionType + " Sub type : " + _questionSubType);
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.white));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: FutureBuilder<String>(
            future: totalFuture,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  if (snapshot.hasData) {
                    String data = snapshot.data!;
                    return Text("Question $_questionNumber/$data");
                  } else {
                    return const Text("Loading");
                  }
                case ConnectionState.done:
                default:
                  if (snapshot.hasError) {
                    final error = snapshot.error;
                    return Text("$error");
                  } else if (snapshot.hasData) {
                    String data = snapshot.data!;
                    return Text("Question $_questionNumber/$data");
                  } else {
                    return const Text("No Data");
                  }
              }
            }),
        backgroundColor: const Color(0xFFF2811D),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        actions: <Widget>[
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  if (_questionNumber < totalQuestion) {
                    Navigator.of(context).push(PageTransition(
                        type: PageTransitionType.rightToLeftJoined,
                        childCurrent: widget,
                        child: Question(
                          questionType: _questionType,
                          questionSubType: _questionSubType,
                          questionNumber: _questionNumber + 1,
                        )));
                  } else {
                    Utils.showSnackBar(
                        "No more questions! You can always go back.");
                  }
                },
                child: const Icon(
                  Icons.arrow_forward,
                  size: 26.0,
                ),
              )),
        ],
      ),
      body: Container(
        //color: Colors.deepOrange,
        padding: const EdgeInsets.fromLTRB(12, 20, 12, 10),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
              alignment: Alignment.centerLeft,
              color: Colors.white,
              child: FutureBuilder<String>(
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
                  }),
            ),
            TextField(
              keyboardType: TextInputType.multiline,
              minLines: 20,
              maxLines: 20,
              controller: answerController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Enter your Answer here",
                hintText: "Enter your Answer here",
              ),
            ),
            GestureDetector(
              onTap: () {
                if (answerController.text.trim().isNotEmpty) {
                  try {
                    if (hasAnswer) {
                      updateAnswer();
                      Utils.showSnackBar('Your Answer has been updated');
                    } else {
                      saveAnswer();
                      Utils.showSnackBar('Your answer has been saved');
                    }
                  } on FirebaseAuthException catch (e) {
                    log(e.toString());
                    Utils.showSnackBar(e.message);
                  }
                } else {
                  Utils.showSnackBar(
                      'Please answer the question to save data.');
                }
              },
              child: Container(
                margin: const EdgeInsets.fromLTRB(0, 16, 0, 8),
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                decoration: BoxDecoration(
                    color: const Color(0xFF2e3c96),
                    borderRadius: BorderRadius.circular(30)),
                child: const Text(
                  "Save",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
    Navigator.of(context).pop();
  }
}