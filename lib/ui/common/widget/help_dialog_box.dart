import 'package:flutter/material.dart';
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
          style: const TextStyle(),
          textAlign: TextAlign.justify,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context, false),
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
              ),
              child: const Text("Close"),
            ),
          ),
        ],
        contentPadding: const EdgeInsets.only(left: 16, right: 16),
        titlePadding: const EdgeInsets.all(16),
        actionsPadding: const EdgeInsets.only(bottom: 12, right: 16),
        insetPadding: EdgeInsets.all(padding),
      );
    },
  );
}
