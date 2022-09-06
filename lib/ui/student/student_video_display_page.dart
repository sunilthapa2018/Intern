import 'package:flutter/material.dart';
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
    return YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: controller,
        ),
        builder: (context, player) {
          return Scaffold(
            backgroundColor: backgroundColor,
            appBar: buildAppBar(context),
            body: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 10),
                      mainTitle(),
                      const SizedBox(height: 10),
                      player,
                      const SizedBox(height: 10),
                      saveButton(context),
                    ],
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: _buildButtonLogo(),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  late String _questionType = "";
  late YoutubePlayerController controller;
  @override
  void initState() {
    _questionType = widget.questionType;
    super.initState();
    String url = "";
    if (_questionType == 'AUTONOMY') {
      url = "https://www.youtube.com/watch?v=vWitScrU8uY";
    } else if (_questionType == 'BELONGING') {
      url = "https://www.youtube.com/watch?v=vWitScrU8uY";
    } else {
      url = "https://www.youtube.com/watch?v=vWitScrU8uY";
    }
    controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(url)!,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
          showLiveFullscreenButton: true,
        ));
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

  Padding _buildButtonLogo() {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Image.asset(
        'assets/complete_logo.png',
        width: width - (20 / 100 * width),
        fit: BoxFit.contain,
      ),
    );
  }

  mainTitle() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        "Introduction",
        style: Theme.of(context).textTheme.headline3,
      ),
    );
  }

  GestureDetector saveButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.pause();
        navigateTo(
            context: context,
            nextPage: QuestionTypeSelection(questionType: _questionType),
            currentPage: widget);
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 2,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: myButtonBox(),
          child: const Text(
            "Skip >>",
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
