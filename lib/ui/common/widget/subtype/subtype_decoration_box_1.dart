import 'package:flutter/material.dart';
import 'package:motivational_leadership/utility/colors.dart';

BoxDecoration mySubTypeBoxDecoration1() {
  return BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        tile1Color1,
        tile1Color2,
      ],
    ),
    borderRadius: const BorderRadius.all(Radius.circular(15)),
  );
}
