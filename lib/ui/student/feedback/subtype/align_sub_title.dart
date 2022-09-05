import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Align alignSubTitle(String title) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w800,
          fontSize: 24.sp,
        ),
      ),
    ),
  );
}
