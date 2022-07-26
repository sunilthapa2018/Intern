import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:motivational_leadership/main.dart';
import 'package:motivational_leadership/services/get_user_name.dart';
import 'package:motivational_leadership/ui/common/profile_page.dart';
import 'package:motivational_leadership/ui/common/widget/box_decoration.dart';
import 'package:motivational_leadership/ui/common/widget/verticle_spacer.dart';
import 'package:motivational_leadership/ui/student/feedback/student_feedback_page.dart';
import 'package:motivational_leadership/ui/student/student_contact_us_page.dart';
import 'package:motivational_leadership/ui/student/student_home_page.dart';
import 'package:motivational_leadership/utility/base_utils.dart';
import 'package:motivational_leadership/utility/colors.dart';

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
      width: (80 / 100) * MediaQuery.of(context).size.width,
      backgroundColor: appBarColor,
      child: ListView(
        children: [
          title(),
          verticleSpacer(20),
          home(context),
          feedback(context),
          profile(context),
          contactUs(context),
          line(),
          signOut(context),
          line(),
          verticleSpacer(60),
        ],
      ),
    );
  }

  Divider line() {
    return const Divider(color: Colors.black);
  }

  ListTile signOut(BuildContext context) {
    return ListTile(
      contentPadding: myPadding(),
      leading: Icon(
        FontAwesomeIcons.arrowRightFromBracket,
        color: iconColor,
        size: 16.h,
      ),
      title: myText('Sign Out'),
      onTap: () => selectedItem(context, 4),
    );
  }

  ListTile contactUs(BuildContext context) {
    return ListTile(
      contentPadding: myPadding(),
      leading: Icon(
        FontAwesomeIcons.phone,
        color: iconColor,
        size: 16.h,
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
        size: 16.h,
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
        size: 16.h,
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
        size: 16.h,
      ),
      title: myText("Home"),
      onTap: () => selectedItem(context, 0),
    );
  }

  EdgeInsets myPadding() =>
      EdgeInsets.symmetric(horizontal: 24.0, vertical: 5.h);

  Text myText(String title) {
    return Text(
      title,
      style: TextStyle(
        color: Colors.black,
        fontFamily: 'Roboto',
        fontSize: 18.sp,
      ),
    );
  }

  SizedBox title() {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    return SizedBox(
      height: 140.h,
      child: Container(
        decoration: myBoxDecoration(),
        child: Row(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 50, 0, 20),
            child: Text(
              'Hey',
              style: TextStyle(
                fontFamily: 'Roboto',
                color: Colors.black87,
                fontWeight: FontWeight.w900,
                fontSize: 36.sp,
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
            nextPage: const StudentContactUs(),
            currentPage: const StudentHome());
        break;
      case 4:
        FirebaseAuth.instance.signOut();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) {
            return const MainPage();
          }),
        );
      // navigateTo(
      //     context: context, nextPage: const SignIn(), currentPage: widget);
    }
  }
}
