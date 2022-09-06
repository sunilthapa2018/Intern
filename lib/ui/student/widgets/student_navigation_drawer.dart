import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:motivational_leadership/services/get_user_name.dart';
import 'package:motivational_leadership/ui/auth/sign_in_page.dart';
import 'package:motivational_leadership/ui/common/profile_page.dart';
import 'package:motivational_leadership/ui/common/widget/box_decoration.dart';
import 'package:motivational_leadership/ui/common/widget/verticle_spacer.dart';
import 'package:motivational_leadership/ui/student/feedback/student_feedback_new_page.dart';
import 'package:motivational_leadership/ui/student/student_home_page.dart';
import 'package:motivational_leadership/utility/base_utils.dart';
import 'package:motivational_leadership/utility/colors.dart';

String uid = FirebaseAuth.instance.currentUser!.uid;
int currentNavigation = 0;

class StudentNavigationDrawerWidget extends StatefulWidget {
  const StudentNavigationDrawerWidget({super.key});

  @override
  State<StudentNavigationDrawerWidget> createState() =>
      _StudentNavigationDrawerWidgetState();
}

class _StudentNavigationDrawerWidgetState
    extends State<StudentNavigationDrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: appBarColor,
      child: Column(
        children: [
          title(context),
          verticleSpacer(20),
          home(context),
          feedback(context),
          profile(context),
          contactUs(context),
          const Expanded(child: SizedBox()),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Divider(color: Colors.black),
          ),
          signOut(context),
        ],
      ),
    );
  }

  ListTile signOut(BuildContext context) {
    return ListTile(
      contentPadding: myPadding(),
      leading: Icon(
        FontAwesomeIcons.arrowRightFromBracket,
        color: iconColor,
      ),
      title: myText('Logout'),
      onTap: () => selectedItem(context, 4),
    );
  }

  ListTile contactUs(BuildContext context) {
    return ListTile(
      contentPadding: myPadding(),
      leading: Icon(
        FontAwesomeIcons.phone,
        color: iconColor,
      ),
      title: myText('ContactUs'),
      onTap: () => selectedItem(context, 3),
    );
  }

  ListTile profile(BuildContext context) {
    return ListTile(
      contentPadding: myPadding(),
      leading: Icon(
        FontAwesomeIcons.userTie,
        color: iconColor,
      ),
      title: myText('Profile'),
      onTap: () => selectedItem(context, 2),
    );
  }

  ListTile feedback(BuildContext context) {
    return ListTile(
      contentPadding: myPadding(),
      leading: Icon(
        FontAwesomeIcons.reply,
        color: iconColor,
      ),
      title: myText('Feedback'),
      onTap: () => selectedItem(context, 1),
    );
  }

  ListTile home(BuildContext context) {
    return ListTile(
      contentPadding: myPadding(),
      leading: Icon(
        FontAwesomeIcons.houseUser,
        color: iconColor,
      ),
      title: myText("Home"),
      onTap: () => selectedItem(context, 0),
    );
  }

  EdgeInsets myPadding() => const EdgeInsets.symmetric(horizontal: 20.0);

  Text myText(String title) {
    return Text(
      title,
      style: TextStyle(
        color: Colors.black,
        fontFamily: 'Roboto',
        fontSize: 16.sp,
      ),
    );
  }

  SizedBox title(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Container(
        decoration: myBoxDecoration(),
        // color: orangeColor,
        child: Row(children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 50, 0, 20),
            child: Text(
              'Hey',
              style: TextStyle(
                // color: Color(0xFF2e3c96),
                color: Colors.black87,
                fontWeight: FontWeight.w900,
                fontSize: 36,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 50, 0, 20),
            child: GetUserName(documentId: uid),
          ),
        ]),
      ),
    );
  }

  selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();
    switch (index) {
      case 0:
        if (currentNavigation != 0) {
          navigateTo(
              context: context,
              nextPage: const StudentHome(),
              currentPage: widget);
        }
        currentNavigation = 0;
        break;
      case 1:
        navigateTo(
            context: context,
            nextPage: const StudentFeedbackPage(),
            currentPage: const StudentHome());
        break;
      case 2:
        navigateTo(
            context: context,
            nextPage: const Profile(),
            currentPage: const StudentHome());
        break;
      case 3:
        navigateTo(
            context: context,
            nextPage: const Profile(),
            currentPage: const StudentHome());
        break;
      case 4:
        FirebaseAuth.instance.signOut();
        navigateTo(
            context: context, nextPage: const SignIn(), currentPage: widget);
    }
  }
}

class Title extends StatelessWidget {
  const Title({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Container(
        color: orangeColor,
        // color: Color(0xFF52adc8),
        child: Row(children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 50, 0, 20),
            child: Text(
              'Hey',
              style: TextStyle(
                color: Color(0xFF2e3c96),
                fontWeight: FontWeight.w900,
                fontSize: 36,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 50, 0, 20),
            child: GetUserName(documentId: uid),
          ),
        ]),
      ),
    );
  }
}
