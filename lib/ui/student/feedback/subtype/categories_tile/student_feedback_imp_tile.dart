import 'package:flutter/material.dart';
import 'package:motivational_leadership/providers/student/feedback/subtype/student_feedback_imp_provider.dart';
import 'package:motivational_leadership/ui/student/student_feedback_page.dart';
import 'package:motivational_leadership/ui/student/widgets/subtype/align_sub_title.dart';
import 'package:motivational_leadership/ui/student/widgets/subtype/align_sub_type_completed.dart';
import 'package:motivational_leadership/ui/student/widgets/subtype/box_decoration.dart';
import 'package:motivational_leadership/utility/base_utils.dart';
import 'package:provider/provider.dart';

class StudentFeedbackImplementationTile extends StatelessWidget {
  final String questionType;

  const StudentFeedbackImplementationTile({
    Key? key,
    required this.questionType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final completedText =
        context.watch<StudentFeedbackImplementationProvider>().completedText;
    final isLoading =
        context.watch<StudentFeedbackImplementationProvider>().isLoading;

    return GestureDetector(
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.fromLTRB(10, 10, 10, 5),
        decoration: boxSubDecoration(),
        child: Column(
          children: [
            alignSubTitle("Implementation", context),
            alignSubTypeCompleted(isLoading, completedText, context),
          ],
        ),
      ),
      onTap: () {
        navigateTo(
            context: context,
            nextPage: StudentFeedback(
              questionType: questionType,
              questionSubType: 'Implementation',
            ),
            currentPage: this);
      },
    );
  }
}
