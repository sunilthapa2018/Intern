import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motivational_leadership/services/database.dart';
import 'package:motivational_leadership/ui/common/widget/verticle_spacer.dart';
import 'package:motivational_leadership/utility/colors.dart';
import 'package:motivational_leadership/utility/utils.dart';

class AddQuestion extends StatefulWidget {
  const AddQuestion({Key? key}) : super(key: key);

  @override
  State<AddQuestion> createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(),
      body: myBodySection(),
      backgroundColor: adminBackgroundColor,
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
  String? typeValue = 'Autonomy';
  String? subTypeValue = 'Actions';
  TextEditingController questionController = TextEditingController();

  AppBar myAppBar() {
    return AppBar(
      title: const Text("Add Question"),
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
              buttonAddQuestion(context),
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
        onChanged: (String? value) => setState(
          () {
            subTypeValue = value;
          },
        ),
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
        onChanged: (String? value) => setState(
          () {
            typeValue = value;
          },
        ),
      ),
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
        color: Colors.grey,
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        ),
        borderSide: BorderSide(color: Colors.grey),
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        ),
        borderSide: BorderSide(color: Colors.grey),
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
        color: Colors.grey,
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        ),
        borderSide: BorderSide(color: Colors.grey),
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        ),
        borderSide: BorderSide(color: Colors.grey),
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
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey, width: 1.0),
          borderRadius: BorderRadius.circular(5.0),
        ),
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
          addQuestion(context);
        } else {
          Utils.showSnackBar("Please write down a question");
        }
      },
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        decoration: BoxDecoration(
          color: adminAppBarColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: const Text(
          "Save Question",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }

  void addQuestion(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    try {
      String question = questionController.text.trim();

      await DatabaseService.addQuestionToDatabase(
          question, typeValue.toString(), subTypeValue.toString());
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message);
    }
    if (!mounted) return;
    Navigator.pop(context);
    Utils.showSnackBar("A new question has been added to the database");
  }
}
