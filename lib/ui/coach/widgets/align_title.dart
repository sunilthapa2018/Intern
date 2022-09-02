import 'package:flutter/material.dart';

Align alignTitle(String title) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Padding(
      padding: const EdgeInsets.fromLTRB(30, 20, 0, 20),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w800,
          fontSize: 24,
          letterSpacing: 2,
        ),
      ),
    ),
  );
}
