import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:motivational_leadership/services/database.dart';
import 'package:motivational_leadership/services/send_email.dart';
import 'package:motivational_leadership/ui/common/widget/verticle_spacer.dart';
import 'package:motivational_leadership/ui/student/widgets/app_bar.dart';
import 'package:motivational_leadership/utility/colors.dart';
import 'package:motivational_leadership/utility/utils.dart';

class StudentContactUs extends StatefulWidget {
  const StudentContactUs({super.key});

  @override
  State<StudentContactUs> createState() => _StudentContactUsState();
}

class _StudentContactUsState extends State<StudentContactUs> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: myAppBar(context),
        body: buildMainBody(),
      ),
    );
  }

  TextEditingController subjectController = TextEditingController();
  TextEditingController emailBodyController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  buildMainBody() {
    double spacer = 16;
    return Container(
      padding: const EdgeInsets.all(0),
      color: backgroundColor,
      height: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: [
            letsStart(),
            verticleSpacer(6),
            buildImage(),
            Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Column(
                  children: [
                    verticleSpacer(spacer),
                    subject(),
                    verticleSpacer(spacer),
                    emailBody(),
                    verticleSpacer(spacer),
                    sendButton(),
                    verticleSpacer(spacer),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector sendButton() {
    return GestureDetector(
      onTap: () async {
        if (formKey.currentState!.validate()) {
          String subject = subjectController.text;
          String message = emailBodyController.text;
          String uid = FirebaseAuth.instance.currentUser!.uid;
          String? email = FirebaseAuth.instance.currentUser!.email;
          String name = await DatabaseService.getUserName(uid);

          try {
            EmailServices.sendContactUs(
                name: name,
                email: email.toString(),
                subject: subject,
                message: message);
            Utils.showSnackBar(
                "Your Email has been successfully sent to us. We will reply shortly.");
            subjectController.text = "";
            emailBodyController.text = "";
          } on Exception catch (_, e) {
            Utils.showSnackBar("Error : $e");
          }
        } else {
          Utils.showSnackBar(
              "Please make sure everything on this form is filled !");
        }
      },
      child: buttonDesign(),
    );
  }

  Container buttonDesign() {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width / 3,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
          color: buttonColor, borderRadius: BorderRadius.circular(25)),
      child: Text(
        "Send Email",
        style: TextStyle(fontSize: 14.sp, color: Colors.white),
      ),
    );
  }

  letsStart() {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          "Contact Us",
          style: Theme.of(context).textTheme.headline3,
        ),
      ),
    );
  }

  TextFormField emailBody() {
    return TextFormField(
      style: TextStyle(fontSize: 14.sp),
      keyboardType: TextInputType.multiline,
      minLines: 10,
      maxLines: null,
      controller: emailBodyController,
      validator: MultiValidator([
        RequiredValidator(errorText: 'Required'),
      ]),
      decoration: InputDecoration(
        labelText: "My message *",
        labelStyle: TextStyle(color: iconColor),
        contentPadding: const EdgeInsets.fromLTRB(16, 30, 20, 0),
        border: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: iconColor, width: 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: iconColor, width: 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  subject() {
    return TextFormField(
      style: TextStyle(fontSize: 14.sp),
      controller: subjectController,
      validator: MultiValidator([
        RequiredValidator(errorText: 'Required'),
      ]),
      decoration: InputDecoration(
        labelText: "Subject *",
        labelStyle: TextStyle(color: iconColor),
        contentPadding: const EdgeInsets.fromLTRB(16, 30, 20, 0),
        border: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: iconColor, width: 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: iconColor, width: 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  Padding buildImage() {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(),
      child: Image.asset(
        'assets/team_image.jpg',
        width: width,
        fit: BoxFit.contain,
      ),
    );
  }

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }
}
