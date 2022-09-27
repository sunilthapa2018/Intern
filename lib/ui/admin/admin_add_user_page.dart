import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:motivational_leadership/services/database.dart';
import 'package:motivational_leadership/services/send_email.dart';
import 'package:motivational_leadership/ui/common/widget/verticle_spacer.dart';
import 'package:motivational_leadership/utility/colors.dart';
import 'package:motivational_leadership/utility/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: adminBackgroundColor,
      appBar: appBar(),
      body: myBody(context),
    );
  }

  final userType = ['Student', 'Coach', 'Admin'];
  String? userTypeValue = 'Student';

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
  void initState() {
    super.initState();
  }

  Container myBody(BuildContext context) {
    double val = 12;
    return Container(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: Form(
        key: formKey,
        child: Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            width: 600.h,
            child: ListView(
              children: [
                verticleSpacer(val),
                title(),
                _buildLogo(),
                verticleSpacer(val),
                _buildNameTextField(),
                verticleSpacer(val),
                _buildEmailTextField(),
                verticleSpacer(val),
                _buildPasswordTextfield(),
                verticleSpacer(val),
                phone(),
                verticleSpacer(12),
                usertypeSelectionMenu(),
                verticleSpacer(24),
                buttonSignup(context),
                verticleSpacer(val),
              ],
            ),
          ),
        ),
      ),
    );
  }

  GestureDetector buttonSignup(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (formKey.currentState!.validate()) {
          saveUserCredentials();
          registerUser(context);
        } else {
          Utils.showSnackBar(
              "Please make sure everything on this form is valid !");
        }
      },
      child: buttonDesign(context),
    );
  }

  buttonDesign(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          width: 160.w,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
              color: buttonColor, borderRadius: BorderRadius.circular(25)),
          child: const Text(
            "Sign Up",
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ],
    );
  }

  TextFormField phone() {
    return TextFormField(
      autofocus: true,
      textInputAction: TextInputAction.next,
      controller: phoneController,
      decoration: const InputDecoration(
        labelText: "Phone No",
        hintText: "Enter your Phone Number",
        border: OutlineInputBorder(),
      ),
      validator: MultiValidator([
        MaxLengthValidator(10,
            errorText: "It should be at least 10 characters"),
      ]),
    );
  }

  Container usertypeSelectionMenu() {
    return Container(
      padding: const EdgeInsets.only(left: 10),
      decoration: myBox(),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          value: userTypeValue,
          isExpanded: true,
          items: userType.map(buildMenuItem).toList(),
          onChanged: (String? value) => setState(() {
            userTypeValue = value;
            //notifyChanges();
          }),
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
        ),
      );

  BoxDecoration myBox() {
    return BoxDecoration(border: Border.all(color: Colors.grey, width: 1));
  }

  TextFormField _buildPasswordTextfield() {
    return TextFormField(
      autofocus: true,
      textInputAction: TextInputAction.next,
      controller: passwordController,
      decoration: const InputDecoration(
        labelText: "Password",
        hintText: "Enter your Password",
        border: OutlineInputBorder(),
      ),
      obscureText: true,
      validator: MultiValidator([
        RequiredValidator(errorText: 'Required'),
        MinLengthValidator(6, errorText: "It should be at least 6 characters"),
        MaxLengthValidator(15, errorText: "It should be Max 15 characters"),
      ]),
    );
  }

  title() {
    return Row(
      children: const [
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
      ],
    );
  }

  AppBar appBar() {
    return AppBar(
      title: const Text("Add new user"),
      backgroundColor: adminAppBarColor,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
  }

  TextFormField _buildEmailTextField() {
    return TextFormField(
      autofocus: true,
      textInputAction: TextInputAction.next,
      controller: emailController,
      decoration: const InputDecoration(
        labelText: "Email",
        hintText: "Enter your Email Address",
        border: OutlineInputBorder(),
      ),
      validator: MultiValidator([
        RequiredValidator(errorText: 'Required'),
        EmailValidator(errorText: "Not A Valid Email"),
      ]),
    );
  }

  TextFormField _buildNameTextField() {
    return TextFormField(
      autofocus: true,
      // textInputAction: TextInputAction.next,
      controller: nameController,
      decoration: const InputDecoration(
        labelText: "Full Name",
        hintText: "Enter your Full Name",
        border: OutlineInputBorder(),
      ),
      validator: MultiValidator([
        RequiredValidator(errorText: 'Required'),
      ]),
    );
  }

  Padding _buildLogo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      child: Image.asset(
        'assets/app_icon.png',
        height: 100,
        width: 130,
        fit: BoxFit.contain,
      ),
    );
  }

  Future registerUser(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    try {
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      String name = nameController.text.trim();
      String phone = phoneController.text.trim();
      String userType = userTypeValue.toString();

      //create user for authentication
      UserCredential result =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;
      await DatabaseService.updateUserData(
          user!.uid, name, phone, userType, email);
      var splitted = name.split(' ');
      String firstName = splitted[0];
      EmailServices.sendNewUserRegistrationEmail(
        email: email,
        name: firstName,
        password: password,
      );
      resetForm();
      Utils.showSnackBar("A new user has been added");
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message);
    }
    if (!mounted) return;
    Navigator.pop(context);
  }

  void resetForm() {
    emailController.text = "";
    passwordController.text = "";
    nameController.text = "";
    phoneController.text = "";
    userTypeValue = "Student";
    setState(() {});
  }

  Future<void> saveUserCredentials() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    String email = await DatabaseService.getUserEmail(uid);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
    await prefs.setBool('fromAdmin', true);
  }
}
