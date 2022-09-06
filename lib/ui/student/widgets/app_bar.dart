import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:motivational_leadership/utility/colors.dart';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    toolbarHeight: 36,
    iconTheme: IconThemeData(color: iconColor),
    backgroundColor: Colors.white,
    elevation: 0,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
}
