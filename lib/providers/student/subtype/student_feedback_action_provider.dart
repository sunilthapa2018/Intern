import 'package:flutter/material.dart';
import 'package:motivational_leadership/services/database.dart';

class StudentActionProvider extends ChangeNotifier {
  String completedText = '';
  bool isLoading = false;

  Future<void> getData(
      {required String type,
      required String subType,
      bool notify = false}) async {
    if (notify) isLoading = true;
    if (notify) notifyListeners();

    String text =
        await DatabaseService.getStudentSubTypeReturnData(type, subType);
    String returnText = text;
    completedText = returnText;
    if (notify) isLoading = false;
    if (notify) notifyListeners();
  }
}
