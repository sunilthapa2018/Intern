import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:motivational_leadership/services/database.dart';

class StudentFeedbackOCProvider extends ChangeNotifier {
  String completedText = '';
  bool isLoading = false;
  Future<void> getData(
      {required String type,
      required String subType,
      bool notify = false}) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    isLoading = true;
    if (notify) notifyListeners();
    String text = await DatabaseService.getTotalFeedbackGivenBySubtype(
        uid, type, subType);
    completedText = text;
    isLoading = false;
    log("subtype completedText = $completedText");
    if (notify) notifyListeners();
  }
}
