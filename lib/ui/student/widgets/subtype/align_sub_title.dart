import 'package:flutter/material.dart';

Align alignSubTitle(String title, BuildContext context) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Padding(
      padding: const EdgeInsets.fromLTRB(24, 10, 20, 5),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline6,
      ),
    ),
  );
}
