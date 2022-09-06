import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:motivational_leadership/services/database.dart';
import 'package:motivational_leadership/ui/common/app_bar.dart';
import 'package:motivational_leadership/ui/common/widget/verticle_spacer.dart';
import 'package:motivational_leadership/utility/colors.dart';

class StudentFeedbackPage extends StatefulWidget {
  const StudentFeedbackPage({super.key});

  @override
  State<StudentFeedbackPage> createState() => _StudentFeedbackPageState();
}

class _StudentFeedbackPageState extends State<StudentFeedbackPage> {
  final type = ['Autonomy', 'Belonging', 'Competence'];
  final subType = [
    'Actions',
    'Overcoming Challenges',
    'Success Indicators (KPIs)',
    'Implementation',
    'Impact and Outcome',
    'Future'
  ];
  String? typeValue = 'Autonomy';
  String? subTypeValue = 'Actions';
  TextEditingController feedbackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: appBar(context, "Coach's Feedback"),
      body: myBodySection(),
    );
  }

  @override
  initState() {
    super.initState();
    notifyChanges();
  }

  myBodySection() {
    double spacer = 10;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            textTitle(),
            verticleSpacer(spacer),
            typeSelectionMenu(),
            verticleSpacer(spacer),
            subTypeSelectionMenu(),
            verticleSpacer(spacer),
            verticleSpacer(spacer),
            feebackSection(),
            verticleSpacer(spacer),
          ],
        ),
      ),
    );
  }

  givenBySection() {
    return const Align(
      alignment: Alignment.centerRight,
      child: Text(
        "Feedback Given By:\nCoachName\nDate",
        style: TextStyle(
          color: Colors.orange,
        ),
        textAlign: TextAlign.end,
      ),
    );
  }

  Container subTypeSelectionMenu() {
    return Container(
      padding: const EdgeInsets.only(left: 10),
      decoration: myBox(),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          value: subTypeValue,
          isExpanded: true,
          items: subType.map(buildMenuItem).toList(),
          onChanged: (String? value) => setState(() {
            subTypeValue = value;
            notifyChanges();
          }),
        ),
      ),
    );
  }

  Container typeSelectionMenu() {
    return Container(
      padding: const EdgeInsets.only(left: 10),
      decoration: myBox(),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          value: typeValue,
          isExpanded: true,
          items: type.map(buildMenuItem).toList(),
          onChanged: (String? value) => setState(() {
            typeValue = value;
            notifyChanges();
          }),
        ),
      ),
    );
  }

  BoxDecoration myBox() {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: iconColor, width: 1));
  }

  TextField feebackSection() {
    return TextField(
      enableInteractiveSelection: false,
      readOnly: true,
      style: const TextStyle(fontSize: 16),
      keyboardType: TextInputType.multiline,
      minLines: 10,
      maxLines: null,
      controller: feedbackController,
      decoration: InputDecoration(
        labelText: "Feedback",
        labelStyle: TextStyle(color: iconColor),
        contentPadding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
        border: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: iconColor, width: 1.0),
          borderRadius: BorderRadius.circular(25.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: iconColor, width: 1.0),
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
    );
  }

  textTitle() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        "Feedback",
        style: Theme.of(context).textTheme.headline3,
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
        ),
      );

  void notifyChanges() {
    feedbackController.text = "Searching Feedback in database";
    String selectedType = typeValue.toString();
    String selectedSubType = subTypeValue.toString();
    loadDataToTextbox(selectedType, selectedSubType);
  }

  loadDataToTextbox(String selectedType, String selectedSubType) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    String feedback = await DatabaseService.getFeedbackGiven(
        uid, selectedType, selectedSubType);
    feedbackController.text = feedback;
  }
}
