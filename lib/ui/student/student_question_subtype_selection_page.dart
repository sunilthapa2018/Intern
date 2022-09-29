import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:motivational_leadership/providers/student/student_question_provider.dart';
import 'package:motivational_leadership/providers/student/subtype/student_feedback_action_provider.dart';
import 'package:motivational_leadership/providers/student/subtype/student_feedback_future_provider.dart';
import 'package:motivational_leadership/providers/student/subtype/student_feedback_imp_provider.dart';
import 'package:motivational_leadership/providers/student/subtype/student_feedback_io_provider.dart';
import 'package:motivational_leadership/providers/student/subtype/student_feedback_oc_provider.dart';
import 'package:motivational_leadership/providers/student/subtype/student_feedback_si_provider.dart';
import 'package:motivational_leadership/services/database.dart';
import 'package:motivational_leadership/ui/common/widget/help_dialog_box.dart';
import 'package:motivational_leadership/ui/common/widget/verticle_spacer.dart';
import 'package:motivational_leadership/ui/student/widgets/my_button_box.dart';
import 'package:motivational_leadership/ui/student/widgets/subtype/categories_tile/student_action_tile.dart';
import 'package:motivational_leadership/ui/student/widgets/subtype/categories_tile/student_future_tile.dart';
import 'package:motivational_leadership/ui/student/widgets/subtype/categories_tile/student_imp_tile.dart';
import 'package:motivational_leadership/ui/student/widgets/subtype/categories_tile/student_io_tile.dart';
import 'package:motivational_leadership/ui/student/widgets/subtype/categories_tile/student_oc_tile.dart';
import 'package:motivational_leadership/ui/student/widgets/subtype/categories_tile/student_si_tile.dart';
import 'package:motivational_leadership/utility/colors.dart';
import 'package:motivational_leadership/utility/utils.dart';
import 'package:motivational_leadership/utility/values.dart';
import 'package:provider/provider.dart';

class QuestionTypeSelection extends StatefulWidget {
  final String questionType;
  const QuestionTypeSelection({super.key, required this.questionType});
  @override
  State<QuestionTypeSelection> createState() => _QuestionTypeSelectionState();
}

class _QuestionTypeSelectionState extends State<QuestionTypeSelection> {
  @override
  initState() {
    super.initState();
    _questionType = widget.questionType;
    context
        .read<StudentQuestionProvider>()
        .setInit(context, _questionType, notify: false);
  }

