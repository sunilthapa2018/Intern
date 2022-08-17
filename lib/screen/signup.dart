import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:motivational_leadership/Utility/utils.dart';
import 'package:motivational_leadership/screen/signin.dart';
import 'package:motivational_leadership/services/database.dart';
import 'package:page_transition/page_transition.dart';

import '../main.dart';


class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose(){
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.white));
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
          //autovalidateMode: AutovalidateMode.always,
          key: formKey,
          child: Column(
            children: [
              Container(
                child: Column(
                  children: [
                    Container(
                      color: Colors.white,
                      child: Row(
                          children: [
                            Text(
                              'Register',
                              style: TextStyle(
                                //color: Color(0xFFff6600),
                                color: Color(0xFF2e3c96),
                                fontWeight: FontWeight.w900,
                                fontSize: 36,
                              ),
                            ),
                            Text(
                              ' User!',
                              style: TextStyle(
                                color: Color(0xFFff6600),
                                fontWeight: FontWeight.w900,
                                fontSize: 36,
                              ),
                            ),
                          ]),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                      child: Image.asset('assets/logo.png',
                        height: 100,
                        width: 130,
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                          labelText: "Full Name",
                          hintText: "Enter your Full Name"
                      ),
                      validator: MultiValidator(
                          [
                            RequiredValidator(errorText: 'Required'),
                          ]
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                          labelText: "Email",
                          hintText: "Enter your Email Address"),
                      validator: MultiValidator(
                        [
                          RequiredValidator(errorText: 'Required'),
                          EmailValidator(errorText: "Not A Valid Email"),
                        ]
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: "Password",
                        hintText: "Enter your Password"
                      ),
                      obscureText: true,
                      validator: MultiValidator(
                          [
                            RequiredValidator(errorText: 'Required'),
                            MinLengthValidator(6, errorText: "It should be at least 6 characters"),
                            MaxLengthValidator(15, errorText: "It should be Max 15 characters"),
                          ]
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    TextFormField(
                      controller: phoneController,
                      decoration: InputDecoration(
                          //border: OutlineInputBorder(),
                          labelText: "Phone No",
                          hintText: "Enter your Phone Number"
                      ),
                      validator: MultiValidator(
                          [
                            MaxLengthValidator(10, errorText: "It should be at least 10 characters"),
                          ]
                      ),
                    ),

                    SizedBox(
                      height: 24,
                    ),

                    GestureDetector(
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          RegisterUser();
                        }else{
                          Utils.showSnackBar("Please make sure everything on this form is valid !");
                        }
                      },
                      child:Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                        decoration: BoxDecoration(
                            color: Color(0xFF2e3c96),
                            borderRadius: BorderRadius.circular(30)),
                        child: Text(
                          "Sign Up",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
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

  Future RegisterUser() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );
    try {
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      String name = nameController.text.trim();
      String phone = phoneController.text.trim();

      //create user for authentication
      UserCredential result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;
      await DatabaseService(uid: user!.uid).updateUserData(name, phone, "student");
      //print("MYTAG : uid = " + user.uid);

    } on FirebaseAuthException catch (e) {
      print(e);
      Utils.showSnackBar(e.message);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

}
