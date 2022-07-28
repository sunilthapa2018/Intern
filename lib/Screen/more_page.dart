import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:motivational_leadership/Widget/bottom_nav_bar.dart';
import 'package:motivational_leadership/Widget/navigation_drawer.dart';
import 'package:motivational_leadership/Screen/communication_page.dart';
import 'package:motivational_leadership/Screen/forum_page.dart';
import 'package:motivational_leadership/Screen/home_page.dart';
import 'package:motivational_leadership/Screen/profile_page.dart';
import 'package:motivational_leadership/Screen/questions_page.dart';
int padding = 20;

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
          color: Colors.white,
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
              child: Text(
                'Sunil',
                style: TextStyle(
                  color: Color(0xFFff6600),
                  fontWeight: FontWeight.w900,
                  fontSize: 36,
                ),
              ),
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
            //changeTab(index);
            Navigator.pop(context);
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const ProfilePage(),
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
            Navigator.pop(context);
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const CommunicationPage(),
            ));

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
            Navigator.pop(context);
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const QuestionPage(),
            ));
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
            Navigator.pop(context);
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const CommunicationPage(),
            ));
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
            Navigator.pop(context);
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const ForumPage(),
            ));
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
            Navigator.pop(context);
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const ProfilePage(),
            ));
          },
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0,20,0,0),
          child: Image.asset('assets/complete_logo.png',

          height: 60,
          width: 100,
          fit: BoxFit.contain,
          ),
        )
      ],
    ),
  );

}