  @override
  Widget build(BuildContext context) {
    final initFuture = context.watch<StudentQuestionProvider>().init;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: backgroundColor,
        appBar: appBar(context),
        body: FutureBuilder(
            future: initFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  color: backgroundColor,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              return myBody(context);
            }));
  }

  late String _questionType = "";

  Padding myBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // verbage(),
          titleText("Action Plan"),
          planSection(context),
          reflectSection(context),
          verticleSpacer(8),
        ],
      ),
    );
  }

  Stack reflectSection(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.fromLTRB(0, 8, 0, 5),
          padding: const EdgeInsets.only(bottom: 5),
          decoration: BoxDecoration(
            // color: const Color(0xFF00d4b7),
            // color: newTile3,
            border: Border.all(color: orangeColor, width: 1),
            borderRadius: BorderRadius.circular(10),
            shape: BoxShape.rectangle,
          ),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: myTextTitle("Reflect"),
              ),
              reflectVerbage(),
              StudentImplementationTile(questionType: _questionType),
              StudentIOTile(questionType: _questionType),
              StudentFutureTile(questionType: _questionType),
              verticleSpacer(5),
              reflectSubmitButton(context),
            ],
          ),
        ),
        // reflectBorderText(),
      ],
    );
  }

  Align titleText(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: RichText(
        textAlign: TextAlign.justify,
        text: TextSpan(
          children: [
            TextSpan(
              text: text,
              style: myTextStyle5(),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle myTextStyle5() {
    return TextStyle(
      fontWeight: FontWeight.w500,
      fontFamily: 'Roboto',
      fontSize: 24.sp,
      color: titleOrange,
      decoration: TextDecoration.none,
    );
  }

  Stack planSection(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
          padding: const EdgeInsets.only(bottom: 5, top: 0),
          decoration: BoxDecoration(
            // color: const Color(0xFF00d4b7),
            border: Border.all(color: orangeColor, width: 1),
            borderRadius: BorderRadius.circular(10),
            shape: BoxShape.rectangle,
          ),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: myTextTitle("Plan"),
              ),
              planVerbage(),
              StudentActionTile(questionType: _questionType),
              StudentOCTile(questionType: _questionType),
              StudentSITile(questionType: _questionType),
              verticleSpacer(5),
              planSubmitButton(context),
            ],
          ),
        ),
        // planBorderText(),
      ],
    );
  }

  Positioned reflectBorderText() {
    return Positioned(
        left: 50,
        top: 5,
        child: Container(
          padding: const EdgeInsets.only(left: 10, right: 10),
          color: Colors.transparent,
          child: Text(
            'Reflect',
            style: TextStyle(color: Colors.orange, fontSize: 20.sp),
          ),
        ));
  }

  GestureDetector reflectSubmitButton(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        String txtDValue =
            context.read<StudentImplementationProvider>().completedText;
        String txtEValue = context.read<StudentIOProvider>().completedText;
        String txtFValue = context.read<StudentFutureProvider>().completedText;
        bool dCompleted = getCompletedStatus(txtDValue);
        bool eCompleted = getCompletedStatus(txtEValue);
        bool fCompleted = getCompletedStatus(txtFValue);

        String uid = FirebaseAuth.instance.currentUser!.uid;
        if (dCompleted & eCompleted & fCompleted) {
          bool dataAlreadyPresent =
              await DatabaseService.hasThisDocument("submissions", uid);

          if (dataAlreadyPresent) {
            //edit data in database
            DatabaseService.updateSubmissions("reflect", "true");
            Utils.showSnackBar(
                "Your answer has been Edited and re-submitted for Reflect section");
          } else {
            //write new data to database
            DatabaseService.addSubmissions("false", "true");
            Utils.showSnackBar(
                "Your answer has been submitted for Reflect section");
          }
        } else {
          Utils.showSnackBar(
              "You can only submit your responses to your coach by completing all three parts of REFLECT section. ");
        }
      },
      child: submitButton(context),
    );
  }

  Positioned planBorderText() {
    return Positioned(
        left: 50,
        top: 0,
        child: Container(
          padding: const EdgeInsets.only(left: 10, right: 10),
          color: Colors.transparent,
          child: Text(
            'Plan',
            style: TextStyle(color: Colors.black, fontSize: 20.sp),
          ),
        ));
  }

  GestureDetector planSubmitButton(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        String txtAValue = context.read<StudentActionProvider>().completedText;
        String txtBValue = context.read<StudentOCProvider>().completedText;
        String txtCValue = context.read<StudentSIProvider>().completedText;

        bool aCompleted = getCompletedStatus(txtAValue);
        bool bCompleted = getCompletedStatus(txtBValue);
        bool cCompleted = getCompletedStatus(txtCValue);

        String uid = FirebaseAuth.instance.currentUser!.uid;
        if (aCompleted & bCompleted & cCompleted) {
          bool dataAlreadyPresent =
              await DatabaseService.hasThisDocument("submissions", uid);

          if (dataAlreadyPresent) {
            //edit data in database
            DatabaseService.updateSubmissions("plan", "true");
            Utils.showSnackBar(
                "Your answer has been Edited and re-submitted for PLAN section");
          } else {
            //write new data to database
            DatabaseService.addSubmissions("true", "false");
            Utils.showSnackBar(
                "Your answer has been submitted for PLAN section");
          }
        } else {
          Utils.showSnackBar(
              "You can only submit your responses to your coach by completing all three parts of PLAN section. ");
        }
      },
      child: submitButton(context),
    );
  }

  UnconstrainedBox submitButton(BuildContext context) {
    return UnconstrainedBox(
      child: Container(
        alignment: Alignment.center,
        width: buttonWidth,
        margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        decoration: myButtonBox(),
        child: Text(
          "Submit",
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: iconColor),
      backgroundColor: appBarColor,
      elevation: 0,
      titleSpacing: 0,
      toolbarHeight: 36,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      automaticallyImplyLeading: false, // Don't show the leading button
      title: Padding(
        padding: const EdgeInsets.all(0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back, color: iconColor),
            ),

            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: TextButton.icon(
                    onPressed: () {
                      loadInfo(context,
                          "To complete this action plan submit your responses for the Plan and Reflect activities below. You will receive a notification once your coach has responded, and find their responses by selecting the Feedback tab in the navigation menu on the Home page.");
                    },
                    label: Text(
                      "Help",
                      style: TextStyle(fontSize: 16.sp, color: iconColor),
                    ),
                    icon: Icon(
                      FontAwesomeIcons.solidCircleQuestion,
                      color: iconColor,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                padding: const EdgeInsets.only(right: 8, left: 0),
                onPressed: () async {
                  context.read<StudentQuestionProvider>().setInit(
                        context,
                        widget.questionType,
                        notify: true,
                      );
                },
                icon: Icon(
                  FontAwesomeIcons.arrowRotateRight,
                  color: iconColor,
                  size: 20,
                ),
              ),
            ),
            // Your widgets here
          ],
        ),
      ),
    );
  }

  bool getCompletedStatus(String value) {
    final split = value.split(':');
    final split2 = split[1].split('/');
    String completed = split2[0].trim();
    String total = split2[1].trim();
    if (completed == total) {
      return true;
    } else {
      return false;
    }
  }

  Text loadingText() {
    return const Text(
      "Loading...",
      style: TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
    );
  }

  reflectVerbage() {
    return Padding(
      padding: const EdgeInsets.only(left: 8, top: 5, right: 8),
      child: Text(
        "Submit your responses to your coach for review by completing all three parts of this activity.",
        style: myTextStyle(),
        textAlign: TextAlign.justify,
      ),
    );
  }

  planVerbage() {
    return Padding(
      padding: const EdgeInsets.only(left: 8, top: 5, right: 8),
      child: Text(
        "Submit your responses to your coach for review by completing all three parts of this activity.",
        style: myTextStyle(),
        textAlign: TextAlign.justify,
      ),
    );
  }

  RichText verbage() {
    return RichText(
      textAlign: TextAlign.justify,
      text: TextSpan(
        children: [
          TextSpan(
            text: "To complete this action plan submit your responses for the ",
            style: myTextStyle4(),
          ),
          TextSpan(
            text: "Plan",
            style: myTextStyle2(),
          ),
          TextSpan(
            text: " and ",
            style: myTextStyle4(),
          ),
          TextSpan(
            text: "Reflect",
            style: myTextStyle2(),
          ),
          TextSpan(
            text:
                " activities below. You will receive a notification once your coach has responded, and find their responses by selecting the Feedback tab in the navigation menu on the Home page.",
            style: myTextStyle4(),
          ),
        ],
      ),
    );
  }

  TextStyle myTextStyle() {
    return TextStyle(
      color: Colors.black,
      fontSize: 14.sp,
    );
  }

  TextStyle myTextStyle4() {
    return TextStyle(
      color: Colors.black,
      fontSize: 14.sp,
    );
  }

  TextStyle myTextStyle2() {
    return TextStyle(
      color: Colors.black,
      fontSize: 14.sp,
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle myTextStyle3() {
    return TextStyle(
      color: Colors.black,
      fontSize: 14.sp,
      fontWeight: FontWeight.bold,
    );
  }

  myText(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, top: 8),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 14.sp,
        ),
      ),
    );
  }

  myTextTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, top: 8),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.black,
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
          // fontStyle: FontStyle.italic,
        ),
      ),
    );
  }
}
