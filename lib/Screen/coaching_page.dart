import 'package:flutter/material.dart';
import 'package:training/Widget/bottom_nav_bar.dart';
import 'package:training/Widget/navigation_drawer.dart';

class CoachingPage extends StatelessWidget{
  const CoachingPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => Scaffold(
    drawer: const NavigationDrawerWidget(),
    //bottomNavigationBar: const BottomNavBar(),
    appBar: AppBar(
      title: const Text("Coaching"),
    ),
    body: const Center(child: Text('Coaching')),
  );

}