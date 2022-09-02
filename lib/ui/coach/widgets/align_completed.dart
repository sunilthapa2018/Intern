import 'package:flutter/material.dart';

Align alignCompleted(bool isLoading, String completedText) {
  return Align(
    alignment: Alignment.centerRight,
    child: Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 20, 20),
      child: Text(
        (isLoading) ? "Loading..." : completedText,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
    ),
  );
}
