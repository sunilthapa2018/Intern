import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:motivational_leadership/Widget/bottom_nav_bar.dart';
import "Screen/communication_page.dart";
import "Screen/forum_page.dart";
import "Screen/home_page.dart";
import "Screen/profile_page.dart";
import "Screen/questions_page.dart";

void main() {
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   statusBarColor: Colors.red,
  // ));
  // SystemUiOverlayStyle.systemStatusBarContrastEnforced: false;

  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //     statusBarColor: Colors.transparent,
  //     systemNavigationBarColor: Colors.transparent,
  //     systemNavigationBarIconBrightness: Brightness.light
  // ));

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //systemNavigationBarColor: Color(0xFF2e3c96),
    // systemNavigationBarColor: Color(0xFFff6600),
    systemNavigationBarColor: Colors.black45,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Coaching app';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      theme: ThemeData.light(),

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //toolbarHeight: 20,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: screens[_selectedIndex],
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}