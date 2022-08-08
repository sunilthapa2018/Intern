import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:motivational_leadership/Widget/bottom_nav_bar.dart';


class HomePage extends StatelessWidget{
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => Scaffold(
    body: const Text('Home'),
    appBar: AppBar(
      toolbarHeight: 24,
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    ),

  );

}