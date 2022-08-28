import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:motivational_leadership/main.dart';
import 'package:motivational_leadership/utility/base_util.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailController = new TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: Container(
        //color: Colors.deepOrange,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          key: formKey,
          child: Column(
            children: [
              Container(
                child: Column(
                  children: [
                    Container(
                      color: Colors.white,
                      child: Row(children: [
                        Text(
                          'Forgot',
                          style: TextStyle(
                            //color: Color(0xFFff6600),
                            color: Color(0xFF2e3c96),
                            fontWeight: FontWeight.w900,
                            fontSize: 36,
                          ),
                        ),
                        Text(
                          ' Password?',
                          style: TextStyle(
                            color: Color(0xFFff6600),
                            fontWeight: FontWeight.w900,
                            fontSize: 36,
                          ),
                        ),
                      ]),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 0, vertical: 40),
                      child: Image.asset(
                        'assets/logo.png',
                        height: 100,
                        width: 130,
                        fit: BoxFit.contain,
                      ),
                    ),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Email",
                          hintText: "Enter your Email Address"),
                      validator: MultiValidator([
                        RequiredValidator(errorText: 'Required'),
                        EmailValidator(errorText: "Not A Valid Email"),
                      ]),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          try {
                            resetPassword();
                          } on FirebaseAuthException catch (e) {
                            print(e);
                            Utils.showSnackBar(e.message);
                          }
                        } else {
                          Utils.showSnackBar(
                              'Please enter valid Email Address');
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                        decoration: BoxDecoration(
                            color: Color(0xFF2e3c96),
                            borderRadius: BorderRadius.circular(30)),
                        child: Text(
                          "Reset Password",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 80,
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Future ForgotPassword() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  Future resetPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      Utils.showSnackBar('Password Reset Email has been sent');
    } on FirebaseAuthException catch (e) {
      print(e);
      Utils.showSnackBar(e.message);
    }
  }
}
