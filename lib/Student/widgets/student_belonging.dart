import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:motivational_leadership/Utility/colors.dart';
import 'package:motivational_leadership/providers/belonging_provider.dart';
import 'package:motivational_leadership/screen/video.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class StudentBelongingTile extends StatefulWidget {
  const StudentBelongingTile({
    Key? key,
  }) : super(key: key);

  @override
  State<StudentBelongingTile> createState() => _StudentBelongingTileState();
}

class _StudentBelongingTileState extends State<StudentBelongingTile> {
  @override
  void initState() {
    // context.read<BelongingProvider>().getData(type: "Belonging", notify: true);
    super.initState();
  }

  Widget build(BuildContext context) {
    final completedText = context.watch<BelongingProvider>().completedText;
    final isLoading = context.watch<BelongingProvider>().isLoading;
    log("first belog tile");
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.fromLTRB(10, 20, 10, 5),
        decoration: BoxDecoration(
            color: itemColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5.0),
              topRight: Radius.circular(25.0),
              bottomLeft: Radius.circular(25.0),
              bottomRight: Radius.circular(5.0),
            )),
        // color: Color(0xFF52adc8),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.fromLTRB(30, 20, 0, 20),
                child: Text(
                  'Belonging',
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
                padding: EdgeInsets.fromLTRB(0, 0, 20, 20),
                child: Text(
                  (isLoading) ? "Loading..." : completedText,
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
            child: const VideoPlayback(questionType: 'Autonomy')));
      },
    );
  }
}
