import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motivational_leadership/providers/student/feedback/type/student_feedback_autonomy_provider.dart';
import 'package:motivational_leadership/ui/student/feedback/student_feedback_subtype_selection_page.dart';
import 'package:motivational_leadership/utility/base_utils.dart';
import 'package:motivational_leadership/utility/colors.dart';
import 'package:provider/provider.dart';

class StudentFeedbackAutonomyTile extends StatelessWidget {
  const StudentFeedbackAutonomyTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final completedText =
        context.watch<StudentFeedbackAutonomyProvider>().completedText;
    final isLoading =
        context.watch<StudentFeedbackAutonomyProvider>().isLoading;

    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.fromLTRB(10, 20, 10, 5),
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
                  'AUTONOMY',
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
            nextPage:
                const StudentFeedbackSubTypeSelection(questionType: 'Autonomy'),
            currentPage: this);
      },
    );
  }
}
