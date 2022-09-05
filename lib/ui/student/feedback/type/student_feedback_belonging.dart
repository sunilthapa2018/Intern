import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motivational_leadership/providers/student/feedback/type/student_feedback_belonging_provider.dart';
import 'package:motivational_leadership/ui/student/feedback/student_feedback_subtype_selection_page.dart';
import 'package:motivational_leadership/utility/colors.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class StudentFeedbackBelongingTile extends StatefulWidget {
  const StudentFeedbackBelongingTile({
    Key? key,
  }) : super(key: key);

  @override
  State<StudentFeedbackBelongingTile> createState() =>
      _StudentFeedbackBelongingTileState();
}

class _StudentFeedbackBelongingTileState
    extends State<StudentFeedbackBelongingTile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final completedText =
        context.watch<StudentFeedbackBelongingProvider>().completedText;
    final isLoading =
        context.watch<StudentFeedbackBelongingProvider>().isLoading;
    log("first belog tile");
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.fromLTRB(10, 10, 10, 5),
        decoration: BoxDecoration(
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
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 0, 10),
                child: Text(
                  'BELONGING',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 24.sp,
                    letterSpacing: 2.sp,
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
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
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
            child: const StudentFeedbackSubTypeSelection(
                questionType: 'Belonging')));
      },
    );
  }
}
