import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CoachingPage extends StatelessWidget {
  const CoachingPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => Scaffold(
        body: const Text('Coaching'),
        appBar: AppBar(
          toolbarHeight: 24.h,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
      );
}
