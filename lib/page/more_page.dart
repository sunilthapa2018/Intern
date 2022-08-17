import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:motivational_leadership/Widget/bottom_nav_bar.dart';
import 'package:motivational_leadership/Widget/navigation_drawer.dart';
import 'package:motivational_leadership/models/get_user_id.dart';
import 'package:motivational_leadership/page/communication_page.dart';
import 'package:motivational_leadership/page/forum_page.dart';
import 'package:motivational_leadership/page/home_page.dart';
import 'package:motivational_leadership/page/profile_page.dart';
import 'package:motivational_leadership/page/questions_page.dart';
import 'package:motivational_leadership/services/get_user_name.dart';
import 'package:page_transition/page_transition.dart';

import '../main.dart';
import '../screen/profile.dart';
int padding = 20;
String uid = FirebaseAuth.instance.currentUser!.uid;
// Text userText =  GetUserName(documentId: uid) as Text;
// String userName = userText.data.toString();

class MorePage extends StatelessWidget{
  const MorePage({Key? key}) : super(key: key);  

  @override
  Widget build(BuildContext context) => Scaffold(    
    appBar: AppBar(
      toolbarHeight: 24,
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    ),
    //body: const Text('More'),
    body: ListView(

      // Removing any padding from the ListView.
      padding: EdgeInsets.zero,
      children: [
        Container(
          color: Color(0xFF6495ED),
          // color: Color(0xFF52adc8),
          child: Row(children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20,50,0,20),
              child: Text(
                'Hey',
                style: TextStyle(
                  //color: Color(0xFFff6600),
                  color: Color(0xFF2e3c96),
                  fontWeight: FontWeight.w900,
                  fontSize: 36,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10,50,0,20),
              child: GetUserName(documentId: uid),
            ),
          ]),
        ),
        Divider(color: Color(0xFFFFFFFFE5),height: 2,),
        ListTile(
          tileColor: Colors.white,
          contentPadding: const EdgeInsets.fromLTRB(20,0,0,0),
          minLeadingWidth : 10,
          leading: const Icon(Icons.person_outline, color: Color(0xFF2e3c96),),
          title: const Text(
            'My account',
            style: TextStyle(
            fontSize: 20.0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () {
            Navigator.of(context).push(PageTransition(
                type: PageTransitionType.rightToLeftJoined,
                childCurrent: this,
                duration: Duration(milliseconds: 300),
                reverseDuration: Duration(milliseconds: 300),
                child: Profile()
            ));
          },
        ),
        Divider(color: Color(0xFFFFFFFFE5),height: 2,),
        ListTile(
          tileColor: Colors.white,
          contentPadding: const EdgeInsets.fromLTRB(20,0,0,0),
          minLeadingWidth : 10,
          leading: const Icon(Icons.forum_outlined, color: Color(0xFF2e3c96),),
          title: const Text(
            'Forum',
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () {

          },
        ),
        Divider(color: Color(0xFFFFFFFFE5),height: 2,),
        ListTile(
          tileColor: Colors.white,
          contentPadding: const EdgeInsets.fromLTRB(20,0,0,0),
          minLeadingWidth : 10,
          leading: const Icon(Icons.app_registration_outlined, color: Color(0xFF2e3c96),),
          title: const Text(
            'About',
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () {

          },
        ),
        Divider(color: Color(0xFFFFFFFFE5),height: 2,),
        ListTile(
          tileColor: Colors.white,
          contentPadding: const EdgeInsets.fromLTRB(20,0,0,0),
          minLeadingWidth : 10,
          leading: const Icon(Icons.privacy_tip_outlined, color: Color(0xFF2e3c96),),
          title: const Text(
            'Privacy Policy',
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () {

          },
        ),
        Divider(color: Color(0xFFFFFFFFE5),height: 2,),
        ListTile(
          tileColor: Colors.white,
          contentPadding: const EdgeInsets.fromLTRB(20,0,0,0),
          minLeadingWidth : 10,
          leading: const Icon(Icons.contact_phone_outlined, color: Color(0xFF2e3c96),),
          title: const Text(
            'Contact us',
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () {

          },
        ),
        Divider(color: Color(0xFFFFFFFFE5),height: 2,),
        ListTile(
          tileColor: Colors.white,
          contentPadding: const EdgeInsets.fromLTRB(20,0,0,0),
          minLeadingWidth : 10,
          leading: const Icon(Icons.logout_outlined, color: Color(0xFF2e3c96),),
          title: const Text(
            'Logout',
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () {
            FirebaseAuth.instance.signOut();
            },
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0,20,0,0),
          child: Image.asset('assets/complete_logo.png',

          height: 80,
          width: 120,
          fit: BoxFit.contain,
          ),
        )
      ],
    ),
  );
  
}