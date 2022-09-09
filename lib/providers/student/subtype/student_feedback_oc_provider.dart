import 'package:flutter/material.dart';
import 'package:motivational_leadership/services/database.dart';

class StudentOCProvider extends ChangeNotifier {
  String completedText = '';
  bool isLoading = false;

  Future<void> getData(
      {required String type,
      required String subType,
      bool notify = false}) async {
    isLoading = true;
    if (notify) notifyListeners();
    String text =
        await DatabaseService.getStudentSubTypeReturnData(type, subType);
    String returnText = text;
    completedText = returnText;
    isLoading = false;

    if (notify) notifyListeners();
  }
}
