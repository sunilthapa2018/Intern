import 'package:flutter/material.dart';
import 'package:motivational_leadership/providers/student/type/student_autonomy_provider.dart';
import 'package:motivational_leadership/ui/common/widget/type_decoration_box_1.dart';
import 'package:motivational_leadership/ui/common/widget/type_decoration_box_4.dart';
import 'package:motivational_leadership/ui/common/widget/verticle_spacer.dart';
import 'package:motivational_leadership/ui/student/student_video_display_page.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class StudentAutonomyTile extends StatelessWidget {
  const StudentAutonomyTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final completedText =
        context.watch<StudentAutonomyProvider>().completedText;
    final isLoading = context.watch<StudentAutonomyProvider>().isLoading;

    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        decoration: myTypeBoxDecoration1(),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'A wonderful serenity has taken possession of my entire soul.',
                style: Theme.of(context).textTheme.headline2,
              ),
            ),
            verticleSpacer(20),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                decoration: myTypeBoxDecoration4(),
                child: Text(
                  (isLoading) ? "Loading..." : completedText,
                  style: Theme.of(context).textTheme.headline2,
                ),
              ),
            ),
            verticleSpacer(10),
            Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                'AUTONOMY',
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.of(context).push(PageTransition(
            type: PageTransitionType.rightToLeftJoined,
            childCurrent: this,
            child: const VideoPlayback(questionType: 'Autonomy')));
      },
    );
  }
}
