import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:motivational_leadership/ui/forget_password_page.dart';
import 'package:motivational_leadership/ui/signup_page.dart';
import 'package:motivational_leadership/utility/base_util.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.white));

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
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Column(
                children: [
                  Container(
                    color: Colors.white,
                    child: Row(children: const [
                      Text(
                        'Welcome!',
                        style: TextStyle(
                          color: Color(0xFFff6600),
                          //color: Color(0xFF2e3c96),
                          fontWeight: FontWeight.w900,
                          fontSize: 36,
                        ),
                      ),
                    ]),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                    child: Image.asset(
                      'assets/logo.png',
                      height: 100,
                      width: 130,
                      fit: BoxFit.contain,
                    ),
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                        labelText: "Email",
                        hintText: "Enter your Email Address"),
                    //validator: EmailValidator(errorText: "Not A Valid Email"),
                    validator: MultiValidator([
                      MinLengthValidator(1,
                          errorText: "Please enter your email address"),
                      EmailValidator(errorText: "Not A Valid Email"),
                    ]),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  TextFormField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                        labelText: "Password", hintText: "Enter your Password"),
                    obscureText: true,
                    validator: MultiValidator([
                      MinLengthValidator(6,
                          errorText: "It should be at least 6 characters"),
                      MaxLengthValidator(15,
                          errorText: "It should be Max 15 characters"),
                    ]),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        signIn();
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 20),
                      decoration: BoxDecoration(
                          color: const Color(0xFF2e3c96),
                          borderRadius: BorderRadius.circular(30)),
                      child: const Text(
                        "Sign In",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(PageTransition(
                          type: PageTransitionType.rightToLeftJoined,
                          childCurrent: widget,
                          duration: const Duration(milliseconds: 300),
                          reverseDuration: const Duration(milliseconds: 300),
                          child: const ForgotPassword()));
                    },
                    child: const Text('Forgot Password?',
                        style: TextStyle(
                            color: Colors.black87,
                            decoration: TextDecoration.underline,
                            fontSize: 17)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Don\'t have an account? ',
                          style:
                              TextStyle(color: Colors.black87, fontSize: 17)),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(PageTransition(
                              type: PageTransitionType.rightToLeftJoined,
                              childCurrent: widget,
                              duration: const Duration(milliseconds: 300),
                              reverseDuration:
                                  const Duration(milliseconds: 300),
                              child: SignUp()));
                          //HomePage();
                        },
                        child: const Text('Sign Up',
                            style: TextStyle(
                                color: Colors.black87,
                                decoration: TextDecoration.underline,
                                fontSize: 17)),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 80,
              ),
              const Spacer(),
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
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    try {
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // obtain shared preferences
      final prefs = await SharedPreferences.getInstance();

      // set value
      await prefs.setString('password', password);
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
