import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:motivational_leadership/providers/coach/type/coach_autonomy_provider.dart';
import 'package:motivational_leadership/providers/coach/type/coach_belonging_provider.dart';
import 'package:motivational_leadership/providers/coach/type/coach_competence_provider.dart';
import 'package:motivational_leadership/ui/coach/widgets/type/coach_autonomy_tile.dart';
import 'package:motivational_leadership/ui/coach/widgets/type/coach_belonging_tile.dart';
import 'package:motivational_leadership/ui/coach/widgets/type/coach_competence_tile.dart';
import 'package:motivational_leadership/utility/colors.dart';
import 'package:motivational_leadership/utility/values.dart';
import 'package:provider/provider.dart';

class CoachFeedbackTypeSelection extends StatefulWidget {
  final String userID;
  const CoachFeedbackTypeSelection({
    Key? key,
    required this.userID,
  }) : super(key: key);

  @override
  State<CoachFeedbackTypeSelection> createState() =>
      _CoachFeedbackTypeSelectionState();
}

class _CoachFeedbackTypeSelectionState
    extends State<CoachFeedbackTypeSelection> {
  @override
  Widget build(BuildContext context) {
    log("Built Coach feedback type selection page");
    return Scaffold(
      backgroundColor: coachBackgroundColor,
      appBar: _buildAppBar(context),
      body: FutureBuilder(
          future: _loadInitialData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return _buildMainBody(context);
          }),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text("Type Selection"),
      backgroundColor: coachAppBarColor,
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
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: [
            CoachAutonomyTile(userID: widget.userID),
            CoachBelongingTile(userID: widget.userID),
            CoachCompetenceTile(userID: widget.userID),
            _buildButtonLogo()
          ],
        ),
      ),
    );
  }

  _buildButtonLogo() {
    return Image.asset(
      'assets/complete_logo.png',
      width: screenWidth,
      fit: BoxFit.contain,
    );
  }

  _refresh(BuildContext context) async {
    context
        .read<CoachAutonomyProvider>()
        .getData(studentId: widget.userID, type: "Autonomy", notify: true);
    context
        .read<CoachBelongingProvider>()
        .getData(studentId: widget.userID, type: "Belonging", notify: true);
    context
        .read<CoachCompetenceProvider>()
        .getData(studentId: widget.userID, type: "Competence", notify: true);
  }

  _loadInitialData() async {
    await Future.wait([
      context
          .read<CoachAutonomyProvider>()
          .getData(studentId: widget.userID, type: "Autonomy", notify: false),
      context
          .read<CoachBelongingProvider>()
          .getData(studentId: widget.userID, type: "Belonging", notify: false),
      context
          .read<CoachCompetenceProvider>()
          .getData(studentId: widget.userID, type: "Competence", notify: false),
    ]);
  }
}
