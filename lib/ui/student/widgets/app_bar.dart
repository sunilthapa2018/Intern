import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:motivational_leadership/utility/colors.dart';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    leadingWidth: 48, // <-- Use this
    // leading: const Icon(Icons.arrow_back),
    titleSpacing: 0,
    toolbarHeight: 36,
    iconTheme: IconThemeData(color: iconColor),
    backgroundColor: appBarColor,
    elevation: 0,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
}
