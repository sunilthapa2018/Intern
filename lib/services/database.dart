import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Utility/utils.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future updateUserData(String fullName, String phone, String type) async {
    return await userCollection.doc(uid).set({
      'full name': fullName,
      'phone': phone,
    });
  }

  // List<String> docIDs = [];
  // Future getUserId(String uid) async{
  //   await FirebaseFirestore.instance.collection('users').get().then(
  //           (snapshot) => snapshot.docs.forEach((document) {
  //             docIDs.add(document.reference.id);
  //       })
  //   );
  // }

  // Future getUserType(String uid) async{
  //   await FirebaseFirestore.instance.collection('users').get().then(
  //       (snapshot) => snapshot.docs.forEach((element) {
  //         log(element.reference);
  //       })
  //   );
  // }

  static Future<String> getUserName(String uid) async {
    final docRef = FirebaseFirestore.instance.collection('users').doc(uid);
    DocumentSnapshot doc = await docRef.get();
    if (doc.exists) {
      String name = await doc.get("full name");
      log('MYTAG getUserName NAME = $name');
      return name;
    } else {
      return "";
    }
  }

  static Future<String> getUserType(String uid) async {
    final docRef = FirebaseFirestore.instance.collection('users').doc(uid);
    DocumentSnapshot doc = await docRef.get();
    if (doc.exists) {
      String type = await doc.get("type");
      log('MYTAG getUserName NAME = $type');
      return type;
    } else {
      return "loading";
    }
  }

  static Future<String> getUserId(String fullName) async {
    // final docRef = await FirebaseFirestore.instance.collection('users').doc(uid);
    // DocumentSnapshot doc = await docRef.get();
    // if(doc.exists){
    //   String name = await doc.get("full name");
    //   log('MYTAG getUserName NAME = $name');
    //   return name;
    // }else{
    //   return "";
    // }

    final QuerySnapshot qSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('full name', isEqualTo: fullName)
        .get();
    // final qDocuments = qSnapshot.docs;
    String userId = qSnapshot.docs.first.id;
    return userId;
  }

  Future<String> getTotalQuestion(
    String questionType,
    String questionSubType,
  ) async {
    final QuerySnapshot qSnapshot = await FirebaseFirestore.instance
        .collection('questions')
        .where('type', isEqualTo: questionType)
        .where('sub type', isEqualTo: questionSubType)
        .get();
    final int qDocuments = qSnapshot.docs.length;
    return qDocuments.toString();
  }

  static Future<String> hasThisDocument(
      String collectionName, String id) async {
    final docRef =
        FirebaseFirestore.instance.collection(collectionName).doc(id);
    DocumentSnapshot doc = await docRef.get();
    if (doc.exists) {
      return "true";
    } else {
      return "false";
    }
  }

  static Future<void> updateSubmissions(String type, String value) async {
    CollectionReference submissions =
        FirebaseFirestore.instance.collection('submissions');
    String uid = FirebaseAuth.instance.currentUser!.uid;
    try {
      submissions.doc(uid).update({type: value});
    } on FirebaseAuthException catch (e) {
      log("mytag $e");
      Utils.showSnackBar("Failed to update submissions: $e.message");
    }
  }

  static Future<void> addSubmissions(String plan, String reflect) async {
    final CollectionReference submissionsCollection =
        FirebaseFirestore.instance.collection('submissions');
    String uid = FirebaseAuth.instance.currentUser!.uid;

    try {
      await submissionsCollection.doc(uid).set({
        'plan': plan,
        'reflect': reflect,
      });
    } on FirebaseAuthException catch (e) {
      log("mytag $e");
      Utils.showSnackBar("Failed to add submissions: $e.message");
    }
  }

  static Future getUserList() async {
    List itemsList = [];
    final CollectionReference submissions =
        FirebaseFirestore.instance.collection('submissions');
    try {
      await submissions.get().then((querySnapshot) {
        for (var element in querySnapshot.docs) {
          itemsList.add(element.id);
          // itemsList.add(element.data());
          log("MYTAG getUserList: ${element.id}");
        }
      });
      log(itemsList.toString());
      return itemsList;
    } catch (e) {
      log(e.toString());
    }
  }
}