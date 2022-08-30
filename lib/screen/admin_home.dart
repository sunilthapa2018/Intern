import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Widget/navigation_drawer.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const NavigationDrawerWidget(),
        appBar: AppBar(
          title: const Text("Admin"),
          backgroundColor: const Color(0xFFF2811D),
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        body: Column(
          children: const [
            SizedBox(width: 8),
            SizedBox(height: 16),
          ],
        ));
  }
}
