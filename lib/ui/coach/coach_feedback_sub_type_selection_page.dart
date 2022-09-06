import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motivational_leadership/providers/coach/subtype/coach_action_provider.dart';
import 'package:motivational_leadership/providers/coach/subtype/coach_future_provider.dart';
import 'package:motivational_leadership/providers/coach/subtype/coach_imp_provider.dart';
import 'package:motivational_leadership/providers/coach/subtype/coach_io_provider.dart';
import 'package:motivational_leadership/providers/coach/subtype/coach_oc_provider.dart';
import 'package:motivational_leadership/providers/coach/subtype/coach_si_provider.dart';
import 'package:motivational_leadership/ui/coach/widgets/subtype/categories_tile/coach_action_tile.dart';
import 'package:motivational_leadership/ui/coach/widgets/subtype/categories_tile/coach_future_tile.dart';
import 'package:motivational_leadership/ui/coach/widgets/subtype/categories_tile/coach_imp_tile.dart';
import 'package:motivational_leadership/ui/coach/widgets/subtype/categories_tile/coach_io_tile.dart';
import 'package:motivational_leadership/ui/coach/widgets/subtype/categories_tile/coach_oc_tile.dart';
import 'package:motivational_leadership/ui/coach/widgets/subtype/categories_tile/coach_si_tile.dart';
import 'package:motivational_leadership/utility/colors.dart';
import 'package:provider/provider.dart';

class CoachFeedbackSubTypeSelection extends StatefulWidget {
  final String userID;
  final String questionType;
  const CoachFeedbackSubTypeSelection(
      {super.key, required this.userID, required this.questionType});
  @override
  _CoachFeedbackSubTypeSelectionState createState() =>
      _CoachFeedbackSubTypeSelectionState();
}

class _CoachFeedbackSubTypeSelectionState
    extends State<CoachFeedbackSubTypeSelection> {
  @override
  Widget build(BuildContext context) {
    myWidth = MediaQuery.of(context).size.width / 2;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    return Scaffold(
      appBar: appBar(context),
      body: FutureBuilder(
          future: _loadInitialData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                color: backgroundColor,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            return body(context);
          }),
    );
  }

  late double myWidth = 300;
  late String _questionType = "";

  AppBar appBar(BuildContext context) {
    return AppBar(
      title: const Text("Sub Type Selection"),
      backgroundColor: appBarColor,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      actions: [
        IconButton(
            onPressed: () {
              _refresh(context);
            },
            icon: const Icon(Icons.refresh)),
      ],
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
      return returnText;
    }
    return "nodata";
  }

  @override
  initState() {
    super.initState();
    _questionType = widget.questionType;
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

  Container body(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Align(
            alignment: Alignment.center,
            child: Stack(
              children: [
                Container(
                  width: myWidth,
                  height: 296,
                  margin: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                  padding: const EdgeInsets.only(bottom: 10, top: 6),
                  decoration: BoxDecoration(
                    border: Border.all(color: itemColor, width: 1.sp),
                    borderRadius: BorderRadius.circular(10),
                    shape: BoxShape.rectangle,
                  ),
                  child: ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    children: [
                      CoachActionTile(
                        userID: widget.userID,
                        questionType: _questionType,
                      ),
                      CoachOCTile(
                          userID: widget.userID, questionType: _questionType),

                      CoachSITile(
                          userID: widget.userID, questionType: _questionType),
                      // overcomingChallenges(context),
                    ],
                  ),
                ),
                planSection(),
              ],
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Stack(
              children: [
                Container(
                  width: myWidth,
                  height: 296,
                  margin: const EdgeInsets.fromLTRB(10, 15, 10, 10),
                  padding: const EdgeInsets.only(bottom: 10, top: 6),
                  decoration: BoxDecoration(
                    border: Border.all(color: itemColor, width: 1.sp),
                    borderRadius: BorderRadius.circular(10),
                    shape: BoxShape.rectangle,
                  ),
                  child: ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    children: [
                      CoachImplementationTile(
                          userID: widget.userID, questionType: _questionType),
                      CoachIOTile(
                          userID: widget.userID, questionType: _questionType),
                      CoachFutureTile(
                          userID: widget.userID, questionType: _questionType),
                    ],
                  ),
                ),
                reflectSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Positioned planSection() {
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

  Positioned reflectSection() {
    return Positioned(
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
        ));
  }

  _refresh(BuildContext context) async {
    context.read<CoachActionProvider>().getData(
        studentId: widget.userID,
        type: widget.questionType,
        notify: true,
        subType: "Actions");
    context.read<CoachOCProvider>().getData(
        studentId: widget.userID,
        type: widget.questionType,
        notify: true,
        subType: "Overcoming Challenges");
    context.read<CoachSIProvider>().getData(
        studentId: widget.userID,
        type: widget.questionType,
        notify: true,
        subType: "Success Indicators (KPIs)");
    context.read<CoachImplementationProvider>().getData(
        studentId: widget.userID,
        type: widget.questionType,
        notify: true,
        subType: "Implementation");
    context.read<CoachIOProvider>().getData(
        studentId: widget.userID,
        type: widget.questionType,
        notify: true,
        subType: "Impact and Outcome");
    context.read<CoachFutureProvider>().getData(
        studentId: widget.userID,
        type: widget.questionType,
        notify: true,
        subType: "Future");
  }

  _loadInitialData() async {
    await Future.wait([
      context.read<CoachActionProvider>().getData(
          studentId: widget.userID,
          type: widget.questionType,
          notify: false,
          subType: "Actions"),
      context.read<CoachOCProvider>().getData(
          studentId: widget.userID,
          type: widget.questionType,
          notify: false,
          subType: "Overcoming Challenges"),
      context.read<CoachSIProvider>().getData(
          studentId: widget.userID,
          type: widget.questionType,
          notify: false,
          subType: "Success Indicators (KPIs)"),
      context.read<CoachImplementationProvider>().getData(
          studentId: widget.userID,
          type: widget.questionType,
          notify: false,
          subType: "Implementation"),
      context.read<CoachIOProvider>().getData(
          studentId: widget.userID,
          type: widget.questionType,
          notify: false,
          subType: "Impact and Outcome"),
      context.read<CoachFutureProvider>().getData(
          studentId: widget.userID,
          type: widget.questionType,
          notify: false,
          subType: "Future"),
    ]);
  }
}
