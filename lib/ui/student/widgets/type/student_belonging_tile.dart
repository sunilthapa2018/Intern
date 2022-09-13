import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motivational_leadership/providers/student/type/student_belonging_provider.dart';
import 'package:motivational_leadership/ui/common/widget/type_decoration_box_3.dart';
import 'package:motivational_leadership/ui/common/widget/type_decoration_box_4.dart';
import 'package:motivational_leadership/ui/common/widget/verticle_spacer.dart';
import 'package:motivational_leadership/ui/student/student_video_display_page.dart';
import 'package:motivational_leadership/utility/base_utils.dart';
import 'package:motivational_leadership/utility/colors.dart';
import 'package:provider/provider.dart';

class StudentBelongingTile extends StatefulWidget {
  const StudentBelongingTile({
    Key? key,
  }) : super(key: key);

  @override
  State<StudentBelongingTile> createState() => _StudentBelongingTileState();
}

class _StudentBelongingTileState extends State<StudentBelongingTile> {
  @override
  void initState() {
    // context.read<BelongingProvider>().getData(type: "Belonging", notify: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final completedText =
        context.watch<StudentBelongingProvider>().completedText;
    final isLoading = context.watch<StudentBelongingProvider>().isLoading;

    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
        decoration: myTypeBoxDecoration3(),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Supporting the need for Belonging',
                style: Theme.of(context).textTheme.headline2,
              ),
            ),
            verticleSpacer(10),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
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
              child: Row(
                children: [
                  Text(
                    'B',
                    style: myText(orangeColor),
                  ),
                  Text(
                    'ELONGING',
                    style: myText(Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        navigateTo(
            context: context,
            nextPage: const VideoPlayback(questionType: 'Belonging'),
            currentPage: widget);
      },
    );
  }

  TextStyle myText(Color myColor) {
    return TextStyle(
        fontWeight: FontWeight.w400,
        fontFamily: 'Roboto',
        fontSize: 24.sp,
        color: myColor,
        decoration: TextDecoration.none);
  }
}
