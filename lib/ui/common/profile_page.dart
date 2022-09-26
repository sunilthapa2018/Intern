import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:motivational_leadership/main.dart';
import 'package:motivational_leadership/ui/common/widget/verticle_spacer.dart';
import 'package:motivational_leadership/ui/student/widgets/app_bar.dart';
import 'package:motivational_leadership/utility/colors.dart';
import 'package:motivational_leadership/utility/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.white));
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: myAppBar(context),
        body: myBody(context),
      ),
    );
  }

  String uid = FirebaseAuth.instance.currentUser!.uid;
  String name = "";
  String email = FirebaseAuth.instance.currentUser!.email.toString();
  String password = "SuperSecretPassword";
  String phone = "";

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  SingleChildScrollView myBody(BuildContext context) {
    double space = 6.sp;
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Column(
                children: [
                  myTitle(),
                  myLogo(),
                  verticleSpacer(space),
                  fullName(),
                  verticleSpacer(space),
                  myEmail(),
                  verticleSpacer(space),
                  myPassword(),
                  verticleSpacer(space),
                  myPhoneNumber(),
                  verticleSpacer(16),
                  mySave(context),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector mySave(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (formKey.currentState!.validate()) {
          updateUserDetails();
        } else {
          Utils.showSnackBar(
              "Please make sure everything on this form is valid !");
        }
      },
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width / 2,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        decoration: BoxDecoration(
            color: buttonColor, borderRadius: BorderRadius.circular(30)),
        child: Text(
          "Save Changes",
          style: TextStyle(fontSize: 16.sp, color: Colors.white),
        ),
      ),
    );
  }

  TextFormField myPhoneNumber() {
    return TextFormField(
      style: TextStyle(fontSize: 14.sp, color: Colors.black),
      onFieldSubmitted: (value) {
        validateForm();
      },
      textInputAction: TextInputAction.done,
      controller: phoneController,
      decoration: const InputDecoration(
          //border: OutlineInputBorder(),
          labelText: "Phone No",
          hintText: "Enter your Phone Number"),
      validator: MultiValidator([
        MaxLengthValidator(10,
            errorText: "It should be at least 10 characters"),
      ]),
    );
  }

  TextFormField myPassword() {
    return TextFormField(
      style: TextStyle(fontSize: 14.sp, color: Colors.black),
      textInputAction: TextInputAction.next,
      controller: passwordController,
      decoration: const InputDecoration(
          labelText: "Password", hintText: "Enter your Password"),
      obscureText: true,
      validator: MultiValidator([
        MaxLengthValidator(15, errorText: "It should be Max 15 characters"),
      ]),
    );
  }

  TextFormField myEmail() {
    return TextFormField(
      textInputAction: TextInputAction.next,
      style: TextStyle(fontSize: 14.sp, color: Colors.black),
      controller: emailController,
      decoration: const InputDecoration(
          labelText: "Email", hintText: "Enter your Email Address"),
      validator: MultiValidator([
        RequiredValidator(errorText: 'Required'),
        EmailValidator(errorText: "Not A Valid Email"),
      ]),
    );
  }

  TextFormField fullName() {
    return TextFormField(
      style: TextStyle(fontSize: 14.sp, color: Colors.black),
      textInputAction: TextInputAction.next,
      controller: nameController,
      decoration: const InputDecoration(
          labelText: "Full Name", hintText: "Enter your Full Name"),
      validator: MultiValidator([
        RequiredValidator(errorText: 'Required'),
      ]),
    );
  }

  Padding myLogo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      child: Image.asset(
        'assets/logo.png',
        height: 100.h,
        width: 130.w,
        fit: BoxFit.contain,
      ),
    );
  }

  Container myTitle() {
    return Container(
      color: Colors.white,
      child: Row(children: [
        Text(
          'My',
          style: TextStyle(
            //color: Color(0xFFff6600),
            color: Colors.black87,
            fontWeight: FontWeight.w900,
            fontSize: 24.sp,
          ),
        ),
        Text(
          ' Profile',
          style: TextStyle(
            color: const Color(0xFFff6600),
            fontWeight: FontWeight.w900,
            fontSize: 24.sp,
          ),
        ),
      ]),
    );
  }

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> updateUserDetails() async {
    //Updating user email and password
    String email = emailController.text.trim();
    String pass = passwordController.text.trim();
    final user = FirebaseAuth.instance.currentUser;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    try {
      //Reading saved password from local db and re-authenticating user with credentials
      final prefs = await SharedPreferences.getInstance();
      final savedPass = prefs.getString('password').toString();
      AuthCredential credential =
          EmailAuthProvider.credential(email: email, password: savedPass);
      await FirebaseAuth.instance.currentUser!
          .reauthenticateWithCredential(credential);

      await user!.updateEmail(email);
      if (pass != "" || pass.isNotEmpty) {
        await user.updatePassword(pass);
        await prefs.setString('password', pass);
      }
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar("Failed to update user: $e.message");
    }

    //Updating user name and phone number
    String name = nameController.text.trim();
    String phone = phoneController.text.trim();

    try {
      users.doc(uid).update({'full name': name, 'phone': phone});
      Utils.showSnackBar("User details have been updated");
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar("Failed to update user: $e.message");
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  void pupulateData() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        name = documentSnapshot.get("full name");
        phone = documentSnapshot.get("phone");

        nameController.text = name;
        emailController.text = email;
        phoneController.text = phone;
      } else {
        Utils.showSnackBar(
            "Failed Error Message: Document does not exist on the database");
      }
    });
  }

  @override
  void initState() {
    super.initState();
    pupulateData();
  }

  void validateForm() {
    if (formKey.currentState!.validate()) {
      updateUserDetails();
    } else {
      Utils.showSnackBar("Please make sure everything on this form is valid !");
    }
  }
}
