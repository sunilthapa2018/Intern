import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:motivational_leadership/services/get_user_name.dart';
import 'package:motivational_leadership/ui/admin/admin_add_question_page.dart';
import 'package:motivational_leadership/ui/admin/admin_home_page.dart';
import 'package:motivational_leadership/ui/admin/admin_list_question_page.dart';
import 'package:motivational_leadership/ui/auth/sign_in_page.dart';
import 'package:motivational_leadership/ui/auth/sign_up_page.dart';
import 'package:motivational_leadership/ui/common/profile_page.dart';
import 'package:motivational_leadership/ui/common/widget/box_decoration.dart';
import 'package:motivational_leadership/utility/base_utils.dart';
import 'package:motivational_leadership/utility/colors.dart';

String uid = FirebaseAuth.instance.currentUser!.uid;
int currentNavigation = 0;

class AdminNavigationDrawerWidget extends StatelessWidget {
  const AdminNavigationDrawerWidget({Key? key}) : super(key: key);

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
              FontAwesomeIcons.userPlus,
              color: coachAppBarColor,
            ),
            title: myText('Add User'),
            onTap: () => selectedItem(context, 1),
          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 24.0),
            leading: Icon(
              FontAwesomeIcons.fileCircleQuestion,
              color: coachAppBarColor,
            ),
            title: myText('Add Question'),
            onTap: () => selectedItem(context, 2),
          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 24.0),
            leading: Icon(
              FontAwesomeIcons.fileCircleQuestion,
              color: coachAppBarColor,
            ),
            title: myText('Edit Question'),
            onTap: () => selectedItem(context, 3),
          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 24.0),
            leading: Icon(
              FontAwesomeIcons.userTie,
              color: coachAppBarColor,
            ),
            title: myText('Profile'),
            onTap: () => selectedItem(context, 4),
          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 24.0),
            leading: Icon(
              FontAwesomeIcons.arrowRightFromBracket,
              color: coachAppBarColor,
            ),
            title: myText('Logout'),
            onTap: () => selectedItem(context, 5),
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
              context: context,
              nextPage: const AdminHome(),
              currentPage: const AdminHome());
        }
        currentNavigation = 0;
        break;
      case 1:
        navigateTo(
          context: context,
          nextPage: const SignUp(),
          currentPage: const AdminHome(),
        );
        break;
      case 2:
        navigateTo(
            context: context,
            nextPage: const AddQuestion(),
            currentPage: const AdminHome());
        break;
      case 3:
        navigateTo(
            context: context,
            nextPage: const AdminListQuestion(),
            currentPage: const AdminHome());

        break;
      case 4:
        navigateTo(
            context: context,
            nextPage: const Profile(),
            currentPage: const AdminHome());

        break;
      case 5:
        FirebaseAuth.instance.signOut();
        navigateTo(
            context: context, nextPage: const SignIn(), currentPage: this);
        break;
    }
  }
}
