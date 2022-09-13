import 'package:flutter/material.dart';
import 'package:motivational_leadership/utility/colors.dart';

BoxDecoration myTypeBoxDecoration1() {
  return BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        newTile1,
        newTile1,
      ],
    ),
    borderRadius: const BorderRadius.all(Radius.circular(30)),
  );
}
