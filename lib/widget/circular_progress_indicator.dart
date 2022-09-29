import 'package:flutter/material.dart';
import 'package:motivational_leadership/utility/colors.dart';

Container myCircularProgressIndicator(BuildContext context) {
  return Container(
    color: backgroundColor,
    height: double.infinity,
    child: const Center(
      child: CircularProgressIndicator(),
    ),
  );
}
