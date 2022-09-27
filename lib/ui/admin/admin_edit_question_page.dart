import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motivational_leadership/services/database.dart';
import 'package:motivational_leadership/ui/common/widget/verticle_spacer.dart';
import 'package:motivational_leadership/utility/colors.dart';
import 'package:motivational_leadership/utility/utils.dart';

class EditQuestion extends StatefulWidget {
  final String questionId;

  const EditQuestion({
    Key? key,
    required this.questionId,
  }) : super(key: key);

  @override
  State<EditQuestion> createState() => _EditQuestionState();
}

class _EditQuestionState extends State<EditQuestion> {
  @override
  Widget build(BuildContext context) {
    return myScaffold();
  }

  Scaffold myScaffold() {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: adminBackgroundColor,
      appBar: myAppBar(),
      body: FutureBuilder(
        future: readQuestionData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              color: backgroundColor,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return myBodySection();
        },
      ),
    );
  }

  final type = ['Autonomy', 'Belonging', 'Competence'];
  final subType = [
    'Actions',
    'Overcoming Challenges',
    'Success Indicators (KPIs)',
    'Implementation',
    'Impact and Outcome',
    'Future'
  ];
  String question = 'Loading...';
  String? typeValue = 'Autonomy';
  String? subTypeValue = 'Actions';
  final TextEditingController questionController = TextEditingController();

  AppBar myAppBar() {
    return AppBar(
      title: const Text("Edit Question"),
      backgroundColor: adminAppBarColor,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    );
  }

  myBodySection() {
    double spacer = 10;
    return Align(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        child: Container(
          color: adminBackgroundColor,
          width: 500,
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Column(
            children: [
              verticleSpacer(spacer),
              typeSelectionMenu(),
              verticleSpacer(spacer),
              verticleSpacer(6),
              subTypeSelectionMenu(),
              verticleSpacer(spacer),
              verticleSpacer(6),
              questionSection(),
              verticleSpacer(spacer),
              Wrap(
                children: [
                  buttonDeleteQuestion(context),
                  buttonAddQuestion(context),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  subTypeSelectionMenu() {
    return DropdownButtonHideUnderline(
      child: DropdownButtonFormField(
        decoration: mySubTypeBox(),
        value: subTypeValue,
        isExpanded: true,
        items: subType.map(buildMenuItem).toList(),
        onChanged: (String? value) {
          subTypeValue = value;
        },
      ),
    );
  }

  typeSelectionMenu() {
    return DropdownButtonHideUnderline(
      child: DropdownButtonFormField(
          decoration: myTypeBox(),
          value: typeValue,
          isExpanded: true,
          items: type.map(buildMenuItem).toList(),
          onChanged: (String? value) {
            typeValue = value;
          }),
    );
  }

  InputDecoration myTypeBox() {
    return InputDecoration(
      enabled: true,
      contentPadding: const EdgeInsets.all(12.0),
      labelText: "Type",
      border: InputBorder.none,
      labelStyle: TextStyle(
        fontSize: 16.sp,
        color: orangeColor,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(5.0),
        ),
        borderSide: BorderSide(color: orangeColor),
      ),
    );
  }

  InputDecoration mySubTypeBox() {
    return InputDecoration(
      enabled: true,
      contentPadding: const EdgeInsets.all(12.0),
      labelText: "Sub Type",
      border: InputBorder.none,
      labelStyle: TextStyle(
        fontSize: 16.sp,
        color: orangeColor,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(5.0),
        ),
        borderSide: BorderSide(color: orangeColor),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
        ),
      );

  TextField questionSection() {
    return TextField(
      style: const TextStyle(fontSize: 16),
      keyboardType: TextInputType.multiline,
      minLines: 10,
      maxLines: null,
      controller: questionController,
      decoration: InputDecoration(
        labelText: "Question",
        labelStyle: TextStyle(color: iconColor),
        contentPadding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
        border: const OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey, width: 1.0),
          borderRadius: BorderRadius.circular(05.0),
        ),
      ),
    );
  }

  GestureDetector buttonAddQuestion(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (questionController.text.isNotEmpty) {
          editQuestion(context);
          Utils.showSnackBar("The changes has been saved");
        } else {
          Utils.showSnackBar("Please write down a question");
        }
      },
      child: Container(
        alignment: Alignment.center,
        width: 200,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        decoration: BoxDecoration(
          color: adminAppBarColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: const Text(
          "Save Changes",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }

  GestureDetector buttonDeleteQuestion(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final shouldPop = await showWarning(context);
        shouldPop ?? false;
      },
      child: Container(
        alignment: Alignment.center,
        width: 200,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        margin: const EdgeInsets.only(right: 36),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(30),
        ),
        child: const Text(
          "Delete",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }

  Future<bool?> showWarning(BuildContext context) async => showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(
            "Warning!!!",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text("Are you sure you want to delete this question"),
          actions: [
            ElevatedButton(
              onPressed: () {
                deleteThisQuestion();
                Utils.showSnackBar("A question has been deleted");
                Navigator.pop(context, true);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text("Yes"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, false),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: const Text("No"),
            ),
          ],
        ),
      );

  readQuestionData() async {
    dynamic questionString =
        await DatabaseService.getQuestion(widget.questionId);
    List<String> arr = questionString.split('*');
    question = arr[0].toString();
    typeValue = arr[1].toString();
    subTypeValue = arr[2].toString();
    questionController.text = question;
  }

  void editQuestion(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    log("typeValue = $typeValue, subTypeValue = $subTypeValue");
    await DatabaseService.updateQuestion(
      widget.questionId,
      questionController.text,
      typeValue.toString(),
      subTypeValue.toString(),
    );
    if (!mounted) return;
    Navigator.pop(context);
  }

  void deleteThisQuestion() async {
    await DatabaseService.deleteQuestion(widget.questionId);
    if (!mounted) return;
    Navigator.pop(context);
  }
}
