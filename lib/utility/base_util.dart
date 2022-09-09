import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Utils {
  static GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();
  static showSnackBar(String? text) {
    if (text == null) return;
    final snackBar = SnackBar(content: Text(text));
    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
    FocusManager.instance.primaryFocus?.unfocus();
  }
}

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
