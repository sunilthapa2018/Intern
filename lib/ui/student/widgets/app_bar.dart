import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:motivational_leadership/utility/colors.dart';

AppBar myAppBar(BuildContext context) {
  return AppBar(
    iconTheme: IconThemeData(color: iconColor),
    backgroundColor: appBarColor,
    elevation: 0,
    titleSpacing: 0,
    toolbarHeight: 36,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
    automaticallyImplyLeading: false, // Don't show the leading button
    title: Padding(
      padding: const EdgeInsets.all(0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back, color: iconColor),
          ),
          // Your widgets here
        ],
      ),
    ),
  );
}
