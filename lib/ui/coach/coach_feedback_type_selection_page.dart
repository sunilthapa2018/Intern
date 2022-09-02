import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:motivational_leadership/providers/student/autonomy_provider.dart';
import 'package:motivational_leadership/providers/student/belonging_provider.dart';
import 'package:motivational_leadership/providers/student/competence_provider.dart';
import 'package:motivational_leadership/ui/coach/widgets/coach_autonomy_tile.dart';
import 'package:motivational_leadership/ui/coach/widgets/coach_belonging_tile.dart';
import 'package:motivational_leadership/ui/coach/widgets/coach_competence_tile.dart';
import 'package:motivational_leadership/utility/colors.dart';
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
    return Scaffold(
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
      backgroundColor: appBarColor,
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
      width: MediaQuery.of(context).size.width,
      color: backgroundColor,
      height: double.infinity,
      child: Column(
        children: [
          CoachAutonomyTile(userID: widget.userID),
          CoachBelongingTile(userID: widget.userID),
          CoachCompetenceTile(userID: widget.userID),
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
        width: MediaQuery.of(context).size.width / 3,
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
