import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motivational_leadership/ui/common/widget/copyright_text.dart';
import 'package:motivational_leadership/ui/common/widget/verticle_spacer.dart';
import 'package:motivational_leadership/ui/student/student_question_subtype_selection_page.dart';
import 'package:motivational_leadership/ui/student/widgets/app_bar.dart';
import 'package:motivational_leadership/ui/student/widgets/my_button_box.dart';
import 'package:motivational_leadership/utility/base_utils.dart';
import 'package:motivational_leadership/utility/colors.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayback extends StatefulWidget {
  final String questionType;
  const VideoPlayback({Key? key, required this.questionType}) : super(key: key);

  @override
  State<VideoPlayback> createState() => _VideoPlaybackState();
}

class _VideoPlaybackState extends State<VideoPlayback> {
  @override
  Widget build(BuildContext context) {
    log("Build Video");
    return youtubePlayerBuilder(context);
  }

  YoutubePlayerBuilder youtubePlayerBuilder(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    width = width / 120;
    height = height / 120;
    return YoutubePlayerBuilder(
        onExitFullScreen: () {
          // SystemChrome.setPreferredOrientations(DeviceOrientation.values);
          Orientation currentOrientation = MediaQuery.of(context).orientation;
          if (currentOrientation == DeviceOrientation.portraitUp) {
            SystemChrome.setPreferredOrientations(
                [DeviceOrientation.portraitDown]);
          } else if (currentOrientation == DeviceOrientation.portraitDown) {
            SystemChrome.setPreferredOrientations(
                [DeviceOrientation.portraitDown]);
          } else if (currentOrientation == DeviceOrientation.landscapeLeft) {
            SystemChrome.setPreferredOrientations(
                [DeviceOrientation.landscapeLeft]);
          } else if (currentOrientation == DeviceOrientation.landscapeRight) {
            SystemChrome.setPreferredOrientations(
                [DeviceOrientation.landscapeRight]);
          }
        },
        player: YoutubePlayer(
          controller: controller,
          aspectRatio: 16 / 10,
        ),
        builder: (context, player) {
          return Scaffold(
            backgroundColor: backgroundColor,
            appBar: myAppBar(context),
            body: myBody(player, context),
          );
        });
  }

