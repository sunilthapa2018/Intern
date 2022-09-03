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
    final QuerySnapshot qSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('full name', isEqualTo: fullName)
        .get();
    // final qDocuments = qSnapshot.docs;
    String userId = qSnapshot.docs.first.id;
    return userId;
  }

  static Future<String> getTotalQuestion(
    String questionType,
    String questionSubType,
  ) async {
    final QuerySnapshot qSnapshot = await FirebaseFirestore.instance
        .collection('questions')
        .where('type', isEqualTo: questionType)
        .where('sub type', isEqualTo: questionSubType)
        .get();
    final int qDocuments = qSnapshot.docs.length;
    log("questionType = $questionType and questionSubType = $questionSubType");
    return qDocuments.toString();
  }

  static Future<bool> hasThisDocument(String collectionName, String id) async {
    try {
      final docRef =
          FirebaseFirestore.instance.collection(collectionName).doc(id);
      DocumentSnapshot doc = await docRef.get();
      if (doc.exists) {
        return true;
      } else {
        return false;
      }
    } on FirebaseAuthException catch (e) {
      log("Error(hasThisDocument) $e");
    }
    return false;
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
        }
      });
      return itemsList;
    } catch (e) {
      log(e.toString());
    }
  }

  static Future getFeedbackNotGivenUserList() async {
    List itemsList = [];
    final CollectionReference submissions =
        FirebaseFirestore.instance.collection('submissions');
    try {
      await submissions.get().then((querySnapshot) async {
        bool feedbackGiven = false;

        for (var element in querySnapshot.docs) {
          log(element.id);
          feedbackGiven = await checkIfFeedbackIsGiven(element.id);
          if (!feedbackGiven) {
            itemsList.add(element.id);
          }
        }
      });
      log(itemsList.toString());
      return itemsList;
    } catch (e) {
      log("Error(getFeedbackNotGivenUserList) $e");
    }
  }

  static Future getFeedbackGivenUserList() async {
    List itemsList = [];
    final CollectionReference submissions =
        FirebaseFirestore.instance.collection('submissions');
    try {
      await submissions.get().then((querySnapshot) async {
        bool feedbackGiven = false;

        for (var element in querySnapshot.docs) {
          log(element.id);
          feedbackGiven = await checkIfFeedbackIsGiven(element.id);
          if (feedbackGiven) {
            itemsList.add(element.id);
          }
        }
      });
      log(itemsList.toString());
      return itemsList;
    } catch (e) {
      log("Error(getFeedbackNotGivenUserList) $e");
    }
  }

  static Future<bool> checkIfFeedbackIsGiven(String studentId) async {
    log("studentId = $studentId");
    bool hasDocument = await hasThisDocument("feedback_submissions", studentId);
    if (!hasDocument) {
      return false;
    } else {
      final docRef = FirebaseFirestore.instance
          .collection('feedback_submissions')
          .doc(studentId);
      DocumentSnapshot doc = await docRef.get();
      String action = "false", plan = "false";
      if (doc.exists) {
        action = await doc.get("action");
        plan = await doc.get("plan");
        if (action == 'false' || plan == 'false') {
          return false;
        } else {
          return true;
        }
      } else {
        return false;
      }
    }
  }

  static Future<String> getCoachTypeReturnData(
      String type, String studentId) async {
    final QuerySnapshot aSnapshot = await FirebaseFirestore.instance
        .collection('feedbacks')
        .where('student_id', isEqualTo: studentId)
        .where('type', isEqualTo: type)
        .get();
    final int aDocuments = aSnapshot.docs.length;
    return "$aDocuments/6";
  }

  static Future<String> getCoachSubTypeReturnData(
      String type, String subType, String studentId) async {
    final QuerySnapshot aSnapshot = await FirebaseFirestore.instance
        .collection('feedbacks')
        .where('student_id', isEqualTo: studentId)
        .where('type', isEqualTo: type)
        .where('sub type', isEqualTo: subType)
        .get();
    final int aDocuments = aSnapshot.docs.length;
    String returnText = "";
    if (aDocuments >= 1) {
      returnText = "Feedback Given";
    } else {
      returnText = "NO Feedback Given";
    }
    return returnText;
  }
}
