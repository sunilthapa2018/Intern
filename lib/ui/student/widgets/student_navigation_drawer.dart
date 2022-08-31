import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:motivational_leadership/services/get_user_name.dart';
import 'package:motivational_leadership/ui/auth/sign_in_page.dart';
import 'package:motivational_leadership/ui/common/profile_page.dart';
import 'package:motivational_leadership/ui/student/student_home_page.dart';
import 'package:page_transition/page_transition.dart';

String uid = FirebaseAuth.instance.currentUser!.uid;

class NavigationDrawerWidget extends StatelessWidget {
  const NavigationDrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
    );
  }

  ListTile signOut(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 50.0),
      leading: const Icon(Icons.logout_outlined),
      title: const Text('Logout'),
      onTap: () {
        FirebaseAuth.instance.signOut();
        Navigator.of(context).push(PageTransition(
            type: PageTransitionType.rightToLeftJoined,
            childCurrent: this,
            child: SignIn()));
      },
    );
  }

  ListTile profile(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 50.0),
      leading: const Icon(Icons.supervised_user_circle_outlined),
      title: const Text('Profile'),
      onTap: () {
        Navigator.of(context).push(PageTransition(
            type: PageTransitionType.rightToLeftJoined,
            childCurrent: this,
            child: Profile()));
      },
    );
  }

  ListTile feedback(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 50.0),
      leading: const Icon(Icons.feedback_outlined),
      title: const Text('Feedback'),
      onTap: () {
        Navigator.of(context).push(PageTransition(
            type: PageTransitionType.rightToLeftJoined,
            childCurrent: this,
            child: const StudentHome()));
      },
    );
  }

  ListTile home(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 50.0),
      leading: const Icon(Icons.home_outlined),
      title: const Text('Home'),
      onTap: () {
        Navigator.of(context).push(PageTransition(
            type: PageTransitionType.rightToLeftJoined,
            childCurrent: this,
            child: const StudentHome()));
      },
    );
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
