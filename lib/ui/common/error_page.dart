import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

  Container myBody() {
    return Container(
      padding: EdgeInsets.all(16.sp),
      color: backgroundColor,
      child: Center(
        child: SelectableText(
          "Your Authentication has been REVOKED, please contact admin\n\nnicholai@leadershipdevelopment.training",
          style: TextStyle(
            fontSize: 16.sp,
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    FlutterNativeSplash.remove();
    super.initState();
  }
}
