import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:motivational_leadership/Utility/utils.dart';
import 'package:motivational_leadership/screen/signin.dart';
import 'package:motivational_leadership/services/database.dart';
import 'package:page_transition/page_transition.dart';
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
                      //initialValue: 'Sunil',
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
                          updateUserDetails();
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
                          "Save Changes",
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

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> updateUserDetails() async{
    //Updating user email and password
    String _email = emailController.text.trim();
    String _pass = passwordController.text.trim();
    final user = FirebaseAuth.instance.currentUser;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );

    try {

      //Reading saved password from local db and re-authenticating user with credentials
      final prefs = await SharedPreferences.getInstance();
      final _savedPass = prefs.getString('password').toString();
      AuthCredential credential = EmailAuthProvider.credential(email: email, password: _savedPass);
      await FirebaseAuth.instance.currentUser!.reauthenticateWithCredential(credential);

      await user!.updateEmail(_email);
      if(_pass!="" || !_pass.isEmpty){
        await user.updatePassword(_pass);
        await prefs.setString('password', _pass);
      }
    } on FirebaseAuthException catch (e) {
      print("mytag " + e.toString());
      Utils.showSnackBar("Failed to update user: $e.message");
    }

    //Updating user name and phone number
    String _name = nameController.text.trim();
    String _phone = phoneController.text.trim();

    try{
      users.doc(uid).update({'full name': _name,'phone': _phone});
      Utils.showSnackBar("User details have been updated");
    } on FirebaseAuthException catch (e) {
      print("mytag " + e.toString());
      Utils.showSnackBar("Failed to update user: $e.message");
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);

    // return users
    //     .doc(uid)
    //     .update({
    //       'full name': _name,
    //       'phone': _phone
    //     })
    //     .then((value){
    //         Utils.showSnackBar("User details have been updated");
    //         navigatorKey.currentState!.popUntil((route) => route.isFirst);
    //     })
    //     .catchError((error) {
    //       print("Failed to update user: $error");
    //       navigatorKey.currentState!.popUntil((route) => route.isFirst);
    //     }
    //
    // );

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
        print('Document data: ${documentSnapshot.data()}\n');
        print('Full name : ' + name + ' phone : ' + phone + '\n');
        nameController.text = name;
        emailController.text = email;
        phoneController.text = phone;
      } else {
        print('Document does not exist on the database');
      }
    });
  }

  void initState() {
    super.initState();
    pupulateData();
  }


}
