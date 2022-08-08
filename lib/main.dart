import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:motivational_leadership/Utility/utils.dart';
import 'package:motivational_leadership/Widget/bottom_nav_bar.dart';
import 'package:motivational_leadership/screen/signin.dart';

import "page/communication_page.dart";
import "page/forum_page.dart";
import "page/home_page.dart";
import "page/questions_page.dart";

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.black45,
  ));
  runApp(const MyApp());
}
final navigatorKey = GlobalKey<NavigatorState>();
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Coaching app';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: Utils.messengerKey,
      navigatorKey: navigatorKey,
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
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if(snapshot.hasData){
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
        }else{
          return SignIn();
        }

      }
    );
  }
}