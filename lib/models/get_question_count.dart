import 'package:cloud_firestore/cloud_firestore.dart';

Future<String> getQuestionCount(String type) async {
  final QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('questions')
      .where('type'.toLowerCase(), isEqualTo: type)
      .get();
  final int documents = snapshot.docs.length;
  return documents.toString();
}
