import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:motivational_leadership/services/database.dart';
import 'package:motivational_leadership/ui/common/app_bar.dart';
import 'package:motivational_leadership/ui/common/widget/verticle_spacer.dart';

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
      appBar: appBar(context, "Coach's Feedback"),
      body: body(),
    );
  }

  @override
  initState() {
    super.initState();
    notifyChanges();
  }

  body() {
    double spacer = 10;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          typeSelectionMenu(),
          verticleSpacer(spacer),
          subTypeSelectionMenu(),
          verticleSpacer(spacer),
          verticleSpacer(spacer),
          feebackSection(),
        ],
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
        border: Border.all(color: Colors.grey, width: 2));
  }

  TextField feebackSection() {
    return TextField(
      enableInteractiveSelection: false, // will disable paste operation
      readOnly: true,
      style: const TextStyle(fontSize: 16),
      keyboardType: TextInputType.multiline,
      minLines: 20,
      maxLines: 20,
      controller: feedbackController,
      decoration: const InputDecoration(
        labelText: "Feedback",
        contentPadding: EdgeInsets.fromLTRB(10, 30, 10, 0),
        border: OutlineInputBorder(),
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
