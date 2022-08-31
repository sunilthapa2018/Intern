import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:motivational_leadership/screen/question_type_selection.dart';
import 'package:page_transition/page_transition.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayback extends StatefulWidget {
  final String questionType;
  const VideoPlayback({Key? key, required this.questionType}) : super(key: key);

  @override
  State<VideoPlayback> createState() => _VideoPlaybackState();
}

class _VideoPlaybackState extends State<VideoPlayback> {
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

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: controller,
        ),
        builder: (context, player) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Introduction"),
              backgroundColor: const Color(0xFFF2811D),
              systemOverlayStyle: SystemUiOverlayStyle.dark,
            ),
            body: ListView(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
              children: [
                player,
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    controller.pause();
                    Navigator.of(context).push(PageTransition(
                        type: PageTransitionType.rightToLeftJoined,
                        childCurrent: widget,
                        child: QuestionTypeSelection(
                            questionType: _questionType)));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 20),
                    decoration: BoxDecoration(
                        color: const Color(0xFF2e3c96),
                        borderRadius: BorderRadius.circular(30)),
                    child: const Text(
                      "Skip >>",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
