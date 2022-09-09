import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:motivational_leadership/utility/base_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.white));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: const Color(0xFFF2811D),
        // toolbarHeight: 0,
        // backgroundColor: Colors.transparent,
        // elevation: 0.0,
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
                        'My',
                        style: TextStyle(
                          //color: Color(0xFFff6600),
                          color: Color(0xFF2e3c96),
                          fontWeight: FontWeight.w900,
                          fontSize: 36,
                        ),
                      ),
                      Text(
                        ' Profile',
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
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                    child: Image.asset(
                      'assets/logo.png',
                      height: 100,
                      width: 130,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  TextFormField(
                    controller: nameController,
                    //initialValue: 'Sunil',
                    decoration: const InputDecoration(
                        labelText: "Full Name",
                        hintText: "Enter your Full Name"),
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Required'),
                    ]),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                        labelText: "Email",
                        hintText: "Enter your Email Address"),
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Required'),
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
                      MaxLengthValidator(15,
                          errorText: "It should be Max 15 characters"),
                    ]),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  TextFormField(
                    controller: phoneController,
                    decoration: const InputDecoration(
                        //border: OutlineInputBorder(),
                        labelText: "Phone No",
                        hintText: "Enter your Phone Number"),
                    validator: MultiValidator([
                      MaxLengthValidator(10,
                          errorText: "It should be at least 10 characters"),
                    ]),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  GestureDetector(
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
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 20),
                      decoration: BoxDecoration(
                          color: const Color(0xFF2e3c96),
                          borderRadius: BorderRadius.circular(30)),
                      child: const Text(
                        "Save Changes",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
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
        // name = doc["full name"];
        name = documentSnapshot.get("full name");
        phone = documentSnapshot.get("phone");

        nameController.text = name;
        emailController.text = email;
        phoneController.text = phone;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    pupulateData();
  }
}
