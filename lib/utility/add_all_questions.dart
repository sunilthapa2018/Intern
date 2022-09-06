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
        "What actions will you take in your work unit to support the need for autonomy?",
    'number': "1",
    'type': type,
    'sub type': "Actions",
  });
  questions.add({
    'question':
        "What barriers do you anticipate encountering in carrying out these actions?",
    'number': "1",
    'type': type,
    'sub type': "Overcoming Challenges",
  });
  questions.add({
    'question': "How will you overcome them?",
    'number': "2",
    'type': type,
    'sub type': "Overcoming Challenges",
  });
  questions.add({
    'question': "How will you determine success?",
    'number': "1",
    'type': type,
    'sub type': "Success Indicators (KPIs)",
  });
  questions.add({
    'question':
        "What actions will you take in your work unit to support the need for autonomy?",
    'number': "2",
    'type': type,
    'sub type': "Success Indicators (KPIs)",
  });
  questions.add({
    'question': "Discuss how this action plan was implemented.",
    'number': "1",
    'type': type,
    'sub type': "Implementation",
  });
  questions.add({
    'question': "Discuss the real event and what happened.",
    'number': "2",
    'type': type,
    'sub type': "Implementation",
  });
  questions.add({
    'question':
        "Reflect on what happened with this action, and how it relates to?",
    'number': "1",
    'type': type,
    'sub type': "Impact and Outcome",
  });
  questions.add({
    'question': "what should have happened in regard to the SDT theory.",
    'number': "2",
    'type': type,
    'sub type': "Impact and Outcome",
  });
  questions.add({
    'question':
        "What would you recommend improving or changing for the next time you do this action?",
    'number': "1",
    'type': type,
    'sub type': "Future",
  });
  log("*********************All questions added to database********************");
  return;
}
