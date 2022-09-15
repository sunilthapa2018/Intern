import 'package:flutter/material.dart';
import 'package:motivational_leadership/ui/common/widget/subtype/subtype_decoration_box_4.dart';

Padding alignSubTypeCompleted(
    bool isLoading, String completedText, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 5, right: 16, top: 2),
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
