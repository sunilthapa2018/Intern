import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:motivational_leadership/Widget/bottom_nav_bar.dart';
import 'package:motivational_leadership/Widget/navigation_drawer.dart';

class CommunicationPage extends StatelessWidget{
  const CommunicationPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => Scaffold(
    body: const Text('EI'),
    appBar: AppBar(
      toolbarHeight: 24,
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    ),

  );

}