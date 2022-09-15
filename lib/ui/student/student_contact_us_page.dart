import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:motivational_leadership/services/database.dart';
import 'package:motivational_leadership/services/send_email.dart';
import 'package:motivational_leadership/ui/common/widget/verticle_spacer.dart';
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
    return Scaffold(
      appBar: myAppBar(),
      body: buildMainBody(),
    );
  }

  TextEditingController subjectController = TextEditingController();
  TextEditingController emailBodyController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  AppBar myAppBar() {
    return AppBar(
      titleSpacing: 0,
      toolbarHeight: 36,
      iconTheme: IconThemeData(color: iconColor),
      backgroundColor: appBarColor,
      elevation: 0,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );
  }

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
            SendEmail.send(
                name: name,
                email: email.toString(),
                subject: subject,
                message: message);
            Utils.showSnackBar(
                "Your Email has been successfully sent to us. We will reply shortly.");
          } on Exception catch (_, e) {
            Utils.showSnackBar("Error : $e");
          }
          // launchEmailClient(
          //   subject: subject,
          //   message: message,
          // );
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
      width: MediaQuery.of(context).size.width / 2,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
          color: buttonColor, borderRadius: BorderRadius.circular(30)),
      child: const Text(
        "Send Email",
        style: TextStyle(fontSize: 16, color: Colors.white),
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
      style: const TextStyle(fontSize: 16),
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
      style: const TextStyle(fontSize: 16),
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

  // void launchEmailClient(
  //     {required String subject, required String message}) async {
  //   // String newMessage = "$message\n Sent From the App.";

  //   final Uri emailLaunchUri = Uri(
  //     scheme: 'mailto',
  //     // path: 'nicholai@leadershipdevelopment.training',
  //     path: 'stsoft2016@gmail.com',
  //     query: encodeQueryParameters(<String, String>{
  //       'subject': subject,
  //       'body': message,
  //     }),
  //   );
  //   launchUrl(emailLaunchUri);
  // }

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }
}
