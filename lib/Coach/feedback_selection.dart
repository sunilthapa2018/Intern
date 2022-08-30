import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:motivational_leadership/Coach/feedback_page.dart';
import 'package:motivational_leadership/Utility/base_utils.dart';
import 'package:motivational_leadership/Utility/colors.dart';

class FeedbackSelection extends StatefulWidget {
  final String userID;
  const FeedbackSelection({required this.userID});
  @override
  _FeedbackSelectionState createState() => _FeedbackSelectionState();
}

class _FeedbackSelectionState extends State<FeedbackSelection> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: backgroundColor,
        appBar: appBar(),
        body: RefreshIndicator(
          onRefresh: _refresh,
          child: body(context),
        ));
  }

  late String _questionType = "";
  late Future<String> dataAFuture,
      dataBFuture,
      dataCFuture,
      dataDFuture,
      dataEFuture,
      dataFFuture;
  late Text txtA, txtB, txtC, txtD, txtE, txtF;

  GestureDetector future(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        decoration: BoxDecoration(
            color: itemColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(5.0),
              topRight: Radius.circular(20.0),
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(5.0),
            )),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.fromLTRB(30, 10, 0, 10),
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
                padding: const EdgeInsets.fromLTRB(0, 0, 20, 10),
                child: FutureBuilder<String>(
                    future: dataFFuture,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        final error = snapshot.error;
                        return txtF = Text("$error");
                      } else if (snapshot.hasData) {
                        String data = snapshot.data!;
                        return txtF = Text(
                          data,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        );
                      } else {
                        return txtF = const Text(
                          "Loading...",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        );
                      }
                    }),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        navigateTo(
            context: context,
            nextPage: FeedbackPage(
              questionType: _questionType,
              questionSubType: 'Future',
            ),
            currentPage: widget);
      },
    );
  }

  GestureDetector impactAndOutcome(BuildContext context) {
    return GestureDetector(
      child: Container(
        //color: Color(0xFF6495ED),
        margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        decoration: BoxDecoration(
            color: itemColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(5.0),
              topRight: Radius.circular(20.0),
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(5.0),
            )),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.fromLTRB(30, 10, 0, 10),
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
                padding: const EdgeInsets.fromLTRB(0, 0, 20, 10),
                child: FutureBuilder<String>(
                    future: dataEFuture,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        final error = snapshot.error;
                        return txtE = Text("$error");
                      } else if (snapshot.hasData) {
                        String data = snapshot.data!;
                        return txtE = Text(
                          data,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        );
                      } else {
                        return txtE = const Text(
                          "Loading...",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        );
                      }
                    }),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        navigateTo(
            context: context,
            nextPage: FeedbackPage(
              questionType: _questionType,
              questionSubType: 'Impact and Outcome',
            ),
            currentPage: widget);
      },
    );
  }

  GestureDetector implementation(BuildContext context) {
    return GestureDetector(
      child: Container(
        //color: Color(0xFF6495ED),
        margin: const EdgeInsets.fromLTRB(10, 10, 10, 5),
        decoration: BoxDecoration(
            color: itemColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(5.0),
              topRight: Radius.circular(20.0),
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(5.0),
            )),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.fromLTRB(30, 10, 0, 10),
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
                padding: const EdgeInsets.fromLTRB(0, 0, 20, 10),
                child: FutureBuilder<String>(
                    future: dataDFuture,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        final error = snapshot.error;
                        return txtD = Text("$error");
                      } else if (snapshot.hasData) {
                        String data = snapshot.data!;
                        return txtD = Text(
                          data,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        );
                      } else {
                        return txtD = const Text(
                          "Loading...",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        );
                      }
                    }),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        navigateTo(
            context: context,
            nextPage: FeedbackPage(
              questionType: _questionType,
              questionSubType: 'Implementation',
            ),
            currentPage: widget);
      },
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

  GestureDetector successIndicators(BuildContext context) {
    return GestureDetector(
      child: Container(
        //color: Color(0xFF6495ED),
        margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        decoration: BoxDecoration(
            color: itemColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(5.0),
              topRight: Radius.circular(20.0),
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(5.0),
            )),
        // color: Color(0xFF52adc8),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.fromLTRB(30, 10, 0, 10),
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
                padding: const EdgeInsets.fromLTRB(0, 0, 20, 10),
                child: FutureBuilder<String>(
                    future: dataCFuture,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        final error = snapshot.error;
                        return txtC = Text("$error");
                      } else if (snapshot.hasData) {
                        String data = snapshot.data!;
                        return txtC = Text(
                          data,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        );
                      } else {
                        return txtC = const Text(
                          "Loading...",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        );
                      }
                    }),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        navigateTo(
            context: context,
            nextPage: FeedbackPage(
              questionType: _questionType,
              questionSubType: 'Success Indicators (KPIs)',
            ),
            currentPage: widget);
      },
    );
  }

  GestureDetector overcomingChallenges(BuildContext context) {
    return GestureDetector(
      child: Container(
        //color: Color(0xFF6495ED),
        margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        decoration: BoxDecoration(
            color: itemColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(5.0),
              topRight: Radius.circular(20.0),
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(5.0),
            )),
        // color: Color(0xFF52adc8),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.fromLTRB(30, 10, 0, 10),
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
                padding: const EdgeInsets.fromLTRB(0, 0, 20, 10),
                child: FutureBuilder<String>(
                    future: dataBFuture,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        final error = snapshot.error;
                        return txtB = Text("$error");
                      } else if (snapshot.hasData) {
                        String data = snapshot.data!;
                        return txtB = Text(
                          data,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        );
                      } else {
                        return txtB = const Text(
                          "Loading...",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        );
                      }
                    }),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        navigateTo(
            context: context,
            nextPage: FeedbackPage(
              questionType: _questionType,
              questionSubType: 'Overcoming Challenges',
            ),
            currentPage: widget);
      },
    );
  }

  GestureDetector actions(BuildContext context) {
    return GestureDetector(
      child: Container(
        //color: Color(0xFF6495ED),
        margin: const EdgeInsets.fromLTRB(10, 10, 10, 5),
        decoration: BoxDecoration(
            color: itemColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(5.0),
              topRight: Radius.circular(20.0),
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(5.0),
            )),

        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.fromLTRB(30, 10, 0, 10),
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
                padding: const EdgeInsets.fromLTRB(0, 0, 20, 10),
                child: FutureBuilder<String>(
                    future: dataAFuture,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        final error = snapshot.error;
                        return txtA = Text("$error");
                      } else if (snapshot.hasData) {
                        String data = snapshot.data!;
                        return txtA = Text(
                          data,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        );
                      } else {
                        return txtA = const Text(
                          "Loading...",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        );
                      }
                    }),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        navigateTo(
            context: context,
            nextPage: FeedbackPage(
              questionType: _questionType,
              questionSubType: 'Actions',
            ),
            currentPage: widget);
      },
    );
  }

  AppBar appBar() {
    return AppBar(
      title: const Text("Question Type Selection"),
      backgroundColor: appBarColor,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    );
  }

  Future<String> getData(String subType) async {
    if (FirebaseAuth.instance.currentUser != null) {
      String uid = FirebaseAuth.instance.currentUser!.uid;

      final QuerySnapshot qSnapshot = await FirebaseFirestore.instance
          .collection('questions')
          .where('type', isEqualTo: _questionType)
          .where('sub type', isEqualTo: subType)
          .get();
      final int qDocuments = qSnapshot.docs.length;

      final QuerySnapshot aSnapshot = await FirebaseFirestore.instance
          .collection('answers')
          .where('uid', isEqualTo: uid)
          .where('type', isEqualTo: _questionType)
          .where('sub type', isEqualTo: subType)
          .get();
      final int aDocuments = aSnapshot.docs.length;
      String returnText = "Completed : $aDocuments/$qDocuments";
      // print('MYTAG : From Question_type_selection.dart/getData/Type = $_questionType , sub type = $subType , Completed = $aDocuments, Total = $qDocuments' );
      return returnText;
    }
    return "nodata";
  }

  @override
  initState() {
    super.initState();
    _questionType = widget.userID;
    txtA = txtLoading();
    txtB = txtLoading();
    txtC = txtLoading();
    txtD = txtLoading();
    txtE = txtLoading();
    txtF = txtLoading();
    dataAFuture = getData("Actions");
    dataBFuture = getData("Overcoming Challenges");
    dataCFuture = getData("Success Indicators (KPIs)");
    dataDFuture = getData("Implementation");
    dataEFuture = getData("Impact and Outcome");
    dataFFuture = getData("Future");
    refreshPage();
  }

  Future<void> refreshPage() async {
    int counter = 0;
    while (counter <= 1000) {
      await Future.delayed(const Duration(milliseconds: 10));
      setState(() {});
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
    setState(() {});
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

  Text txtLoading() {
    return const Text(
      "Loading...",
      style: TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
    );
  }

  ListView body(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Stack(
          children: [
            Container(
              width: double.infinity,
              height: 280,
              margin: const EdgeInsets.fromLTRB(10, 20, 10, 10),
              padding: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                border: Border.all(color: itemColor, width: 1),
                borderRadius: BorderRadius.circular(10),
                shape: BoxShape.rectangle,
              ),
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                children: [
                  actions(context),
                  overcomingChallenges(context),
                  successIndicators(context),
                ],
              ),
            ),
            planBorder(),
          ],
        ),
        Stack(
          children: [
            Container(
              width: double.infinity,
              height: 280,
              margin: const EdgeInsets.fromLTRB(10, 15, 10, 10),
              padding: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                border: Border.all(color: itemColor, width: 1),
                borderRadius: BorderRadius.circular(10),
                shape: BoxShape.rectangle,
              ),
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                children: [
                  implementation(context),
                  impactAndOutcome(context),
                  future(context),
                ],
              ),
            ),
            Positioned(
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
                )),
          ],
        ),
      ],
    );
  }
}
