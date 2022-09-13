import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:motivational_leadership/models/notificatin_request.dart';
import 'package:motivational_leadership/utility/custom_exception.dart';
import 'package:motivational_leadership/utility/utils.dart';

class PushNotificationService {
  FirebaseMessaging fm = FirebaseMessaging.instance;
  final Dio _dio = Dio();

  Future<String?> sendPushMessage(
      {required NotificationRequest request}) async {
    String? token = await fm.getToken();
    if (token == null) {
      log('Unable to send FCM message, no token exists.');
      return null;
    }

    try {
      await _dio.post(
        "https://fcm.googleapis.com/fcm/send",
        data: request.toJson(),
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization":
                "key=AAAAhfYLfIc:APA91bFcjAkTgxz3MXxVKlvYGMPzwD6SxOIX0qUYoMe1dPUg2VtonQUo4YfbymFs5A_ek2K1Cv62PKtqPKlAoZWT9Wpid_9njFa3DQzCvHF9WprjsxQz_kLJD0RkQu0G5qgDGslMiux3"
          },
        ),
      );
      return "Success";
    } on DioError catch (e) {
      Utils.showSnackBar(DioExceptions.fromDioError(e).message);
      rethrow;
    }
  }
}
