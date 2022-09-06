import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:motivational_leadership/services/get_user_name.dart';
import 'package:motivational_leadership/ui/auth/sign_in_page.dart';
import 'package:motivational_leadership/ui/common/profile_page.dart';
import 'package:motivational_leadership/ui/student/student_feedback_new_page.dart';
import 'package:motivational_leadership/ui/student/student_home_page.dart';
import 'package:motivational_leadership/utility/base_utils.dart';
import 'package:motivational_leadership/utility/colors.dart';

String uid = FirebaseAuth.instance.currentUser!.uid;
int currentNavigation = 0;

class StudentNavigationDrawerWidget extends StatelessWidget {
  const StudentNavigationDrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: appBarColor,
      child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.blue,
            Colors.red,
          ],
        )),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            title(context),
            home(context),
            feedback(context),
            profile(context),
            signOut(context),
          ],
        ),
      ),
    );
  }

  ListTile signOut(BuildContext context) {
    return ListTile(
      contentPadding: myPadding(),
      leading: const Icon(
        Icons.logout_outlined,
        color: Colors.white,
      ),
      title: myText('Logout'),
      onTap: () => selectedItem(context, 3),
    );
  }

  ListTile profile(BuildContext context) {
    return ListTile(
      contentPadding: myPadding(),
      leading: const Icon(
        Icons.supervised_user_circle_outlined,
        color: Colors.white,
      ),
      title: myText('Profile'),
      onTap: () => selectedItem(context, 2),
    );
  }

  ListTile feedback(BuildContext context) {
    return ListTile(
      contentPadding: myPadding(),
      leading: const Icon(
        Icons.feedback_outlined,
        color: Colors.white,
      ),
      title: myText('Feedback'),
      onTap: () => selectedItem(context, 1),
    );
  }

  ListTile home(BuildContext context) {
    return ListTile(
      contentPadding: myPadding(),
      leading: const Icon(
        Icons.home_outlined,
        color: Colors.white,
      ),
      title: myText("home"),
      onTap: () => selectedItem(context, 0),
    );
  }

  EdgeInsets myPadding() => const EdgeInsets.symmetric(horizontal: 20.0);

  Text myText(String title) {
    return Text(title, style: const TextStyle(color: Colors.white));
  }

  SizedBox title(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Container(
        color: const Color(0xFF6495ED),
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

  selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();
    switch (index) {
      case 0:
        if (currentNavigation != 0) {
          navigateTo(
              context: context,
              nextPage: const StudentHome(),
              currentPage: this);
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
        FirebaseAuth.instance.signOut();
        navigateTo(
            context: context, nextPage: const SignIn(), currentPage: this);
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
        color: const Color(0xFF6495ED),
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
