import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motivational_leadership/services/database.dart';
import 'package:motivational_leadership/utility/colors.dart';
import 'package:motivational_leadership/utility/utils.dart';
import 'package:motivational_leadership/utility/values.dart';

class CoachFeedbackPage extends StatefulWidget {
  final String questionType;
  final String questionSubType;
  final String uId;
  const CoachFeedbackPage(
      {super.key,
      required this.questionType,
      required this.questionSubType,
      required this.uId});
  @override
  State<CoachFeedbackPage> createState() => _CoachFeedbackPageState();
}

int totalQuestion = 0;

class _CoachFeedbackPageState extends State<CoachFeedbackPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: coachBackgroundColor,
        appBar: appBar(context),
        body: body(context),
      ),
    );
  }

  late String _questionType;
  late String _questionSubType;
  late int _questionNumber = 0;
  late String _answer = "Question not Answered";
  late String _feedback = "Feedback not given";
  late Future<String> questionFuture;
  late Future<String> answerFuture;
  late Future<String> feedbackFuture;
  late Future<String> totalFuture;
  TextEditingController feedbackController = TextEditingController();

  bool hasFeedback = false;
  late String questionId;
  late String answerId;
  late String feedbackId;
  late int qCount = 0;

  Container body(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
      child: Row(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getQuestionCount(),
                builder: (context, snapshot) {
                  String questionCount = snapshot.data.toString().trim();
                  qCount = int.tryParse(questionCount) ?? 0;

                  return ListView.builder(
                      itemCount: qCount,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 25),
                          child: Column(
                            children: [
                              verticalSpacing(),
                              question(),
                              verticalSpacing(),
                              answerContainer(),
                              verticalSpacing(),
                            ],
                          ),
                        );
                      });
                }),
          ),
          // horizontalSpacing(),
          Expanded(
            child: Align(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    verticalSpacing(),
                    txtFeedback(),
                    verticalSpacing(),
                    feedback(),
                    saveButton(context),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container answerContainer() {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          border: Border.all(
            color: coachAppBarColor,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(3))),
      child: Align(alignment: Alignment.centerLeft, child: answer()),
    );
  }

  Text txtFeedback() {
    return const Text(
      "Give your feedback below",
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w600,
        fontSize: 20,
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
        if (feedbackController.text.trim().isNotEmpty) {
          try {
            if (hasFeedback) {
              updateFeedback();
              Utils.showSnackBar('Your Feedback has been updated');
            } else {
              saveFeedback();
              Utils.showSnackBar('Your Feedback has been saved');
            }
          } on FirebaseAuthException catch (e) {
            Utils.showSnackBar(e.message);
          }
        } else {
          Utils.showSnackBar('Please type something at feedback to save data.');
        }
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, 16, 0, 8),
        alignment: Alignment.center,
        width: buttonXXSmallWidth,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
            color: buttonColor, borderRadius: BorderRadius.circular(30)),
        child: Text(
          "Save",
          style: TextStyle(fontSize: 16.sp, color: Colors.white),
        ),
      ),
    );
  }

  Text answerText(String label) {
    return Text(
      label,
      style: TextStyle(
        color: Colors.black87,
        fontSize: 18.sp,
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
      minLines: 10,
      maxLines: null,
      controller: feedbackController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: "Enter your Feedback here",
        hintText: "Enter your Feedback here",
      ),
    );
  }

  FutureBuilder<String> question() {
    if (_questionNumber < qCount) {
      _questionNumber++;
    }

    questionFuture = getQuestion();
    return FutureBuilder<String>(
        future: questionFuture,
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

  FutureBuilder<String> answer() {
    answerFuture = getAnswer();
    return FutureBuilder<String>(
        future: answerFuture,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              if (snapshot.hasData) {
                String data = snapshot.data!;
                return answerText(data);
              } else {
                return answerText("Loading Answer from database...");
              }
            case ConnectionState.done:
            default:
              if (snapshot.hasError) {
                final error = snapshot.error;
                return Text("$error");
              } else if (snapshot.hasData) {
                String data = snapshot.data!;
                if (data.isEmpty) {
                  return answerText(
                      "Answer field error!!! Answer missing some fields. Report Admin");
                } else {
                  return answerText(data);
                }
              } else {
                return answerText('no data');
              }
          }
        });
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      title: const Text("Feedback"),
      backgroundColor: coachAppBarColor,
    );
  }

  @override
  initState() {
    super.initState();
    _questionType = widget.questionType;
    _questionSubType = widget.questionSubType;
    _questionNumber = 0;

    questionId = "000";
    loadFeedbackToTextbox();
    questionFuture = getQuestion();
    answerFuture = getAnswer();
    totalFuture = getTotalQuestion();

    // refreshPage();
  }

  Future<String> getAnswer() async {
    await getQuestionId();
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('answers')
        .where('uid', isEqualTo: widget.uId)
        .where('qid', isEqualTo: questionId)
        .get();
    for (var doc in snapshot.docs) {
      if (snapshot.docs.isNotEmpty) {
        _answer = doc.get('answer');
        answerId = doc.id;
        return _answer;
      } else {
        return "Answer not Found on the database.";
      }
    }

    return _answer;
  }

  Future<String> getQuestion() async {
    String question = "";
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('questions')
        .where('number', isEqualTo: '$_questionNumber')
        .where('type', isEqualTo: _questionType)
        .where('sub type', isEqualTo: _questionSubType)
        .get();
    for (var doc in snapshot.docs) {
      if (snapshot.docs.isNotEmpty) {
        question = doc.get('question');
        questionId = doc.id;
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
    return qDocuments.toString();
  }

  Future<void> updateFeedback() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    final String uID = FirebaseAuth.instance.currentUser!.uid;
    CollectionReference feedbackCollection =
        FirebaseFirestore.instance.collection('feedbacks');
    String feedback = feedbackController.text.trim();

    try {
      await feedbackCollection.doc(feedbackId).update({
        'feedback': feedback,
        'coach_id': uID,
      });
      Utils.showSnackBar('Your Feedback has been updated');
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar("Failed to update Feedback: $e.message");
    }

    if (!mounted) return;
    Navigator.of(context).pop();
  }

  Future saveFeedback() async {
    final String uID = FirebaseAuth.instance.currentUser!.uid;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      String feedback = feedbackController.text.trim();
      final CollectionReference feedbackCollection =
          FirebaseFirestore.instance.collection('feedbacks');
      await feedbackCollection.doc().set({
        'student_id': widget.uId,
        'coach_id': uID,
        'feedback': feedback,
        'type': _questionType,
        'sub type': _questionSubType,
      });
    } on FirebaseAuthException catch (e) {
      // ignore: avoid_print
      print(e);
      Utils.showSnackBar(e.message);
    }

    if (!mounted) return;
    Navigator.of(context).pop();
  }

  Future getQuestionCount() async {
    String totalQuestions = await DatabaseService.getTotalQuestion(
        widget.questionType, widget.questionSubType);
    int qCount = int.tryParse(totalQuestions) ?? 0;
    return qCount;
  }

  Future<void> loadFeedbackToTextbox() async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('feedbacks')
        .where('student_id', isEqualTo: widget.uId)
        .where('type', isEqualTo: _questionType)
        .where('sub type', isEqualTo: _questionSubType)
        .get();
    for (var doc in snapshot.docs) {
      if (snapshot.docs.isNotEmpty) {
        _feedback = doc.get('feedback');
        feedbackId = doc.id;
        feedbackController.text = _feedback.toString();
        hasFeedback = true;
      } else {
        hasFeedback = false;
      }
    }
  }
}
