import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:motivational_leadership/Widget/navigation_drawer.dart';
import 'package:motivational_leadership/ui/student/video_display_page.dart';
import 'package:page_transition/page_transition.dart';


class StudentHome extends StatefulWidget {
  const StudentHome({Key? key}) : super(key: key);
  @override
  State<StudentHome> createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  Color backgroundColor = Color(0xFFD9D9D9);
  Color itemColor = Color(0xFF417CA9);
  late Future<String> dataAFuture;
  late Future<String> dataBFuture;
  late Future<String> dataCFuture;

  @override
  Widget build(BuildContext context) => Scaffold(
      drawer: const NavigationDrawerWidget(),
      appBar: AppBar(
        title: Text("Home"),
        backgroundColor: Color(0xFFF2811D),
        // toolbarHeight: 20,
        // backgroundColor: Colors.transparent,
        // elevation: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: Container(
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
                      )),
                  // color: Color(0xFF52adc8),
                  child: Column(
                    children: [
                      _buildAutonomyText(),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 20, 20),
                          child: FutureBuilder<String>(
                              future: dataAFuture,
                              builder: (context, snapshot) {
                                switch (snapshot.connectionState) {
                                  case ConnectionState.waiting:
                                    if (snapshot.hasData) {
                                      String data = snapshot.data!;
                                      return Text(
                                        "$data",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      );
                                    } else {
                                      return Text(
                                        "Loading...",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
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
                                      return Text(
                                        "$data",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      );
                                    } else {
                                      return Text("No Data");
                                    }
                                }
                              }),
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(PageTransition(
                      type: PageTransitionType.rightToLeftJoined,
                      childCurrent: widget,
                      child: VideoPlayback(questionType: 'Autonomy')));
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
                      )),
                  // color: Color(0xFF52adc8),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(30, 20, 0, 20),
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
                          padding: const EdgeInsets.fromLTRB(0, 0, 20, 20),
                          child: FutureBuilder<String>(
                              future: dataBFuture,
                              builder: (context, snapshot) {
                                switch (snapshot.connectionState) {
                                  case ConnectionState.waiting:
                                    if (snapshot.hasData) {
                                      String data = snapshot.data!;
                                      return Text(
                                        "$data",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      );
                                    } else {
                                      return Text(
                                        "Loading...",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
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
                                      return Text(
                                        "$data",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      );
                                    } else {
                                      return Text("No Data");
                                    }
                                }
                              }),
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(PageTransition(
                      type: PageTransitionType.rightToLeftJoined,
                      childCurrent: widget,
                      child: VideoPlayback(questionType: 'Belonging')));
                },
              ),
              GestureDetector(
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
                      )),
                  // color: Color(0xFF52adc8),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(30, 20, 0, 20),
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
                          padding: const EdgeInsets.fromLTRB(0, 0, 20, 20),
                          child: FutureBuilder<String>(
                              future: dataCFuture,
                              builder: (context, snapshot) {
                                switch (snapshot.connectionState) {
                                  case ConnectionState.waiting:
                                    if (snapshot.hasData) {
                                      String data = snapshot.data!;
                                      return Text(
                                        "$data",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      );
                                    } else {
                                      return Text(
                                        "Loading...",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
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
                                      return Text(
                                        "$data",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      );
                                    } else {
                                      return Text("No Data");
                                    }
                                }
                              }),
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(PageTransition(
                      type: PageTransitionType.rightToLeftJoined,
                      childCurrent: widget,
                      child: VideoPlayback(questionType: 'Competence')));
                },
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: Image.asset(
                  'assets/complete_logo.png',
                  height: 80,
                  width: 120,
                  fit: BoxFit.contain,
                ),
              )
            ],
          ),
        ),
      ));

  Align _buildAutonomyText() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 20, 0, 20),
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
    );
  }

  @override
  void initState() {
    super.initState();
    dataAFuture = getData("Autonomy");
    dataBFuture = getData("Belonging");
    dataCFuture = getData("Competence");
    refreshPage();
  }

  Future<void> refreshPage() async {
    int counter = 0;
    while (counter <= 1000) {
      await Future.delayed(Duration(milliseconds: 10));
      setState(() {});
      counter++;
    }
  }

  Future<String> getData(String type) async {
    final QuerySnapshot qSnapshot = await FirebaseFirestore.instance
        .collection('questions')
        .where('type', isEqualTo: type)
        .get();
    final int qDocuments = qSnapshot.docs.length;

    String uid = FirebaseAuth.instance.currentUser!.uid;
    final QuerySnapshot aSnapshot = await FirebaseFirestore.instance
        .collection('answers')
        .where('uid', isEqualTo: uid)
        .where('type', isEqualTo: type)
        .get();
    final int aDocuments = aSnapshot.docs.length;
    String returnText =
        "Completed : " + aDocuments.toString() + "/" + qDocuments.toString();
    return returnText;
  }

  Future<void> _refresh() async {
    await Future.wait([
      dataAFuture = getData("Autonomy"),
      dataBFuture = getData("Belonging"),
      dataCFuture = getData("Competence")
    ]);
    this.setState(() {});
  }
}
