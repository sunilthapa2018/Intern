import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:motivational_leadership/services/database.dart';

class StudentActionProvider extends ChangeNotifier {
  String completedText = '';
  bool isLoading = false;

  Future<void> getData(
      {required String type,
      required String subType,
      bool notify = false}) async {
    isLoading = true;
    if (notify) notifyListeners();
    log("$this type = $type and subType = $subType");
    String text =
        await DatabaseService.getStudentSubTypeReturnData(type, subType);
    String returnText = text;
    completedText = returnText;
    isLoading = false;
    log("subtype returnText = $returnText");
    if (notify) notifyListeners();
  }
}
