import 'package:flutter/material.dart';
import 'package:motivational_leadership/utility/colors.dart';

BoxDecoration myButtonBox() {
  return BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        buttonColor1,
        buttonColor2,
      ],
    ),
    borderRadius: BorderRadius.circular(30),
  );
}
