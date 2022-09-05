import 'package:flutter/material.dart';
import 'package:motivational_leadership/utility/colors.dart';

AppBar appBar(BuildContext context, String title) {
  return AppBar(
    title: Text(title),
    backgroundColor: appBarColor,
  );
}
