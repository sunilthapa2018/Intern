import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

copyrightText() {
  final now = DateTime.now().year;
  return Padding(
    padding: const EdgeInsets.only(bottom: 16),
    child: Text(
      "© Copyright $now Motivational Leadership Alliance. All Rights Reserved",
      style: TextStyle(
        fontFamily: "Roboto",
        fontSize: 10.sp,
      ),
    ),
  );
}
