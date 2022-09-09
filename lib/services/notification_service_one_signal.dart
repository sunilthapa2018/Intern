import 'dart:developer';

import 'package:dio/dio.dart';

Future<void> sendToAllNotification(
    {required String heading, required String content}) async {
  try {
    final response = await Dio().post(
      'https://onesignal.com/api/v1/notifications',
      options: Options(
        headers: {
          "Authorization":
              "Basic MTM1MzU3N2ItNDk0YS00NDlkLThiZmUtNzg2YzI3ODAwZWU5",
          'Content-Type': 'application/json; charset=UTF-8',
        },
      ),
      data: {
        "included_segments": ["Subscribed Users"],
        "app_id": "1e5cbd40-2209-499d-8216-b63c951596ef",
        "headings": {"en": heading},
        "contents": {"en": content},
        "token": {},
      },
    );
    log(response.data);
  } catch (e) {
    log("ERRROR:$e");
  }
}
