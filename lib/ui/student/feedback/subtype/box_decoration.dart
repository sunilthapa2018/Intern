import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motivational_leadership/utility/colors.dart';

BoxDecoration boxSubDecoration() {
  return BoxDecoration(
      color: itemColor,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(5.0.r),
        topRight: Radius.circular(20.0.r),
        bottomLeft: Radius.circular(20.0.r),
        bottomRight: Radius.circular(5.0.r),
      ));
}
