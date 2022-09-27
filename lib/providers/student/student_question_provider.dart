import 'package:flutter/material.dart';
import 'package:motivational_leadership/providers/student/subtype/student_feedback_action_provider.dart';
import 'package:motivational_leadership/providers/student/subtype/student_feedback_future_provider.dart';
import 'package:motivational_leadership/providers/student/subtype/student_feedback_imp_provider.dart';
import 'package:motivational_leadership/providers/student/subtype/student_feedback_io_provider.dart';
import 'package:motivational_leadership/providers/student/subtype/student_feedback_oc_provider.dart';
import 'package:motivational_leadership/providers/student/subtype/student_feedback_si_provider.dart';
import 'package:provider/provider.dart';

class StudentQuestionProvider extends ChangeNotifier {
  Future? init;

  setInit(BuildContext context, String questionType,
      {bool notify = false}) async {
    init = _loadInitialData(context, questionType, notify);
    if (notify) notifyListeners();
  }

  Future _loadInitialData(
      BuildContext context, String questionType, bool notify) async {
    context
        .read<StudentActionProvider>()
        .getData(type: questionType, notify: notify, subType: "Actions");
    context.read<StudentOCProvider>().getData(
        type: questionType, notify: notify, subType: "Overcoming Challenges");
    context.read<StudentSIProvider>().getData(
        type: questionType,
        notify: notify,
        subType: "Success Indicators (KPIs)");
    context
        .read<StudentImplementationProvider>()
        .getData(type: questionType, notify: notify, subType: "Implementation");
    context.read<StudentIOProvider>().getData(
        type: questionType, notify: notify, subType: "Impact and Outcome");
    context
        .read<StudentFutureProvider>()
        .getData(type: questionType, notify: notify, subType: "Future");
  }
}
