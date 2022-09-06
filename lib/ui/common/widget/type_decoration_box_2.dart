import 'package:flutter/material.dart';
import 'package:motivational_leadership/utility/colors.dart';

BoxDecoration myTypeBoxDecoration2() {
  return BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        tile2Color1,
        tile2Color2,
      ],
    ),
    borderRadius: const BorderRadius.all(Radius.circular(30)),
  );
}
