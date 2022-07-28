import 'package:flutter/material.dart';
import 'package:motivational_leadership/Widget/bottom_nav_bar.dart';
import 'package:motivational_leadership/Widget/navigation_drawer.dart';

class QuestionPage extends StatelessWidget{
  const QuestionPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => Scaffold(
    drawer: const NavigationDrawerWidget(),
    //bottomNavigationBar: const BottomNavBar(),
    appBar: AppBar(
      title: const Text("Questions"),
    ),
    body: const Center(child: Text('Questions')),
  );

}