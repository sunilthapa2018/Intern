import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:motivational_leadership/utility/colors.dart';

AppBar appBar(BuildContext context, String title) {
  return AppBar(
    title: Text(title),
    titleSpacing: 0,
    toolbarHeight: 36,
    leadingWidth: 48,
    iconTheme: IconThemeData(color: iconColor),
    backgroundColor: Colors.transparent,
    elevation: 0,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
}
