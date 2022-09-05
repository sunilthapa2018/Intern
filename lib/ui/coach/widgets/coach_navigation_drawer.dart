import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:motivational_leadership/services/get_user_name.dart';
import 'package:motivational_leadership/ui/auth/sign_in_page.dart';
import 'package:motivational_leadership/ui/coach/coach_feedback_page.dart';
import 'package:motivational_leadership/ui/coach/coach_home_page.dart';
import 'package:motivational_leadership/ui/common/profile_page.dart';
import 'package:motivational_leadership/utility/base_utils.dart';

String uid = FirebaseAuth.instance.currentUser!.uid;
int currentNavigation = 0;

class CoachNavigationDrawerWidget extends StatelessWidget {
  const CoachNavigationDrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 120,
            child: Container(
              color: const Color(0xFF6495ED),
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
          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 50.0),
            leading: const Icon(Icons.home_outlined),
            title: const Text('Home'),
            onTap: () => selectedItem(context, 0),
          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 50.0),
            leading: const Icon(Icons.feedback_outlined),
            title: const Text('Feedback'),
            onTap: () => selectedItem(context, 1),
          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 50.0),
            leading: const Icon(Icons.supervised_user_circle_outlined),
            title: const Text('Profile'),
            onTap: () => selectedItem(context, 2),
          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 50.0),
            leading: const Icon(Icons.logout_outlined),
            title: const Text('Logout'),
            onTap: () => selectedItem(context, 3),
          ),
        ],
      ),
    );
  }

  selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();
    switch (index) {
      case 0:
        if (currentNavigation != 0) {
          navigateTo(
              context: context, nextPage: const CoachHome(), currentPage: this);
        }
        currentNavigation = 0;
        break;
      case 1:
        navigateTo(
            context: context,
            nextPage: const CoachFeedbackPage(
              questionType: '',
              questionSubType: '',
              uId: '',
            ),
            currentPage: const CoachHome());

        break;
      case 2:
        navigateTo(
            context: context,
            nextPage: const Profile(),
            currentPage: const CoachHome());

        break;
      case 3:
        FirebaseAuth.instance.signOut();
        navigateTo(
            context: context, nextPage: const SignIn(), currentPage: this);
    }
  }
}
