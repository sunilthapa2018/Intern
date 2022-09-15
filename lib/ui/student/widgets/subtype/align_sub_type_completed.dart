import 'package:flutter/material.dart';

Padding alignSubTypeCompleted(
    bool isLoading, String completedText, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10, right: 16, top: 5),
    child: Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.all(0),
        //decoration: mySubTypeBoxDecoration4(),
        child: Text(
          (isLoading) ? "Loading..." : completedText,
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
    ),
  );
}
