import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> addAllQuestionsToDatabase() async {
  addCat("Autonomy");
  addCat("Belonging");
  addCat("Competence");
}

void addCat(String type) {
  CollectionReference questions =
      FirebaseFirestore.instance.collection('questions');

  questions.add({
    'question':
        "What actions will you take to satisfy the need for $type? \n(List three actions)",
    'number': "1",
    'type': type,
    'sub type': "Actions",
  });
  questions.add({
    'question':
        "What challenges do you expect in carrying out each of these actions?",
    'number': "1",
    'type': type,
    'sub type': "Overcoming Challenges",
  });
  questions.add({
    'question': "How will you overcome these challenges?",
    'number': "2",
    'type': type,
    'sub type': "Overcoming Challenges",
  });
  questions.add({
    'question': "How will you determine the success of each action?",
    'number': "1",
    'type': type,
    'sub type': "Success Indicators (KPIs)",
  });
  questions.add({
    'question': "If KPIs apply, what are these KPIs?",
    'number': "2",
    'type': type,
    'sub type': "Success Indicators (KPIs)",
  });
  questions.add({
    'question': "Briefly describe how each of these actions were implemented.",
    'number': "1",
    'type': type,
    'sub type': "Implementation",
  });
  questions.add({
    'question': "Briefly describe the impact of each action?",
    'number': "1",
    'type': type,
    'sub type': "Impact and Outcome",
  });
  questions.add({
    'question':
        "What would you improve or change next time you do these actions?",
    'number': "1",
    'type': type,
    'sub type': "Future",
  });
  log("*********************All questions added to database********************");
  return;
}
