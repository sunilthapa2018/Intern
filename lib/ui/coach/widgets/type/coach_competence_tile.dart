import 'package:flutter/material.dart';
import 'package:motivational_leadership/providers/coach/type/coach_competence_provider.dart';
import 'package:motivational_leadership/ui/coach/coach_feedback_sub_type_selection_page.dart';
import 'package:motivational_leadership/ui/coach/widgets/align_completed.dart';
import 'package:motivational_leadership/ui/coach/widgets/align_title.dart';
import 'package:motivational_leadership/ui/common/widget/type_decoration_box_1.dart';
import 'package:motivational_leadership/utility/base_utils.dart';
import 'package:provider/provider.dart';

class CoachCompetenceTile extends StatelessWidget {
  final String userID;
  const CoachCompetenceTile({
    Key? key,
    required this.userID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final completedText =
        context.watch<CoachCompetenceProvider>().completedText;
    final isLoading = context.watch<CoachCompetenceProvider>().isLoading;

    return GestureDetector(
      child: Container(
        width: MediaQuery.of(context).size.width / 2,
        margin: const EdgeInsets.fromLTRB(10, 10, 10, 5),
        decoration: myTypeBoxDecoration1(),
        child: Column(
          children: [
            alignTitle("Competence"),
            alignCompleted(isLoading, completedText),
          ],
        ),
      ),
      onTap: () {
        navigateTo(
            context: context,
            nextPage: CoachFeedbackSubTypeSelection(
                userID: userID, questionType: "Competence"),
            currentPage: this);
      },
    );
  }
}
