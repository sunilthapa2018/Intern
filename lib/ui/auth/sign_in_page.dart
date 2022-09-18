import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:motivational_leadership/main.dart';
import 'package:motivational_leadership/services/database.dart';
import 'package:motivational_leadership/ui/auth/forget_password_page.dart';
import 'package:motivational_leadership/utility/base_utils.dart';
import 'package:motivational_leadership/utility/colors.dart';
import 'package:motivational_leadership/utility/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: appBar(),
        body: myBody(context),
      ),
    );
  }

  myBody(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Form(
        key: formKey,
        child: ListView(
          children: [
            spacerTwentyPixel(),
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
          ],
        ),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      toolbarHeight: 0,
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
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

  GestureDetector forgotPassword(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateTo(
          context: context,
          nextPage: const ForgotPassword(),
          currentPage: widget,
        );
      },
      child: const Align(
        alignment: Alignment.centerRight,
        child: Text('Forgot Password?',
            style: TextStyle(
                color: Colors.black87,
                decoration: TextDecoration.underline,
                fontSize: 16)),
      ),
    );
  }

  GestureDetector signInButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (formKey.currentState!.validate()) {
          signIn();
        }
      },
      child: buttonDesign(),
    );
  }

  buttonDesign() {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width / 2,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
              color: buttonColor, borderRadius: BorderRadius.circular(25)),
          child: const Text(
            "Sign In",
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ],
    );
  }

  TextFormField txtPassword() {
    return TextFormField(
      onFieldSubmitted: (value) {
        validateForm();
      },
      textInputAction: TextInputAction.done,
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
      autofocus: true,
      textInputAction: TextInputAction.next,
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
      builder: (context) => Container(
        color: backgroundColor,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
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

      String uid = FirebaseAuth.instance.currentUser!.uid;
      String name = await DatabaseService.getUserName(uid);
      await prefs.setString('name', name);

      navigatorKey.currentState!.popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message);
      if (!mounted) return;
      Navigator.of(context).pop();
    }
  }

  AppBar newAppBar() {
    return AppBar(
      backgroundColor: appBarColor,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    );
  }

  validateForm() {
    if (formKey.currentState!.validate()) {
      signIn();
    } else {
      Utils.showSnackBar("Please fill in all the details");
    }
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
