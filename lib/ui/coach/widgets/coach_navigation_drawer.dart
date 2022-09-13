import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:motivational_leadership/services/get_user_name.dart';
import 'package:motivational_leadership/ui/auth/sign_in_page.dart';
import 'package:motivational_leadership/ui/coach/coach_home_page.dart';
import 'package:motivational_leadership/ui/common/profile_page.dart';
import 'package:motivational_leadership/ui/common/widget/box_decoration.dart';
import 'package:motivational_leadership/utility/base_utils.dart';
import 'package:motivational_leadership/utility/colors.dart';

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
          title(),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 24.0),
            leading: Icon(
              FontAwesomeIcons.houseUser,
              color: coachAppBarColor,
            ),
            title: myText('Home'),
            onTap: () => selectedItem(context, 0),
          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 24.0),
            leading: Icon(
              FontAwesomeIcons.userTie,
              color: coachAppBarColor,
            ),
            title: myText('Profile'),
            onTap: () => selectedItem(context, 1),
          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 24.0),
            leading: Icon(
              FontAwesomeIcons.arrowRightFromBracket,
              color: coachAppBarColor,
            ),
            title: myText('Logout'),
            onTap: () => selectedItem(context, 2),
          ),
        ],
      ),
    );
  }

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

  SizedBox title() {
    return SizedBox(
      height: 140,
      child: Container(
        decoration: myBoxDecoration(),
        child: Row(children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(24, 50, 0, 20),
            child: Text(
              'Hey',
              style: TextStyle(
                fontFamily: 'Roboto',
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
              context: context, nextPage: const CoachHome(), currentPage: this);
        }
        currentNavigation = 0;
        break;
      case 1:
        navigateTo(
            context: context,
            nextPage: const Profile(),
            currentPage: const CoachHome());

        break;
      case 2:
        FirebaseAuth.instance.signOut();
        navigateTo(
            context: context, nextPage: const SignIn(), currentPage: this);
        break;
    }
  }
}
