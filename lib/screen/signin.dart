import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:motivational_leadership/Utility/utils.dart';
import 'package:motivational_leadership/page/home_page.dart';
import 'package:motivational_leadership/screen/forget_password.dart';
import 'package:motivational_leadership/screen/signup.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../main.dart';


class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.white));

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
                                'Welcome!',
                                style: TextStyle(
                                  color: Color(0xFFff6600),
                                  //color: Color(0xFF2e3c96),
                                  fontWeight: FontWeight.w900,
                                  fontSize: 36,
                                ),
                              ),
                              // Text(
                              //   ' back!',
                              //   style: TextStyle(
                              //     color: Color(0xFFff6600),
                              //     fontWeight: FontWeight.w900,
                              //     fontSize: 36,
                              //   ),
                              // ),
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
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                            labelText: "Email",
                            hintText: "Enter your Email Address"
                        ),
                        //validator: EmailValidator(errorText: "Not A Valid Email"),
                        validator: MultiValidator(
                            [
                              MinLengthValidator(1, errorText: "Please enter your email address"),
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
                              MinLengthValidator(6, errorText: "It should be at least 6 characters"),
                              MaxLengthValidator(15, errorText: "It should be Max 15 characters"),
                            ]
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),

                      GestureDetector(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            signIn();
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
                              "Sign In",
                              style: TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(PageTransition(
                              type: PageTransitionType.rightToLeftJoined,
                              childCurrent: widget,
                              duration: Duration(milliseconds: 300),
                              reverseDuration: Duration(milliseconds: 300),
                              child: ForgotPassword()
                          ));
                          },
                        child: Container(
                          child: Text('Forgot Password?',
                              style: TextStyle(
                                  color: Colors.black87,
                                  decoration: TextDecoration.underline,
                                  fontSize: 17)),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Don\'t have an account? ',
                              style:
                                  TextStyle(color: Colors.black87, fontSize: 17)),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(PageTransition(
                                type: PageTransitionType.rightToLeftJoined,
                                  childCurrent: widget,
                                  duration: Duration(milliseconds: 300),
                                  reverseDuration: Duration(milliseconds: 300),
                                  child: SignUp()
                              ));
                              //HomePage();
                            },
                            child: Container(
                              child: Text('Sign Up',
                                  style: TextStyle(
                                    color: Colors.black87,
                                    decoration: TextDecoration.underline,
                                    fontSize: 17)),
                            ),
                          ),
                        ],
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

  Future signIn() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator()),
    );
    try {
      String _email = emailController.text.trim();
      String _password = passwordController.text.trim();
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email,
          password: _password,
      );

      // obtain shared preferences
      final prefs = await SharedPreferences.getInstance();

      // set value
      await prefs.setString('password', _password);
      print("mytag " + _password + " is saved as password\n");

    } on FirebaseAuthException catch (e) {
      print(e);
      Utils.showSnackBar(e.message);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
