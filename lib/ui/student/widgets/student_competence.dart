import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motivational_leadership/providers/student/competence_provider.dart';
import 'package:motivational_leadership/ui/student/student_video_display_page.dart';
import 'package:motivational_leadership/utility/colors.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class StudentCompetenceTile extends StatefulWidget {
  const StudentCompetenceTile({
    Key? key,
  }) : super(key: key);

  @override
  State<StudentCompetenceTile> createState() => _StudentCompetenceTileState();
}

class _StudentCompetenceTileState extends State<StudentCompetenceTile> {
  @override
  void initState() {
    // context
    //     .read<CompetenceProvider>()
    //     .getData(type: "Competence", notify: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final completedText = context.watch<CompetenceProvider>().completedText;
    final isLoading = context.watch<CompetenceProvider>().isLoading;
    log("first comp tile");
    return GestureDetector(
      child: Container(
        //color: Color(0xFF6495ED),
        margin: const EdgeInsets.fromLTRB(10, 10, 10, 5),
        //height: 120,
        decoration: BoxDecoration(
            // color: Color(0xFFF2811D),
            color: itemColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5.0.r),
              topRight: Radius.circular(25.0.r),
              bottomLeft: Radius.circular(25.0.r),
              bottomRight: Radius.circular(5.0.r),
            )),
        // color: Color(0xFF52adc8),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.fromLTRB(30, 20, 0, 20),
                child: Text(
                  'Competence',
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
                child: Text(
                  (isLoading) ? "Loading..." : completedText,
                  style: const TextStyle(
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
            child: const VideoPlayback(questionType: 'Competence')));
      },
    );
  }
}
