import 'package:flutter/material.dart';

BoxDecoration myTypeBoxDecoration1() {
  return const BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        Color(0xFFed6f9e),
        Color(0xFFF2811D),
      ],
    ),
    borderRadius: BorderRadius.all(Radius.circular(30)),
  );
}
