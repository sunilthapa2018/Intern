import 'package:flutter/material.dart';
import 'package:training/Widget/bottom_nav_bar.dart';
import 'package:training/Widget/navigation_drawer.dart';

class MorePage extends StatelessWidget{
  const MorePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => Scaffold(
    drawer: const NavigationDrawerWidget(),
    //bottomNavigationBar: const BottomNavBar(),
    appBar: AppBar(
      title: const Text("More"),
    ),
    body: const Center(child: Text('More')),
  );

}