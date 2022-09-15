import 'package:flutter/material.dart';
import 'package:motivational_leadership/providers/student/subtype/student_feedback_future_provider.dart';
import 'package:motivational_leadership/ui/common/widget/subtype/subtype_decoration_box_3.dart';
import 'package:motivational_leadership/ui/student/student_question_page.dart';
import 'package:motivational_leadership/ui/student/widgets/subtype/align_sub_title.dart';
import 'package:motivational_leadership/ui/student/widgets/subtype/align_sub_type_completed.dart';
import 'package:motivational_leadership/utility/base_utils.dart';
import 'package:provider/provider.dart';

class StudentFutureTile extends StatelessWidget {
  final String questionType;

  const StudentFutureTile({
    Key? key,
    required this.questionType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final completedText = context.watch<StudentFutureProvider>().completedText;
    final isLoading = context.watch<StudentFutureProvider>().isLoading;

    return GestureDetector(
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        decoration: mySubTypeBoxDecoration3(),
        child: Column(
          children: [
            alignSubTitle("Future", context),
            alignSubTypeCompleted(isLoading, completedText, context),
          ],
        ),
      ),
      onTap: () {
        navigateTo(
            context: context,
            nextPage: Question(
              questionType: questionType,
              questionSubType: 'Future',
              questionNumber: 1,
            ),
            currentPage: this);
      },
    );
  }
}
