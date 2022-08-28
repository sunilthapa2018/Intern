import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:motivational_leadership/ui/student/question_display_page.dart';
import 'package:motivational_leadership/services/database.dart';
import 'package:motivational_leadership/utility/base_util.dart';
import 'package:page_transition/page_transition.dart';

class FeedbackSelection extends StatefulWidget {
  final String userID;

  FeedbackSelection({required this.userID});
  @override
  _FeedbackSelectionState createState() => _FeedbackSelectionState();
}

class _FeedbackSelectionState extends State<FeedbackSelection> {
  late String _questionType="";
  Color backgroundColor =  Color(0xFFD9D9D9);
  Color itemColor =  Color(0xFF417CA9);
  Color appBarColor = Color(0xFFF2811D);

  late Future<String> dataAFuture;
  late Future<String> dataBFuture;
  late Future<String> dataCFuture;
  late Future<String> dataDFuture;
  late Future<String> dataEFuture;
  late Future<String> dataFFuture;
  Text txtA = Text("Loading...",style: TextStyle(color: Colors.white,fontSize: 16,),);
  Text txtB = Text("Loading...",style: TextStyle(color: Colors.white,fontSize: 16,),);
  Text txtC = Text("Loading...",style: TextStyle(color: Colors.white,fontSize: 16,),);
  Text txtD = Text("Loading...",style: TextStyle(color: Colors.white,fontSize: 16,),);
  Text txtE = Text("Loading...",style: TextStyle(color: Colors.white,fontSize: 16,),);
  Text txtF = Text("Loading...",style: TextStyle(color: Colors.white,fontSize: 16,),);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundColor,
        // drawer: const NavigationDrawerWidget(),
      appBar: AppBar(
        title: Text("Question Type Selection"),
        backgroundColor: Color(0xFFF2811D),
        // toolbarHeight: 0,
        // backgroundColor: Colors.transparent,
        // elevation: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
        body: RefreshIndicator(
          onRefresh: _refresh,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 330,
                    margin: EdgeInsets.fromLTRB(10, 20, 10, 10),
                    padding: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: itemColor,
                          width: 1),
                      borderRadius: BorderRadius.circular(10),
                      shape: BoxShape.rectangle,
                    ),
                    child: ListView(
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      children: [
                        GestureDetector(
                          child: Container(
                            //color: Color(0xFF6495ED),
                            margin: const EdgeInsets.fromLTRB(10, 10, 10, 5),
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
                                    padding: const EdgeInsets.fromLTRB(30,10,0,10),
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
                                    padding: const EdgeInsets.fromLTRB(0,0,20,10),
                                    child: FutureBuilder<String>(
                                        future: dataAFuture,
                                        builder: (context, snapshot) {
                                          if (snapshot.hasError) {
                                            final error = snapshot.error;
                                            return txtA = Text("$error");
                                          } else if (snapshot.hasData) {
                                            String data = snapshot.data!;
                                            return txtA = Text("$data",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                              ),
                                            );
                                          } else {
                                            return txtA = Text("Loading...",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                              ),
                                            );
                                          }
                                        }
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
                                    padding: const EdgeInsets.fromLTRB(30,10,0,10),
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
                                    padding: const EdgeInsets.fromLTRB(0,0,20,10),
                                    child: FutureBuilder<String>(
                                        future: dataBFuture,
                                        builder: (context, snapshot) {
                                          if (snapshot.hasError) {
                                            final error = snapshot.error;
                                            return txtB = Text("$error");
                                          } else if (snapshot.hasData) {
                                            String data = snapshot.data!;
                                            return txtB = Text("$data",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                              ),
                                            );
                                          } else {
                                            return txtB = Text("Loading...",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                              ),
                                            );
                                          }
                                        }
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
                                    padding: const EdgeInsets.fromLTRB(30,10,0,10),
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
                                    padding: const EdgeInsets.fromLTRB(0,0,20,10),
                                    child: FutureBuilder<String>(
                                        future: dataCFuture,
                                        builder: (context, snapshot) {
                                          if (snapshot.hasError) {
                                            final error = snapshot.error;
                                            return txtC = Text("$error");
                                          } else if (snapshot.hasData) {
                                            String data = snapshot.data!;
                                            return txtC = Text("$data",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                              ),
                                            );
                                          } else {
                                            return txtC = Text("Loading...",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                              ),
                                            );
                                          }
                                        }
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
                          onTap: () async {
                            String txtAValue = txtA.data.toString();
                            String txtBValue = txtB.data.toString();
                            String txtCValue = txtC.data.toString();

                            bool aCompleted = getCompletedStatus(txtAValue);
                            bool bCompleted = getCompletedStatus(txtBValue);
                            bool cCompleted = getCompletedStatus(txtCValue);
                            print("MYTAG : $aCompleted , $bCompleted , $cCompleted");
                            String uid = FirebaseAuth.instance.currentUser!.uid;
                            if(aCompleted & bCompleted & cCompleted){
                              String dataAlreadyPresent = await DatabaseService.hasThisDocument("submissions","$uid");
                              print("Mytag : dataAlreadyPresent = " + dataAlreadyPresent);
                              if(dataAlreadyPresent=="true"){
                                //edit data in database
                                DatabaseService.updateSubmissions("plan","true");
                                Utils.showSnackBar("Your answer has been Edited and re-submitted for PLAN section");
                                // print("MYTAG : updateSubmissions Completed ...");
                              }else{
                                //write new data to database
                                DatabaseService.addSubmissions("true", "false");
                                Utils.showSnackBar("Your answer has been submitted for PLAN section");
                                // print("MYTAG : addSubmissions Completed ...");
                              }
                            }else{
                              Utils.showSnackBar("Please complete all sections of PLAN before you can submit");
                              // print("MYTAG : Not Completed");
                            }
                          },
                          child:UnconstrainedBox(
                            child: Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width/3,
                              margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              decoration: BoxDecoration(
                                  color: appBarColor,
                                  borderRadius: BorderRadius.circular(30)),
                              child: Text(
                                "Submit",
                                style: TextStyle(fontSize: 16, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                      left: 50,
                      top: 12,
                      child: Container(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        color: backgroundColor,
                        child: Text(
                          'Plan',
                          style: TextStyle(
                            color: itemColor,
                            fontWeight: FontWeight.w800,
                            fontSize: 16,),
                        ),
                      )
                  ),
                ],
              ),
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 330,
                    margin: EdgeInsets.fromLTRB(10, 15, 10, 10),
                    padding: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: itemColor,
                          width: 1),
                      borderRadius: BorderRadius.circular(10),
                      shape: BoxShape.rectangle,
                    ),
                    child: ListView(
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      children: [
                        GestureDetector(
                          child: Container(
                            //color: Color(0xFF6495ED),
                            margin: const EdgeInsets.fromLTRB(10, 10, 10, 5),
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
                                    padding: const EdgeInsets.fromLTRB(30,10,0,10),
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
                                    padding: const EdgeInsets.fromLTRB(0,0,20,10),
                                    child: FutureBuilder<String>(
                                        future: dataDFuture,
                                        builder: (context, snapshot) {
                                          if (snapshot.hasError) {
                                            final error = snapshot.error;
                                            return txtD = Text("$error");
                                          } else if (snapshot.hasData) {
                                            String data = snapshot.data!;
                                            return txtD = Text("$data",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                              ),
                                            );
                                          } else {
                                            return txtD = Text("Loading...",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                              ),
                                            );
                                          }
                                        }
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
                                    padding: const EdgeInsets.fromLTRB(30,10,0,10),
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
                                    padding: const EdgeInsets.fromLTRB(0,0,20,10),
                                    child: FutureBuilder<String>(
                                        future: dataEFuture,
                                        builder: (context, snapshot) {
                                          if (snapshot.hasError) {
                                            final error = snapshot.error;
                                            return txtE = Text("$error");
                                          } else if (snapshot.hasData) {
                                            String data = snapshot.data!;
                                            return txtE = Text("$data",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                              ),
                                            );
                                          } else {
                                            return txtE = Text("Loading...",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                              ),
                                            );
                                          }
                                        }
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
                                    padding: const EdgeInsets.fromLTRB(30,10,0,10),
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
                                    padding: const EdgeInsets.fromLTRB(0,0,20,10),
                                    child: FutureBuilder<String>(
                                        future: dataFFuture,
                                        builder: (context, snapshot) {
                                          if (snapshot.hasError) {
                                            final error = snapshot.error;
                                            return txtF = Text("$error");
                                          } else if (snapshot.hasData) {
                                            String data = snapshot.data!;
                                            return txtF = Text("$data",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                              ),
                                            );
                                          } else {
                                            return txtF = Text("Loading...",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                              ),
                                            );
                                          }
                                        }
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
                        GestureDetector(
                          onTap: () async {
                            String txtDValue = txtD.data.toString();
                            String txtEValue = txtE.data.toString();
                            String txtFValue = txtF.data.toString();
                            bool dCompleted = getCompletedStatus(txtDValue);
                            bool eCompleted = getCompletedStatus(txtEValue);
                            bool fCompleted = getCompletedStatus(txtFValue);
                            print("MYTAG : $dCompleted , $eCompleted , $fCompleted");
                            String uid = FirebaseAuth.instance.currentUser!.uid;
                            if(dCompleted & eCompleted & fCompleted){
                              String dataAlreadyPresent = await DatabaseService.hasThisDocument("submissions","$uid");
                              print("Mytag : dataAlreadyPresent = " + dataAlreadyPresent);
                              if(dataAlreadyPresent=="true"){
                                //edit data in database
                                DatabaseService.updateSubmissions("reflect","true");
                                Utils.showSnackBar("Your answer has been Edited and re-submitted for Reflect section");
                                print("MYTAG : updateSubmissions Completed ...");
                              }else{
                                //write new data to database
                                DatabaseService.addSubmissions("false", "true");
                                Utils.showSnackBar("Your answer has been submitted for Reflect section");
                                print("MYTAG : addSubmissions Completed ...");
                              }

                            }else{
                              Utils.showSnackBar("Please complete all sections of REFLECT before you can submit");
                              print("MYTAG : Not Completed");
                            }
                          },
                          child:UnconstrainedBox(
                            child: Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width/3,
                              margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              decoration: BoxDecoration(
                                  color: appBarColor,
                                  borderRadius: BorderRadius.circular(30)),
                              child: Text(
                                "Submit",
                                style: TextStyle(fontSize: 16, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                      left: 50,
                      top: 7,
                      child: Container(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        color: backgroundColor,
                        child: Text(
                          'Reflect',
                          style: TextStyle(
                            color: itemColor,
                            fontWeight: FontWeight.w800,
                            fontSize: 16,),
                        ),
                      )
                  ),
                ],
              ),
            ],
          ),
        )
    );
  }

  Future<String> getData(String subType) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    final QuerySnapshot qSnapshot = await FirebaseFirestore.instance.collection('questions')
        .where('type', isEqualTo: _questionType)
        .where('sub type', isEqualTo: subType)
        .get();
    final int qDocuments = qSnapshot.docs.length;

    final QuerySnapshot aSnapshot = await FirebaseFirestore.instance.collection('answers')
        .where('uid', isEqualTo: uid)
        .where('type', isEqualTo: _questionType)
        .where('sub type', isEqualTo: subType)
        .get();
    final int aDocuments = aSnapshot.docs.length;
    String returnText = "Completed : " + aDocuments.toString() + "/" + qDocuments.toString();
    // print('MYTAG : From Question_type_selection.dart/getData/Type = $_questionType , sub type = $subType , Completed = $aDocuments, Total = $qDocuments' );
    return returnText;
  }
  @override
  initState() {
    super.initState();
    _questionType = widget.userID;
    dataAFuture = getData("Actions");
    dataBFuture = getData("Overcoming Challenges");
    dataCFuture = getData("Success Indicators (KPIs)");
    dataDFuture = getData("Implementation");
    dataEFuture = getData("Impact and Outcome");
    dataFFuture = getData("Future");
    refreshPage();
  }

  Future<void> refreshPage() async {
    int counter=0;
    while(counter <= 1000){
      await Future.delayed(Duration(milliseconds: 10));
      setState((){});
      counter++;
    }
  }

  Future<void> _refresh() async {
    await Future.wait([
      dataAFuture = getData("Actions"),
      dataBFuture = getData("Overcoming Challenges"),
      dataCFuture = getData("Success Indicators (KPIs)"),
      dataDFuture = getData("Implementation"),
      dataEFuture = getData("Impact and Outcome"),
      dataFFuture = getData("Future"),
    ]);
    this.setState((){});
  }

  bool getCompletedStatus(String Value) {
    final split = Value.split(':');
    final split2 = split[1].split('/');
    String completed = split2[0].trim();
    String total = split2[1].trim();
    if(completed == total){
      return true;
    }else{
      return false;
    }
  }
}

