import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motivational_leadership/providers/student/feedback/type/student_feedback_competence_provider.dart';
import 'package:motivational_leadership/ui/student/feedback/student_feedback_subtype_selection_page.dart';
import 'package:motivational_leadership/utility/base_utils.dart';
import 'package:motivational_leadership/utility/colors.dart';
import 'package:provider/provider.dart';

class StudentFeedbackCompetenceTile extends StatefulWidget {
  const StudentFeedbackCompetenceTile({
    Key? key,
  }) : super(key: key);

  @override
  State<StudentFeedbackCompetenceTile> createState() =>
      _StudentFeedbackCompetenceTileState();
}

class _StudentFeedbackCompetenceTileState
    extends State<StudentFeedbackCompetenceTile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final completedText =
        context.watch<StudentFeedbackCompetenceProvider>().completedText;
    final isLoading =
        context.watch<StudentFeedbackCompetenceProvider>().isLoading;
    log("first comp tile");
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
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 0, 10),
                child: Text(
                  'COMPETENCE',
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
        navigateTo(
            context: context,
            nextPage: const StudentFeedbackSubTypeSelection(
                questionType: 'Competence'),
            currentPage: widget);
      },
    );
  }
}
