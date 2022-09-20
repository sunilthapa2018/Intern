import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Text copyrightText() {
  final now = DateTime.now().year;
  return Text(
    "© Copyright $now Motivational Leadership Alliance. All Rights Reserved",
    style: TextStyle(
      fontFamily: "Roboto",
      fontSize: 10.sp,
    ),
  );
}
