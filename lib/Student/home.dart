import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motivational_leadership/Student/widgets/student_autonomy_tile.dart';
import 'package:motivational_leadership/Student/widgets/student_belonging.dart';
import 'package:motivational_leadership/Student/widgets/student_competence.dart';
import 'package:motivational_leadership/Utility/colors.dart';
import 'package:motivational_leadership/providers/autonomy_provider.dart';
import 'package:motivational_leadership/providers/belonging_provider.dart';
import 'package:motivational_leadership/providers/competence_provider.dart';
import 'package:provider/provider.dart';

import '../Widget/navigation_drawer.dart';

class StudentHome extends StatefulWidget {
  const StudentHome({Key? key}) : super(key: key);

  @override
  State<StudentHome> createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  @override
  Widget build(BuildContext context) {
    log("Student home build ");
    log(MediaQuery.of(context).size.height.toString());
    log(MediaQuery.of(context).size.width.toString());

    return Scaffold(
      drawer: const NavigationDrawerWidget(),
      appBar: _buildAppBar(context),
      body: FutureBuilder(
          future: _loadInitialData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
              );
            }
            return _buildMainBody(context);
          }),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text("Home"),
      backgroundColor: const Color(0xFFF2811D),
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      actions: [
        IconButton(
            onPressed: () {
              _refresh(context);
            },
            icon: const Icon(Icons.refresh)),
      ],
    );
  }

  _buildMainBody(BuildContext context) {
    return Container(
      color: backgroundColor,
      height: double.infinity,
      child: Column(
        children: [
          const StudentAutonomyTile(),
          const StudentBelongingTile(),
          const StudentCompetenceTile(),
          _buildButtonLogo()
        ],
      ),
    );
  }

  Padding _buildButtonLogo() {
    return Padding(
      padding: const EdgeInsets.only(),
      child: Image.asset(
        'assets/complete_logo.png',
        // height: 50.h,
        width: 350.w,
        fit: BoxFit.contain,
      ),
    );
  }

  _refresh(BuildContext context) async {
    context.read<AutonomyProvider>().getData(type: "Autonomy", notify: true);
    context.read<BelongingProvider>().getData(type: "Belonging", notify: true);
    context
        .read<CompetenceProvider>()
        .getData(type: "Competence", notify: true);
  }

  _loadInitialData() async {
    await context
        .read<AutonomyProvider>()
        .getData(type: "Autonomy", notify: false);
    await context
        .read<BelongingProvider>()
        .getData(type: "Belonging", notify: false);
    await context
        .read<CompetenceProvider>()
        .getData(type: "Competence", notify: false);
  }
}
