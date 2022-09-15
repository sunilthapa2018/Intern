import 'package:flutter/material.dart';
import 'package:motivational_leadership/utility/colors.dart';

BoxDecoration mySubTypeBoxDecoration3() {
  return BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        newTile3,
        newTile3,
      ],
    ),
    borderRadius: const BorderRadius.all(Radius.circular(5)),
  );
}
