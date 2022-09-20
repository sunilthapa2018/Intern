import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motivational_leadership/main.dart';
import 'package:motivational_leadership/ui/common/widget/verticle_spacer.dart';
import 'package:motivational_leadership/utility/colors.dart';

class ErrorPage extends StatefulWidget {
  const ErrorPage({super.key});

  @override
  State<ErrorPage> createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(),
      body: myBody(),
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

  myBody() {
    return Container(
      padding: EdgeInsets.all(16.sp),
      color: backgroundColor,
      child: Column(
        children: [
          Expanded(child: companyLogo()),
          Expanded(
            child: Column(
              children: [
                myText(),
                verticleSpacer(20),
                GestureDetector(
                  child: buttonDesign(),
                  onTap: (() {
                    FirebaseAuth.instance.signOut();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return const MainPage();
                      }),
                    );
                  }),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  SelectableText myText() {
    return SelectableText(
      "Your Authentication has been REVOKED, please contact admin:\n\nEmail:\nnicholai@leadershipdevelopment.training",
      style: TextStyle(
        fontSize: 16.sp,
      ),
    );
  }

  buttonDesign() {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width / 3,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
              color: buttonColor, borderRadius: BorderRadius.circular(25)),
          child: const Text(
            "Log Out",
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ],
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

  @override
  void initState() {
    FlutterNativeSplash.remove();
    super.initState();
  }
}
