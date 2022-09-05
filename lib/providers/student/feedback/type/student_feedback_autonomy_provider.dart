import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:motivational_leadership/services/database.dart';

class StudentFeedbackAutonomyProvider extends ChangeNotifier {
  String completedText = '';
  bool isLoading = false;

  Future<void> getData({required String type, bool notify = false}) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    isLoading = true;
    if (notify) notifyListeners();
    String aDocuments =
        await DatabaseService.getTotalFeedbackGivenByType(uid, "Autonomy");
    completedText = "Feedback Received : $aDocuments/6";
    isLoading = false;
    if (notify) notifyListeners();
  }
}
