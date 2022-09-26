import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:motivational_leadership/main.dart';
import 'package:motivational_leadership/utility/colors.dart';
import 'package:motivational_leadership/utility/utils.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(),
      body: myBody(context),
    );
  }

  SizedBox myBody(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Form(
            autovalidateMode: AutovalidateMode.always,
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  color: Colors.white,
                  child: Row(children: [
                    Text(
                      'Forgot',
                      style: TextStyle(
                        //color: Color(0xFFff6600),
                        color: const Color(0xFF2e3c96),
                        fontWeight: FontWeight.w900,
                        fontSize: 36.sp,
                      ),
                    ),
                    Text(
                      ' Password?',
                      style: TextStyle(
                        color: const Color(0xFFff6600),
                        fontWeight: FontWeight.w900,
                        fontSize: 36.sp,
                      ),
                    ),
                  ]),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 40),
                  child: Image.asset(
                    'assets/logo.png',
                    height: 100.h,
                    width: 130.w,
                    fit: BoxFit.contain,
                  ),
                ),
                TextFormField(
                  style: TextStyle(fontSize: 14.sp),
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: "Email",
                    labelStyle: TextStyle(fontSize: 14.sp),
                    hintText: "Enter your Email Address",
                    hintStyle: TextStyle(fontSize: 14.sp),
                    errorStyle: TextStyle(fontSize: 14.sp),
                  ),
                  validator: MultiValidator([
                    RequiredValidator(errorText: 'Required'),
                    EmailValidator(errorText: "Not A Valid Email"),
                  ]),
                ),
                const SizedBox(height: 6),
                const SizedBox(height: 24),
                GestureDetector(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      resetPassword();
                    } else {
                      Utils.showSnackBar('Please enter a valid Email Address');
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width / 2,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 20),
                    decoration: BoxDecoration(
                        color: buttonColor,
                        borderRadius: BorderRadius.circular(30)),
                    child: Text(
                      "Reset Password",
                      style: TextStyle(fontSize: 16.sp, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      iconTheme: IconThemeData(color: iconColor),
      backgroundColor: appBarColor,
      elevation: 0,
      titleSpacing: 0,
      toolbarHeight: 36,
      // systemOverlayStyle: SystemUiOverlayStyle.dark,
    );
  }

  Future forgotPassword() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  Future resetPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      Utils.showSnackBar('Password Reset Email has been sent');
    } on FirebaseAuthException {
      Utils.showSnackBar(
          'This Email Address is not registered in our system. Please enter a valid Email Address');
    }
  }
}
