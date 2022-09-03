import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:motivational_leadership/main.dart';
import 'package:motivational_leadership/ui/auth/forget_password_page.dart';
import 'package:motivational_leadership/ui/auth/sign_up_page.dart';
import 'package:motivational_leadership/utility/base_utils.dart';
import 'package:motivational_leadership/utility/colors.dart';
import 'package:motivational_leadership/utility/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: appBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              welcomeTitle(),
              companyLogo(),
              txtEmail(),
              spacerSixPixel(),
              txtPassword(),
              spacerTwentyPixel(),
              signInButton(context),
              spacerTwentyPixel(),
              forgotPassword(context),
              spacerTwentyPixel(),
              signUp(context),
            ],
          ),
        ),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      toolbarHeight: 0,
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  SizedBox spacerTwentyPixel() {
    return const SizedBox(
      height: 24,
    );
  }

  SizedBox spacerSixPixel() {
    return const SizedBox(
      height: 24,
    );
  }

  Row signUp(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Don\'t have an account? ',
            style: TextStyle(color: Colors.black87, fontSize: 17)),
        GestureDetector(
          onTap: () {
            navigateTo(
                context: context,
                nextPage: const SignUp(),
                currentPage: widget);
          },
          child: const Text('Sign Up',
              style: TextStyle(
                  color: Colors.black87,
                  decoration: TextDecoration.underline,
                  fontSize: 17)),
        ),
      ],
    );
  }

  GestureDetector forgotPassword(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateTo(
          context: context,
          nextPage: const ForgotPassword(),
          currentPage: widget,
        );
      },
      child: const Text('Forgot Password?',
          style: TextStyle(
              color: Colors.black87,
              decoration: TextDecoration.underline,
              fontSize: 17)),
    );
  }

  GestureDetector signInButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (formKey.currentState!.validate()) {
          signIn();
        }
      },
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        decoration: BoxDecoration(
            color: const Color(0xFF2e3c96),
            borderRadius: BorderRadius.circular(30)),
        child: const Text(
          "Sign In",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }

  TextFormField txtPassword() {
    return TextFormField(
      controller: passwordController,
      decoration: const InputDecoration(
          labelText: "Password", hintText: "Enter your Password"),
      obscureText: true,
      validator: MultiValidator([
        MinLengthValidator(6, errorText: "It should be at least 6 characters"),
        MaxLengthValidator(15, errorText: "It should be Max 15 characters"),
      ]),
    );
  }

  TextFormField txtEmail() {
    return TextFormField(
      controller: emailController,
      decoration: const InputDecoration(
          labelText: "Email", hintText: "Enter your Email Address"),
      //validator: EmailValidator(errorText: "Not A Valid Email"),
      validator: MultiValidator([
        MinLengthValidator(1, errorText: "Please enter your email address"),
        EmailValidator(errorText: "Not A Valid Email"),
      ]),
    );
  }

  Padding companyLogo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      child: Image.asset(
        'assets/logo.png',
        height: 100,
        width: 130,
        fit: BoxFit.contain,
      ),
    );
  }

  Container welcomeTitle() {
    return Container(
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
      log("mytag $password is saved as password\n");
      log("Sign IN executed sucessfully");
      navigatorKey.currentState!.popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      log(e.toString());
      Utils.showSnackBar(e.message);
      Navigator.pop(context);
    }
  }

  AppBar newAppBar() {
    return AppBar(
      backgroundColor: appBarColor,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    );
  }
}

class SpacerSixPixel extends StatelessWidget {
  const SpacerSixPixel(
    int i, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 6,
    );
  }
}
