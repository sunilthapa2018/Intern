import 'package:flutter/material.dart';

Align alignSubTitle(String title, BuildContext context) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 20, 0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline6,
      ),
    ),
  );
}
