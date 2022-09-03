import 'package:flutter/material.dart';
import 'package:motivational_leadership/providers/coach/subtype/coach_action_provider.dart';
import 'package:motivational_leadership/ui/coach/coach_feedback_page.dart';
import 'package:motivational_leadership/ui/coach/widgets/subtype/align_sub_title.dart';
import 'package:motivational_leadership/ui/coach/widgets/subtype/align_sub_type_completed.dart';
import 'package:motivational_leadership/ui/coach/widgets/subtype/box_decoration.dart';
import 'package:motivational_leadership/utility/base_utils.dart';
import 'package:provider/provider.dart';

class CoachActionTile extends StatelessWidget {
  final String userID;
  final String questionType;

  const CoachActionTile({
    Key? key,
    required this.userID,
    required this.questionType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final completedText = context.watch<CoachActionProvider>().completedText;
    final isLoading = context.watch<CoachActionProvider>().isLoading;

    return GestureDetector(
      child: Container(
        width: MediaQuery.of(context).size.width / 2,
        margin: const EdgeInsets.fromLTRB(10, 10, 10, 5),
        decoration: boxSubDecoration(),
        child: Column(
          children: [
            alignSubTitle("Actions"),
            alignSubTypeCompleted(isLoading, completedText),
          ],
        ),
      ),
      onTap: () {
        navigateTo(
            context: context,
            nextPage: CoachFeedbackPage(
              questionType: questionType,
              questionSubType: 'Actions',
              uId: userID,
            ),
            currentPage: this);
      },
    );
  }
}
