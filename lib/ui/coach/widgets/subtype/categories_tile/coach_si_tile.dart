import 'package:flutter/material.dart';
import 'package:motivational_leadership/providers/coach/subtype/coach_si_provider.dart';
import 'package:motivational_leadership/ui/coach/coach_feedback_page.dart';
import 'package:motivational_leadership/ui/coach/widgets/subtype/align_sub_title.dart';
import 'package:motivational_leadership/ui/coach/widgets/subtype/align_sub_type_completed.dart';
import 'package:motivational_leadership/ui/common/widget/type_decoration_box_1.dart';
import 'package:motivational_leadership/utility/base_utils.dart';
import 'package:motivational_leadership/utility/values.dart';
import 'package:provider/provider.dart';

class CoachSITile extends StatelessWidget {
  final String userID;
  final String questionType;

  const CoachSITile({
    Key? key,
    required this.userID,
    required this.questionType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final completedText = context.watch<CoachSIProvider>().completedText;
    final isLoading = context.watch<CoachSIProvider>().isLoading;

    return GestureDetector(
      child: Container(
        width: screenWidth,
        margin: const EdgeInsets.fromLTRB(10, 10, 10, 5),
        decoration: myTypeBoxDecoration1(),
        child: Column(
          children: [
            alignSubTitle("Success Indicators (KPIs)"),
            alignSubTypeCompleted(isLoading, completedText),
          ],
        ),
      ),
      onTap: () {
        navigateTo(
            context: context,
            nextPage: CoachFeedbackPage(
              questionType: questionType,
              questionSubType: 'Success Indicators (KPIs)',
              uId: userID,
            ),
            currentPage: this);
      },
    );
  }
}
