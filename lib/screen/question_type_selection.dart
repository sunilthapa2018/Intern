import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:motivational_leadership/screen/question.dart';
import 'package:page_transition/page_transition.dart';
import '../Widget/navigation_drawer.dart';


int refreshCount = 0;
int _aTotalCount = 0;
int _bTotalCount = 0;
int _cTotalCount = 0;
int _dTotalCount = 0;
int _eTotalCount = 0;
int _fTotalCount = 0;

int _aCompletedCount = 0;
int _bCompletedCount = 0;
int _cCompletedCount = 0;
int _dCompletedCount = 0;
int _eCompletedCount = 0;
int _fCompletedCount = 0;
class QuestionTypeSelection extends StatefulWidget {
  final String questionType;

  QuestionTypeSelection({required this.questionType});
  @override
  _QuestionTypeSelectionState createState() => _QuestionTypeSelectionState();
}

class _QuestionTypeSelectionState extends State<QuestionTypeSelection> {
  late String _questionType="";
  Color backgroundColor =  Color(0xFFD9D9D9);
  Color itemColor =  Color(0xFF417CA9);
  @override
  Widget build(BuildContext context) {
    // runOnce();
    WidgetsBinding.instance.addPostFrameCallback((_) {runOnce();});
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundColor,
        drawer: const NavigationDrawerWidget(),
      appBar: AppBar(
        title: Text("Question Type Selection"),
        backgroundColor: Color(0xFFF2811D),
        // toolbarHeight: 0,
        // backgroundColor: Colors.transparent,
        // elevation: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
        body: ListView(
          padding: EdgeInsets.zero,
          children: [
            GestureDetector(
              child: Container(
                //color: Color(0xFF6495ED),
                margin: const EdgeInsets.fromLTRB(10, 20, 10, 5),
                decoration: BoxDecoration(
                    color: itemColor,
                    borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(5.0),
                      topRight: const Radius.circular(20.0),
                      bottomLeft: const Radius.circular(20.0),
                      bottomRight: const Radius.circular(5.0),
                    )
                ),

                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(30,20,0,10),
                        child: Text(
                          'Actions',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 26,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0,0,20,20),
                        child: Text(
                          'Completed : $_aCompletedCount/$_aTotalCount',
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
                    child: Question(questionType: _questionType, questionSubType: 'Actions', questionNumber: 1,)
                ));
              },
            ),
            GestureDetector(
              child: Container(
                //color: Color(0xFF6495ED),
                margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                decoration: BoxDecoration(
                    color: itemColor,
                    borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(5.0),
                      topRight: const Radius.circular(20.0),
                      bottomLeft: const Radius.circular(20.0),
                      bottomRight: const Radius.circular(5.0),
                    )
                ),
                // color: Color(0xFF52adc8),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(30,20,0,10),
                        child: Text(
                          'Overcoming Challenges',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 26,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0,0,20,20),
                        child: Text(
                          'Completed : $_bCompletedCount/$_bTotalCount',
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
                    child: Question(questionType: _questionType, questionSubType: 'Overcoming Challenges', questionNumber: 1,)
                ));
              },
            ),
            GestureDetector(
              child: Container(
                //color: Color(0xFF6495ED),
                margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                decoration: BoxDecoration(
                    color: itemColor,
                    borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(5.0),
                      topRight: const Radius.circular(20.0),
                      bottomLeft: const Radius.circular(20.0),
                      bottomRight: const Radius.circular(5.0),
                    )
                ),
                // color: Color(0xFF52adc8),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(30,20,0,10),
                        child: Text(
                          'Success Indicators (KPIs)',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 26,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0,0,20,20),
                        child: Text(
                          'Completed : $_cCompletedCount/$_cTotalCount',
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
                    child: Question(questionType: _questionType, questionSubType: 'Success Indicators (KPIs)', questionNumber: 1,)
                ));
              },
            ),
            GestureDetector(
              child: Container(
                //color: Color(0xFF6495ED),
                margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                decoration: BoxDecoration(
                    color: itemColor,
                    borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(5.0),
                      topRight: const Radius.circular(20.0),
                      bottomLeft: const Radius.circular(20.0),
                      bottomRight: const Radius.circular(5.0),
                    )
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(30,20,0,10),
                        child: Text(
                          'Implementation',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 26,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0,0,20,20),
                        child: Text(
                          'Completed : $_dCompletedCount/$_dTotalCount',
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
                    child: Question(questionType: _questionType, questionSubType: 'Implementation', questionNumber: 1,)
                ));
              },
            ),
            GestureDetector(
              child: Container(
                //color: Color(0xFF6495ED),
                margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                decoration: BoxDecoration(
                    color: itemColor,
                    borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(5.0),
                      topRight: const Radius.circular(20.0),
                      bottomLeft: const Radius.circular(20.0),
                      bottomRight: const Radius.circular(5.0),
                    )
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(30,20,0,10),
                        child: Text(
                          'Impact and Outcome',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 26,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0,0,20,20),
                        child: Text(
                          'Completed : $_eCompletedCount/$_eTotalCount',
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
                    child: Question(questionType: _questionType, questionSubType: 'Impact and Outcome', questionNumber: 1,)
                ));
              },
            ),
            GestureDetector(
              child: Container(
                margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                decoration: BoxDecoration(
                    color: itemColor,
                    borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(5.0),
                      topRight: const Radius.circular(20.0),
                      bottomLeft: const Radius.circular(20.0),
                      bottomRight: const Radius.circular(5.0),
                    )
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(30,20,0,10),
                        child: Text(
                          'Future',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 26,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0,0,20,20),
                        child: Text(
                          'Completed : $_fCompletedCount/$_fTotalCount',
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
                    child: Question(questionType: _questionType, questionSubType: 'Future', questionNumber: 1,)
                ));
              },
            ),
          ],
        )
    );
  }
  runOnce() {
    getATotalCount("Actions");
    getBTotalCount("Overcoming Challenges");
    getCTotalCount("Success Indicators (KPIs)");
    getDTotalCount("Implementation");
    getETotalCount("Impact and Outcome");
    getFTotalCount("Future");

    getACompletedCount("Actions");
    getBCompletedCount("Overcoming Challenges");
    getCCompletedCount("Success Indicators (KPIs)");
    getDCompletedCount("Implementation");
    getECompletedCount("Impact and Outcome");
    getFCompletedCount("Future");

    //setState((){});

    // if(refreshCount<=10) {
    //   setState((){});
    // }
    // refreshCount++;
    // print('MYTAG : From Home.dart/runOnce/refreshCount = $refreshCount');
  }

  getATotalCount(String subType) async {
    _aTotalCount = await getTotalCount(subType);
  }
  getBTotalCount(String subType) async {
    _bTotalCount = await getTotalCount(subType);
  }
  getCTotalCount(String subType) async {
    _cTotalCount = await getTotalCount(subType);
  }
  getDTotalCount(String subType) async {
    _dTotalCount = await getTotalCount(subType);
  }
  getETotalCount(String subType) async {
    _eTotalCount = await getTotalCount(subType);
  }
  getFTotalCount(String subType) async {
    _fTotalCount = await getTotalCount(subType);
  }

  Future<int> getTotalCount(String subType) async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('questions')
        .where(('type'.toLowerCase()), isEqualTo: _questionType.toLowerCase())
        .where(('sub type'.toLowerCase()), isEqualTo: subType.toLowerCase())
        .get();
    final int documents = snapshot.docs.length;
    print('MYTAG : From Question_type_selection.dart/getTotalCount/Type = $_questionType , sub type = $subType , total = $documents');
    return documents;
  }

  getACompletedCount(String subType) async {
    _aCompletedCount = await getCompletedCount(subType);
  }
  getBCompletedCount(String subType) async {
    _bCompletedCount = await getCompletedCount(subType);
  }
  getCCompletedCount(String subType) async {
    _cCompletedCount = await getCompletedCount(subType);
  }
  getDCompletedCount(String subType) async {
    _dCompletedCount = await getCompletedCount(subType);
  }
  getECompletedCount(String subType) async {
    _eCompletedCount = await getCompletedCount(subType);
  }
  getFCompletedCount(String subType) async {
    _fCompletedCount = await getCompletedCount(subType);
  }

  Future<int> getCompletedCount(String subType) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    final QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('answers')
        .where('uid', isEqualTo: uid)
        .where('type'.toLowerCase(), isEqualTo: _questionType.toLowerCase())
        .where('sub type'.toLowerCase(), isEqualTo: subType.toLowerCase())
        .get();
    final int documents = snapshot.docs.length;
    print('MYTAG : From Question_type_selection.dart/getTotalCount/Type = $_questionType , sub type = $subType , Completed = $documents');
    setState((){});
    // if(refreshCount<=10) {
    //   setState((){});
    // }
    // refreshCount++;
    return documents;
  }
  @override
  initState() {
    super.initState();
    _questionType = widget.questionType;
  }
}

