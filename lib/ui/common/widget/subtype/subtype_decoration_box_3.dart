import 'package:flutter/material.dart';
import 'package:motivational_leadership/utility/colors.dart';

BoxDecoration mySubTypeBoxDecoration3() {
  return BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        tile3Color1,
        tile3Color2,
      ],
    ),
    borderRadius: const BorderRadius.all(Radius.circular(30)),
  );
}
