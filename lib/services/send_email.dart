import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class EmailServices {
  static Future sendContactUs({
    required String name,
    required String email,
    required String subject,
    required String message,
  }) async {
    const serviceId = 'service_59d4v8f';
    const templateId = 'template_z0ue6wm';
    const userId = 'CrjHePXl2K9LKa2sY';
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final response = await http.post(
      url,
      headers: {
        'origin': 'http://localhost',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': userId,
        'template_params': {
          'user_name': name,
          'user_email': email,
          'user_subject': subject,
          'user_message': message,
        },
      }),
    );
    log("name = $name, email = $email, subject = $subject, message = $message");
    log(response.body);
  }

  static Future sendNewUserRegistrationEmail({
    required String name,
    required String email,
    required String password,
  }) async {
    const serviceId = 'service_59d4v8f';
    const templateId = 'template_yc8k3y9';
    const userId = 'CrjHePXl2K9LKa2sY';
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final response = await http.post(
      url,
      headers: {
        'origin': 'http://localhost',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': userId,
        'template_params': {
          'user_name': name,
          'user_email': email,
          'user_password': password,
        },
      }),
    );
    log("name = $name, email = $email, subject = $password");
    log(response.body);
  }

  static Future sendUserNotificationEmail({
    required String name,
    required String email,
    required String type,
    required String module,
  }) async {
    const serviceId = 'service_59d4v8f';
    const templateId = 'template_wt2dc4f';
    const userId = 'CrjHePXl2K9LKa2sY';
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final response = await http.post(
      url,
      headers: {
        'origin': 'http://localhost',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': userId,
        'template_params': {
          'user_name': name,
          'user_email': email,
          'type': type,
          'module': module,
        },
      }),
    );
    log(response.body);
  }
}
