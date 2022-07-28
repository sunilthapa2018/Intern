import 'package:flutter/material.dart';
import 'package:training/Screen/coaching_page.dart';
import 'package:training/Screen/communication_page.dart';
import 'package:training/Screen/forum_page.dart';
import 'package:training/Screen/home_page.dart';
import 'package:training/Screen/more_page.dart';
import 'package:training/Screen/profile_page.dart';
import 'package:training/Screen/questions_page.dart';

import '../main.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);
  Widget build(BuildContext context) {
    return const BottomNavBar();
  }

  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  final screens = [
    const HomePage(),
    const QuestionPage(),
    const CoachingPage(),
    const CommunicationPage(),
    const MorePage(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Leadership Development'),
      // ),
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.blue,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            //backgroundColor: Color(0xFF2196F3),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.question_mark),
            label: 'Question',
            //backgroundColor: Color(0xFF2196F3),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.model_training),
            label: 'Coaching',
            //backgroundColor: Color(0xFF2196F3),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help),
            label: 'EI',
            //backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            label: 'More',
            //backgroundColor: Colors.blue,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        onTap: _onItemTapped,
      ),
    );
  }
}