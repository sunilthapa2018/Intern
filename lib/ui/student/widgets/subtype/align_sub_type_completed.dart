import 'package:flutter/material.dart';
import 'package:motivational_leadership/ui/common/widget/subtype/subtype_decoration_box_4.dart';

Padding alignSubTypeCompleted(
    bool isLoading, String completedText, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10, right: 20),
    child: Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 2, 20, 2),
        decoration: mySubTypeBoxDecoration4(),
        child: Text(
          (isLoading) ? "Loading..." : completedText,
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
    ),
  );
}
