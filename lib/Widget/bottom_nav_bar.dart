import 'package:flutter/material.dart';
import 'package:motivational_leadership/Screen/coaching_page.dart';
import 'package:motivational_leadership/Screen/communication_page.dart';
import 'package:motivational_leadership/Screen/forum_page.dart';
import 'package:motivational_leadership/Screen/home_page.dart';
import 'package:motivational_leadership/Screen/more_page.dart';
import 'package:motivational_leadership/Screen/profile_page.dart';
import 'package:motivational_leadership/Screen/questions_page.dart';

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
      //   //title: const Text('Leadership Development'),
      //   backgroundColor: Colors.transparent,
      //   bottomOpacity:  0,
      //   elevation: 0,
      // ),
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.question_mark_outlined),
            label: 'Question',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.model_training_outlined),
            label: 'Coaching',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.on_device_training_outlined),
            label: 'EI',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            label: 'More',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFFff6600),
        unselectedItemColor: Colors.grey,
        iconSize: 30,


        onTap: _onItemTapped,
      ),
    );
  }
}