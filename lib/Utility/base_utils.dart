import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

void NavigateTo(
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
