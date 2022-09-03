import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';

void navigateTo(
    {required BuildContext context,
    required Widget nextPage,
    required Widget currentPage}) {
  Navigator.of(context).push(
    PageTransition(
      type: PageTransitionType.rightToLeftJoined,
      childCurrent: currentPage,
      curve: Curves.decelerate,
      duration: const Duration(milliseconds: 200),
      reverseDuration: const Duration(milliseconds: 200),
      child: nextPage,
    ),
  );
}

void setPortraitOnlyOrientation() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

void setLandscapeOnlyOrientation() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
}

void resetOrientation() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
}
