import 'package:flutter/material.dart';

BoxDecoration myTypeBoxDecoration2() {
  return const BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        Color(0xFF5771ec),
        Color(0xFF05bcfe),
      ],
    ),
    borderRadius: BorderRadius.all(Radius.circular(30)),
  );
}
