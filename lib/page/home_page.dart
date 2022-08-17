import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:motivational_leadership/Widget/bottom_nav_bar.dart';

import '../Widget/navigation_drawer.dart';


class HomePage extends StatelessWidget{
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => Scaffold(
    drawer: const NavigationDrawerWidget(),
    appBar: AppBar(
      title: Text("Home"),
      // toolbarHeight: 24,
      // backgroundColor: Colors.transparent,
      // elevation: 0.0,
      // systemOverlayStyle: SystemUiOverlayStyle.dark,
    ),
    body: const Text('Home'),

  );

}