import 'package:flutter/material.dart';
import 'package:motivational_leadership/services/database.dart';

class CoachActionProvider extends ChangeNotifier {
  String completedText = '';
  bool isLoading = false;

  Future<void> getData(
      {required String studentId,
      required String type,
      required String subType,
      bool notify = false}) async {
    isLoading = true;
    if (notify) notifyListeners();
    String text = await DatabaseService.getCoachSubTypeReturnData(
        type, subType, studentId);
    String returnText = text;
    completedText = returnText;
    isLoading = false;
    if (notify) notifyListeners();
  }
}
