import 'package:flutter/material.dart';
import 'package:motivational_leadership/services/database.dart';

class CoachAutonomyProvider extends ChangeNotifier {
  String completedText = '';
  bool isLoading = false;

  Future<void> getData(
      {required String studentId,
      required String type,
      bool notify = false}) async {
    isLoading = true;
    if (notify) notifyListeners();
    String text = await DatabaseService.getCoachTypeReturnData(type, studentId);
    String returnText = "Completed : $text";
    completedText = returnText;
    isLoading = false;

    if (notify) notifyListeners();
  }
}
