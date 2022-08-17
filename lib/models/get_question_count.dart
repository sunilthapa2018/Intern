import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

Future<String> GetQuestionCount(String type) async {
  final QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('questions').where('type'.toLowerCase(), isEqualTo: type).get();
  final int documents = snapshot.docs.length;
  print('MYTAG : questionCount = $documents');
  return documents.toString();
}

