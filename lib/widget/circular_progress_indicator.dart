import 'package:flutter/material.dart';
import 'package:motivational_leadership/utility/colors.dart';

Container myCircularProgressIndicator(BuildContext context) {
  return Container(
    color: backgroundColor,
    height: MediaQuery.of(context).size.height,
    child: const Center(
      child: CircularProgressIndicator(),
    ),
  );
}
