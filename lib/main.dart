import 'package:flutter/material.dart';
import 'package:training/Widget/bottom_nav_bar.dart';
import "Screen/communication_page.dart";
import "Screen/forum_page.dart";
import "Screen/home_page.dart";
import "Screen/profile_page.dart";
import "Screen/questions_page.dart";

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Coaching app';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  final screens = [
    const HomePage(),
    const QuestionPage(),
    const ForumPage(),
    const CommunicationPage(),

  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leadership Development'),
      ),
      body: screens[_selectedIndex],
      bottomNavigationBar: const BottomNavBar(),
      // bottomNavigationBar: BottomNavigationBar(
      //   type: BottomNavigationBarType.fixed,
      //   backgroundColor: Colors.blue,
      //   items: const [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Home',
      //       backgroundColor: Color(0xFF2196F3),
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.help),
      //       label: 'Communication Tutorials',
      //       backgroundColor: Colors.red,
      //     ),
      //
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.forum),
      //       label: 'Forum',
      //       backgroundColor: Colors.blue,
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.person),
      //       label: 'Profile',
      //       backgroundColor: Colors.red,
      //     ),
      //   ],
      //   currentIndex: _selectedIndex,
      //   selectedItemColor: Colors.white,
      //   unselectedItemColor: Colors.white70,
      //   onTap: _onItemTapped,
      // ),
    );
  }
}