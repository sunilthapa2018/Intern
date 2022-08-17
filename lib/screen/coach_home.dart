import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Widget/navigation_drawer.dart';

class CoachHome extends StatefulWidget {
  const CoachHome({Key? key}) : super(key: key);

  @override
  State<CoachHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<CoachHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const NavigationDrawerWidget(),
      appBar: AppBar(
      title: Text("Coach"),
      backgroundColor: Color(0xFFF2811D),
      // toolbarHeight: 20,
      // backgroundColor: Colors.transparent,
      // elevation: 0.0,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: Container()
    );
  }
}
