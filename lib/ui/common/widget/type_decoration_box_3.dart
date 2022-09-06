import 'package:flutter/material.dart';

BoxDecoration myTypeBoxDecoration3() {
  return const BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        Color(0xFFa28dd2),
        Color(0xFFfac1ea),
      ],
    ),
    borderRadius: BorderRadius.all(Radius.circular(30)),
  );
}
