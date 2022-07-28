import 'package:flutter/material.dart';
import 'package:training/Screen/communication_page.dart';
import 'package:training/Screen/forum_page.dart';
import 'package:training/Screen/home_page.dart';
import 'package:training/Screen/profile_page.dart';
import 'package:training/Screen/questions_page.dart';

import '../main.dart';

class NavigationDrawerWidget extends StatelessWidget{
  const NavigationDrawerWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context){
    return Drawer(
      child: ListView(
        // Removing any padding from the ListView.
        padding: EdgeInsets.zero,

        children: [
          SizedBox(
            height: 240,
            child: DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              padding: const EdgeInsets.only(top: 20, bottom: 0),
              //margin: const EdgeInsets.only(bottom: 200),
              child: Column(
                children: const [
                  CircleAvatar(
                    radius: 52,
                    child:Icon(
                      Icons.person_outline,
                      size: 70,
                    ),
                  ),
                  //SizedBox(height: 12),
                  Spacer(),
                  Text(
                    'Sunil Thapa',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  Text(
                    'luck.sunilthapa@gmail.com',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  Spacer(),
                ],
              ),
            ),
          ),

          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 50.0),
            leading: const Icon(Icons.home_outlined),
            title: const Text('Home'),
            onTap: () {
              //changeTab(index);
              Navigator.pop(context);
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const HomePage(),
              ));
            },
          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 50.0),
            leading: const Icon(Icons.info_outline),
            title: const Text('Communication Tutorial'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const CommunicationPage(),
              ));

            },
          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 50.0),
            leading: const Icon(Icons.help_outline),
            title: const Text('Questions'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const QuestionPage(),
              ));
            },
          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 50.0),
            leading: const Icon(Icons.feedback_outlined),
            title: const Text('Feedback'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const CommunicationPage(),
              ));
            },
          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 50.0),
            leading: const Icon(Icons.forum_outlined),
            title: const Text('Forum'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const ForumPage(),
              ));
            },
          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 50.0),
            leading: const Icon(Icons.supervised_user_circle_outlined),
            title: const Text('Profile'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const ProfilePage(),
              ));
            },
          ),
        ],
      ),
    );
  }
}