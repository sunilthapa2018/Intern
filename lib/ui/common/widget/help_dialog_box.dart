import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:motivational_leadership/utility/colors.dart';

Future<bool?> loadInfo(BuildContext context, String text) async {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      double padding = (5 / 100) * MediaQuery.of(context).size.width;
      return AlertDialog(
        title: Row(
          children: [
            IconButton(
              visualDensity:
                  const VisualDensity(horizontal: -4.0, vertical: -4.0),
              padding: EdgeInsets.zero,
              icon: Icon(
                FontAwesomeIcons.solidCircleQuestion,
                color: iconColor,
              ),
              onPressed: null,
            ),
            Text(
              "Help",
              style: TextStyle(
                color: iconColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: Text(
          text,
          style: TextStyle(fontFamily: "Roboto", fontSize: 14.sp),
          textAlign: TextAlign.justify,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(top: 20.sp),
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context, false),
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
              ),
              child: Padding(
                padding: EdgeInsets.all(8.0.sp),
                child: Text(
                  "Close",
                  style: TextStyle(fontSize: 14.sp),
                ),
              ),
            ),
          ),
        ],
        contentPadding: EdgeInsets.only(left: 16.sp, right: 16.sp),
        titlePadding: EdgeInsets.all(16.sp),
        actionsPadding: EdgeInsets.only(bottom: 12.sp, right: 16.sp),
        insetPadding: EdgeInsets.all(padding),
      );
    },
  );
}
