import 'package:flutter/material.dart';
import 'package:training/Widget/bottom_nav_bar.dart';
import 'package:training/Widget/navigation_drawer.dart';

class HomePage extends StatelessWidget{
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => Scaffold(
    //drawer: const NavigationDrawerWidget(),
    //appBar: AppBar(
      // title: const Text("Home"),
    //),
    body: const Center(child: Text('Home')),
    //bottomNavigationBar: const BottomNavBar(),
  );

}