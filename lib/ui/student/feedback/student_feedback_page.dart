import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:motivational_leadership/services/database.dart';
import 'package:motivational_leadership/ui/common/widget/help_dialog_box.dart';
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

  AppBar appBar(BuildContext context, String title) {
    return AppBar(
      iconTheme: IconThemeData(color: iconColor),
      backgroundColor: appBarColor,
      elevation: 0,
      titleSpacing: 0,
      toolbarHeight: 36,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      automaticallyImplyLeading: false, // Don't show the leading button
      title: Padding(
        padding: const EdgeInsets.only(right: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back, color: iconColor),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: TextButton.icon(
                    onPressed: () {
                      loadInfo(context,
                          "If feedback has been given by coach to selected TYPE and SUB-TYPE then feedback will be shown automatically.");
                    },
                    label: Text(
                      "Help",
                      style: TextStyle(fontSize: 16.sp, color: iconColor),
                    ),
                    icon: Icon(
                      FontAwesomeIcons.solidCircleQuestion,
                      color: iconColor,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  myBodySection() {
    double spacer = 10;
    return Container(
      padding: const EdgeInsets.all(0),
      color: backgroundColor,
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          child: Column(
            children: [
              textTitle(),
              verticleSpacer(spacer),
              verticleSpacer(spacer),
              typeSelectionMenu(),
              verticleSpacer(spacer),
              verticleSpacer(spacer),
              subTypeSelectionMenu(),
              verticleSpacer(spacer),
              verticleSpacer(spacer),
              feebackSection(),
              verticleSpacer(spacer),
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
            notifyChanges();
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
            notifyChanges();
          },
        ),
      ),
    );
  }

  InputDecoration myTypeBox() {
    return InputDecoration(
      enabled: true,
      contentPadding: const EdgeInsets.all(12.0),
      labelText: "Module",
      border: InputBorder.none,
      labelStyle: TextStyle(
        fontSize: 14.sp,
        color: orangeColor,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(5.0),
        ),
        borderSide: BorderSide(color: orangeColor),
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
      labelText: "Activity",
      border: InputBorder.none,
      labelStyle: TextStyle(
        fontSize: 14.sp,
        color: orangeColor,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(5.0),
        ),
        borderSide: BorderSide(color: orangeColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(5.0),
        ),
        borderSide: BorderSide(color: orangeColor),
      ),
    );
  }

  TextField feebackSection() {
    return TextField(
      enableInteractiveSelection: false,
      readOnly: true,
      style: const TextStyle(fontSize: 14),
      keyboardType: TextInputType.multiline,
      minLines: 18,
      maxLines: null,
      controller: feedbackController,
      decoration: InputDecoration(
        labelText: "Feedback",
        labelStyle: TextStyle(color: iconColor),
        contentPadding: const EdgeInsets.fromLTRB(12, 30, 20, 0),
        border: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: iconColor, width: 1.0),
          borderRadius: BorderRadius.circular(15.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: iconColor, width: 1.0),
          borderRadius: BorderRadius.circular(15.0),
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
