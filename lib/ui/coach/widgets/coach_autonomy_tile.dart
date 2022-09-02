import 'package:flutter/material.dart';
import 'package:motivational_leadership/providers/student/autonomy_provider.dart';
import 'package:motivational_leadership/ui/coach/coach_feedback_sub_type_selection_page.dart';
import 'package:motivational_leadership/ui/coach/widgets/align_completed.dart';
import 'package:motivational_leadership/ui/coach/widgets/align_title.dart';
import 'package:motivational_leadership/ui/coach/widgets/box_decoration.dart';
import 'package:motivational_leadership/utility/base_utils.dart';
import 'package:provider/provider.dart';

class CoachAutonomyTile extends StatelessWidget {
  final String userID;
  const CoachAutonomyTile({
    Key? key,
    required this.userID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final completedText = context.watch<AutonomyProvider>().completedText;
    final isLoading = context.watch<AutonomyProvider>().isLoading;

    return GestureDetector(
      child: Container(
        width: MediaQuery.of(context).size.width / 2,
        margin: const EdgeInsets.fromLTRB(10, 10, 10, 5),
        decoration: boxDecoration(),
        child: Column(
          children: [
            alignTitle("Autonomy"),
            alignCompleted(isLoading, completedText),
          ],
        ),
      ),
      onTap: () {
        navigateTo(
            context: context,
            nextPage: CoachFeedbackSubTypeSelection(
                userID: userID, questionType: "Autonomy"),
            currentPage: this);
      },
    );
  }
}
