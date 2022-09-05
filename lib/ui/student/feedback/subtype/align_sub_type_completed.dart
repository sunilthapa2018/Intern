import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Align alignSubTypeCompleted(bool isLoading, String completedText) {
  return Align(
    alignment: Alignment.centerRight,
    child: Padding(
      padding: const EdgeInsets.fromLTRB(0, 5, 20, 10),
      child: Text(
        (isLoading) ? "Loading..." : completedText,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.sp,
        ),
      ),
    ),
  );
}
