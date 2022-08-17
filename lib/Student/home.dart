import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import '../Widget/navigation_drawer.dart';
import '../screen/question_type_selection.dart';
import '../screen/video.dart';

int refreshCount = 0;
int _aTotalCount = 0;
int _bTotalCount = 0;
int _cTotalCount = 0;
int _aCompletedCount = 0;
int _bCompletedCount = 0;
int _cCompletedCount = 0;
class StudentHome extends StatefulWidget {
  const StudentHome({Key? key}) : super(key: key);
  @override
  State<StudentHome> createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  Color backgroundColor =  Color(0xFFD9D9D9);
  Color itemColor =  Color(0xFF417CA9);


  @override
  Widget build(BuildContext context) {
    // runOnce();
    WidgetsBinding.instance.addPostFrameCallback((_) {runOnce();});
    return Scaffold(
        drawer: const NavigationDrawerWidget(),
        appBar: AppBar(
          title: Text("Home"),
          backgroundColor: Color(0xFFF2811D),
          // toolbarHeight: 20,
          // backgroundColor: Colors.transparent,
          // elevation: 0.0,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        body: Container(
          color: backgroundColor,
          // color: Color(0xFF6495ED),
          child: ListView(
            // Removing any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              GestureDetector(
                child: Container(
                  //color: Color(0xFF6495ED),
                  margin: const EdgeInsets.fromLTRB(10, 20, 10, 5),
                  //height: 120,
                  decoration: BoxDecoration(
                    // color: Color(0xFFF2811D),
                      color: itemColor,
                      borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(5.0),
                        topRight: const Radius.circular(25.0),
                        bottomLeft: const Radius.circular(25.0),
                        bottomRight: const Radius.circular(5.0),
                      )
                  ),
                  // color: Color(0xFF52adc8),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(30,20,0,20),
                          child: Text(
                            'AUTONOMY',
                            style: TextStyle(
                              //color: Color(0xFFff6600),
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 24,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                      ),
                      Align(

                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0,0,20,20),
                          child: Text(
                            "Completed : " + _aCompletedCount.toString() + "/" + _aTotalCount.toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                onTap: () {
                  Navigator.of(context).push(PageTransition(
                      type: PageTransitionType.rightToLeftJoined,
                      childCurrent: widget,
                      child: VideoPlayback(questionType: 'AUTONOMY')
                  ));
                },
              ),
              GestureDetector(
                child: Container(
                  //color: Color(0xFF6495ED),
                  margin: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                  //height: 120,
                  decoration: BoxDecoration(
                      color: itemColor,
                      borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(5.0),
                        topRight: const Radius.circular(25.0),
                        bottomLeft: const Radius.circular(25.0),
                        bottomRight: const Radius.circular(5.0),
                      )
                  ),
                  // color: Color(0xFF52adc8),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(30,20,0,20),
                          child: Text(
                            'BELONGING',
                            style: TextStyle(
                              //color: Color(0xFFff6600),
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 24,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0,0,20,20),
                          child: Text(
                            "Completed : " + _bCompletedCount.toString() + "/" + _bTotalCount.toString(),
                            style: TextStyle(
                              //color: Color(0xFFff6600),

                              color: Colors.white,
                              //fontWeight: FontWeight.w400,
                              fontSize: 16,
                              //letterSpacing: 2,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                onTap: () {
                  Navigator.of(context).push(PageTransition(
                      type: PageTransitionType.rightToLeftJoined,
                      childCurrent: widget,
                      child: QuestionTypeSelection(questionType: 'BELONGING')
                  ));
                },
              ),        GestureDetector(
                child: Container(
                  //color: Color(0xFF6495ED),
                  margin: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                  //height: 120,
                  decoration: BoxDecoration(
                      color: itemColor,
                      // color: Color(0xFF46eb34),
                      borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(5.0),
                        topRight: const Radius.circular(25.0),
                        bottomLeft: const Radius.circular(25.0),
                        bottomRight: const Radius.circular(5.0),
                      )
                  ),
                  // color: Color(0xFF52adc8),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(30,20,0,20),
                          child: Text(
                            'COMPETENCE',
                            style: TextStyle(
                              //color: Color(0xFFff6600),
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 24,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0,0,20,20),
                          child: Text(
                            "Completed : " + _cCompletedCount.toString() + "/" + _cTotalCount.toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                onTap: () {
                  Navigator.of(context).push(PageTransition(
                      type: PageTransitionType.rightToLeftJoined,
                      childCurrent: widget,
                      child: QuestionTypeSelection(questionType: 'COMPETENCE')
                  ));
                },
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0,40,0,0),
                child: Image.asset('assets/complete_logo.png',
                  height: 80,
                  width: 120,
                  fit: BoxFit.contain,
                ),
              )
            ],
          ),
        )

    );
  }
  @override
  void initState(){
    //getAutonomyCount("autonomy");
    super.initState();
  }

  getAutonomyTotalCount(String type) async {
    _aTotalCount = await getTotalCount(type);
  }
  getBelongingTotalCount(String type) async {
    _bTotalCount = await getTotalCount(type);
  }
  getCompetenceTotalCount(String type) async {
    _cTotalCount = await getTotalCount(type);
  }
  getAutonomyCompletedCount(String type) async {
    _aCompletedCount = await getTotalCount(type);
  }
  getBelongingCompletedCount(String type) async {
    _bCompletedCount = await getTotalCount(type);
    // print('MYTAG : From Home.dart/getAutonomyCompletedCount/Belonging Completed Count/_bCompletedCount = $_bCompletedCount');
  }
  getCompetenceCompletedCount(String type) async {
    _cCompletedCount = await getTotalCount(type);
  }

  Future<int> getTotalCount(String type) async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('questions')
        .where('type'.toLowerCase(), isEqualTo: type.toLowerCase())
        .get();
    final int documents = snapshot.docs.length;
    //print('MYTAG : From Home.dart/getQuestionCount/questionCount = $documents');
    return documents;
  }
  Future<int> getCompletedCount(String type) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    final QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('answers')
        .where('uid', isEqualTo: uid)
        .where('type', isEqualTo: type)
        .get();
    final int documents = snapshot.docs.length;
    //print('MYTAG : From Home.dart/getQuestionCount/questionCount = $documents');
    if(refreshCount<=10) {
      setState((){});
    }
    refreshCount++;
    return documents;
  }

  runOnce() {
    getAutonomyTotalCount("Autonomy");
    getBelongingTotalCount("Belonging");
    getCompetenceTotalCount("Competence");
    getAutonomyCompletedCount("Autonomy");
    getBelongingCompletedCount("Belonging");
    getCompetenceCompletedCount("Competence");

    setState((){});

    // if(refreshCount<=10) {
    //   setState((){});
    // }
    refreshCount++;
    // print('MYTAG : From Home.dart/runOnce/refreshCount = $refreshCount');
  }
}
