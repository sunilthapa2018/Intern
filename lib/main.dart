import 'package:flutter/material.dart';
import "Screen/communication_page.dart";
import "Screen/forum_page.dart";
import "Screen/home_page.dart";
import "Screen/profile_page.dart";
import "Screen/questions_page.dart";
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static const appTitle = 'Home';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: const Center(
        child: Text('This is Home Page!'),
      ),
      drawer: Drawer(
        // Adding a ListView to the drawer. This ensures the user can scroll
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
                Navigator.pop(context);
                 Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const MainPage(),
                ));
              },
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 50.0),
              leading: const Icon(Icons.info_outline),
              title: const Text('Communication Tutorial'),
              onTap: () {

                Navigator.pop(context);
              },
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 50.0),
              leading: const Icon(Icons.help_outline),
              title: const Text('Questions'),
              onTap: () {

                Navigator.pop(context);
              },
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 50.0),
              leading: const Icon(Icons.feedback_outlined),
              title: const Text('Feedback'),
              onTap: () {

                Navigator.pop(context);
              },
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 50.0),
              leading: const Icon(Icons.forum_outlined),
              title: const Text('Forum'),
              onTap: () {

                Navigator.pop(context);
              },
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 50.0),
              leading: const Icon(Icons.supervised_user_circle_outlined),
              title: const Text('Profile'),
              onTap: () {

                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Color(0xFF2196F3),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help),
            label: 'Communication Tutorials',
            backgroundColor: Colors.blue,
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.forum),
            label: 'Forum',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
            backgroundColor: Colors.blue,
          ),
        ],

      ),
    );
  }
}


