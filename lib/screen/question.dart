import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:page_transition/page_transition.dart';

import '../Utility/utils.dart';
import '../Widget/navigation_drawer.dart';
import '../main.dart';


class Question extends StatefulWidget {
  final String questionType;
  final String questionSubType;
  final int questionNumber;
  Question({required this.questionType, required this.questionSubType, required this.questionNumber});
  @override
  _QuestionState createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  late String _questionType="";
  late String _questionSubType="";
  late int _questionNumber=1;
  TextEditingController answerController = new TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    print("MYTAG : Question Type : " + _questionType + " Sub type : " + _questionSubType);
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.white));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      drawer: const NavigationDrawerWidget(),
      appBar: AppBar(
        title: Text("Question $_questionNumber/2"),
        backgroundColor: Color(0xFFF2811D),
        // toolbarHeight: 0,
        // backgroundColor: Colors.transparent,
        // elevation: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(PageTransition(
                      type: PageTransitionType.rightToLeftJoined,
                      childCurrent: widget,
                      child: Question(questionType: _questionType, questionSubType: _questionSubType, questionNumber: _questionNumber+1,)
                  ));
                },
                child: Icon(
                  Icons.navigate_next,
                  size: 26.0,
                ),
              )
          ),
        ],
      ),
      body: Container(
          //color: Colors.deepOrange,
          padding: EdgeInsets.fromLTRB(12, 20, 12, 10),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                alignment: Alignment.centerLeft,
                color: Colors.white,
                child: Text(
                  'What actions will you take in your work unit to support the need for autonomy?',
                  style: TextStyle(
                    //color: Color(0xFFff6600),
                    // color: Color(0xFF2e3c96),
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
              ),
              TextField(
                keyboardType: TextInputType.multiline,
                minLines: 20,
                maxLines: 20,
                controller: answerController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Enter your Answer here",
                    hintText: "Enter your Answer here"),

              ),
              GestureDetector(
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    try{
                      //resetPassword();
                    } on FirebaseAuthException catch (e) {
                      print(e);
                      Utils.showSnackBar(e.message);
                    }
                  }else{
                    Utils.showSnackBar('Please enter valid Email Address');
                  }
                },
                child:Container(
                  margin: EdgeInsets.fromLTRB(0, 16, 0, 8),
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  decoration: BoxDecoration(
                      color: Color(0xFF2e3c96),
                      borderRadius: BorderRadius.circular(30)),
                  child: Text(
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
  }
}
