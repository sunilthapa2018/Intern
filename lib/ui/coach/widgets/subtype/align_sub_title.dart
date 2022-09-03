import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Align alignSubTitle(String title) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Padding(
      padding: const EdgeInsets.fromLTRB(30, 10, 0, 0),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w800,
          fontSize: 26.sp,
        ),
      ),
    ),
  );
}