  myBody(Widget player, BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(left: 16, right: 16),
      children: [
        Column(
          children: [
            if (_questionType == "Autonomy") ...[
              titleText("A", "utonomy"),
              verticleSpacer(10),
              autonomyText(),
              autonomySecondText(),
            ] else if (widget.questionType == "Belonging") ...[
              titleText("B", "elonging"),
              verticleSpacer(10),
              belongingText(),
              belongingSecondText(),
            ] else ...[
              titleText("C", "ompetence"),
              verticleSpacer(10),
              competenceText(),
              competenceSecondText(),
            ],
            verticleSpacer(10),
            player,
            verticleSpacer(10),
            saveButton(context),
            verticleSpacer(10),
            Align(
              alignment: Alignment.center,
              child: _buildButtonLogo(),
            ),
            copyrightText(),
          ],
        ),
      ],
    );
  }

  Text autonomyText() {
    return Text(
        "Self-Determination Theory explains that we each have three basic psychological needs and that our motivation improves as they are satisfied. These psychological needs are the need for autonomy, belonging and competence. ",
        style: myTextStyle(),
        textAlign: TextAlign.justify);
  }

  RichText autonomySecondText() {
    return RichText(
      textAlign: TextAlign.justify,
      text: TextSpan(
        children: [
          TextSpan(
            text:
                "The first of these psychological needs is the need for autonomy. This need relates to the sense of freedom and choice an individual has concerning their actions. This is what we call the",
            style: myTextStyle(),
          ),
          TextSpan(
            text: " “A” ",
            style: myTextStyle2(),
          ),
          TextSpan(
            text:
                "of a leader’s ABC to building motivation in the workplace. Click the video to learn more.",
            style: myTextStyle(),
          ),
        ],
      ),
    );
  }

  Text belongingText() {
    return Text(
        "The need for belonging is the desire to feel connected with others. This need is fulfilled by interpersonal connections with others, which are characterised by mutual respect, reliance and caring.",
        style: myTextStyle(),
        textAlign: TextAlign.justify);
  }

  RichText belongingSecondText() {
    return RichText(
      textAlign: TextAlign.justify,
      text: TextSpan(
        children: [
          TextSpan(
            text: "This is the",
            style: myTextStyle(),
          ),
          TextSpan(
            text: " “B” ",
            style: myTextStyle2(),
          ),
          TextSpan(
            text:
                "of what we call a leader’s ABC to building motivation in the workplace. Click the video to learn more.",
            style: myTextStyle(),
          ),
        ],
      ),
    );
  }

  Text competenceText() {
    return Text(
        "Another motivational force contributing to employee performance is the psychological need for competence. The need for competence relates to the desire of an individual to feel effective in their environment or job and to make valuable contributions.",
        style: myTextStyle(),
        textAlign: TextAlign.justify);
  }

  RichText competenceSecondText() {
    return RichText(
      textAlign: TextAlign.justify,
      text: TextSpan(
        children: [
          TextSpan(
            text: "This is the",
            style: myTextStyle(),
          ),
          TextSpan(
            text: " “C” ",
            style: myTextStyle2(),
          ),
          TextSpan(
            text:
                "of what we call a leader’s ABC to building motivation in the workplace. Click the video to learn more.",
            style: myTextStyle(),
          ),
        ],
      ),
    );
  }

  TextStyle myTextStyle() {
    return TextStyle(
      fontWeight: FontWeight.w400,
      fontFamily: 'Roboto',
      fontSize: 14.sp,
      color: Colors.black87,
      decoration: TextDecoration.none,
    );
  }

  TextStyle myTextStyle2() {
    return TextStyle(
      fontWeight: FontWeight.w500,
      fontFamily: 'Roboto',
      fontSize: 14.sp,
      color: titleOrange,
      decoration: TextDecoration.none,
    );
  }

  TextStyle myTextStyle3() {
    return TextStyle(
      fontWeight: FontWeight.w600,
      fontFamily: 'Roboto',
      fontSize: 24.sp,
      color: Colors.black87,
      decoration: TextDecoration.none,
    );
  }

  TextStyle myTextStyle4() {
    return TextStyle(
      fontWeight: FontWeight.w600,
      fontFamily: 'Roboto',
      fontSize: 24.sp,
      color: titleOrange,
      decoration: TextDecoration.none,
    );
  }

  late String _questionType = "";
  late YoutubePlayerController controller;
  @override
  void initState() {
    _questionType = widget.questionType;
    super.initState();
    String url = "";
    if (_questionType == 'Autonomy') {
      url = "https://www.youtube.com/watch?v=tI87ZnTwsD0";
    } else if (_questionType == 'Belonging') {
      url = "https://www.youtube.com/watch?v=Ylnysm7L82I";
    } else {
      url = "https://www.youtube.com/watch?v=sfABqW_ZP6Q";
    }

    controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(url)!,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        disableDragSeek: true,
        showLiveFullscreenButton: true,
      ),
    );
  }

  @override
  void deactivate() {
    controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  _buildButtonLogo() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    log("width = $width, height = $height");
    if (height > 600) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: Image.asset(
          'assets/complete_logo.png',
          width: width - (10 / 100 * width),
          fit: BoxFit.contain,
        ),
      );
    } else {
      return Container();
    }
  }

  mainTitle() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        _questionType,
        style: Theme.of(context).textTheme.headline3,
      ),
    );
  }

  Align titleText(String firstLetter, String remainingPart) {
    return Align(
      alignment: Alignment.centerLeft,
      child: RichText(
        textAlign: TextAlign.justify,
        text: TextSpan(
          children: [
            TextSpan(
              text: firstLetter,
              style: myTextStyle4(),
            ),
            TextSpan(
              text: remainingPart,
              style: myTextStyle3(),
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector saveButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.pause();
        SystemChrome.setPreferredOrientations(DeviceOrientation.values);
        navigateTo(
            context: context,
            nextPage: QuestionTypeSelection(questionType: _questionType),
            currentPage: widget);
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 3,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: myButtonBox(),
          child: Text(
            "Next",
            style: TextStyle(fontSize: 16.sp, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
