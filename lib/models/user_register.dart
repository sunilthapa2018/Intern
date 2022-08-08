
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> userRegister(String fullName, String phone) async{
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  FirebaseAuth auth = await FirebaseAuth.instance;
  String? uid = auth.currentUser?.uid.toString();

  users.add({
    'uid': uid,
    'fullName': fullName,
    'phone': phone,
  });
  return;
}