import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motivational_leadership/utility/colors.dart';
import 'package:motivational_leadership/ui/student/student_video_display_page.dart';
import 'package:motivational_leadership/providers/student/autonomy_provider.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class StudentAutonomyTile extends StatelessWidget {
  const StudentAutonomyTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final completedText = context.watch<AutonomyProvider>().completedText;
    final isLoading = context.watch<AutonomyProvider>().isLoading;

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
        // color: Color(0xFF52adc8),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 20, 0, 20),
                child: Text(
                  'AUTONOMY',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 24.sp,
                    letterSpacing: 2,
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
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
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
            childCurrent: this,
            child: const VideoPlayback(questionType: 'Autonomy')));
      },
    );
  }
}
