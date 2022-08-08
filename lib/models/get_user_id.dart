import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

Future<String?> GetUserId() async{
  FirebaseAuth auth = await FirebaseAuth.instance;
  String? userId = auth.currentUser?.uid.toString();
  return userId;

}
