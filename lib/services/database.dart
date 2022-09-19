import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Utility/utils.dart';

class DatabaseService {
  DatabaseService();

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  static Future updateUserData(String userId, String fullName, String phone,
      String userType, String email) async {
    try {
      final CollectionReference userCollection =
          FirebaseFirestore.instance.collection('users');
      await userCollection.doc(userId).set({
        'full name': fullName,
        'phone': phone,
        'type': userType,
        'email': email,
      });
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar("Failed Error Message: $e.message");
    }
  }

  static Future<String> getUserName(String uid) async {
    try {
      final docRef = FirebaseFirestore.instance.collection('users').doc(uid);
      DocumentSnapshot doc = await docRef.get();
      if (doc.exists) {
        String name = await doc.get("full name");
        return name;
      } else {
        return "";
      }
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar("Failed Error Message: $e.message");
    }
    return "";
  }

  static Future<String> getUserEmail(String uid) async {
    try {
      final docRef = FirebaseFirestore.instance.collection('users').doc(uid);
      DocumentSnapshot doc = await docRef.get();
      if (doc.exists) {
        String email = await doc.get("email");
        return email;
      } else {
        return "";
      }
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar("Failed Error Message: $e.message");
    }
    return "";
  }

  static Future<String> getQuestion(String questionId) async {
    try {
      final docRef =
          FirebaseFirestore.instance.collection('questions').doc(questionId);
      DocumentSnapshot doc = await docRef.get();
      if (doc.exists) {
        String question = await doc.get("question");
        String type = await doc.get("type");
        String subType = await doc.get("sub type");
        String val = "$question*$type*$subType";
        return val;
      }
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar("Failed Error Message: $e.message");
    }
    return "";
  }

  static Future<String> getUserToken(String uid) async {
    try {
      final docRef = FirebaseFirestore.instance.collection('users').doc(uid);
      DocumentSnapshot doc = await docRef.get();
      if (doc.exists) {
        String token = await doc.get("token");
        return token;
      }
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar("Failed Error Message: $e.message");
    }
    return "";
  }

  static Future<String> getUserType(String uid) async {
    try {
      final docRef = FirebaseFirestore.instance.collection('users').doc(uid);
      DocumentSnapshot doc = await docRef.get();
      if (doc.exists) {
        String type = await doc.get("type");
        return type;
      } else {
        return "loading";
      }
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar("Failed Error Message: $e.message");
    }
    return "loading";
  }

  static Future<String> getUserId(String fullName) async {
    try {
      final QuerySnapshot qSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('full name', isEqualTo: fullName)
          .get();
      String userId = qSnapshot.docs.first.id;
      return userId;
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar("Failed Error Message: $e.message");
    }
    return "userId Error";
  }

  static Future<String> getTotalQuestion(
    String questionType,
    String questionSubType,
  ) async {
    try {
      final QuerySnapshot qSnapshot = await FirebaseFirestore.instance
          .collection('questions')
          .where('type', isEqualTo: questionType)
          .where('sub type', isEqualTo: questionSubType)
          .get();
      final int qDocuments = qSnapshot.docs.length;
      return qDocuments.toString();
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar("Failed Error Message: $e.message");
    }
    return "0";
  }

  static Future<String> getTotalFeedbackGivenByType(
    String studentId,
    String questionType,
  ) async {
    try {
      final QuerySnapshot qSnapshot = await FirebaseFirestore.instance
          .collection('feedbacks')
          .where('student_id', isEqualTo: studentId)
          .where('type', isEqualTo: questionType)
          .get();
      final int qDocuments = qSnapshot.docs.length;
      return qDocuments.toString();
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar("Failed Error Message: $e.message");
    }
    return "0";
  }

  static Future<String> getTotalFeedbackGivenBySubtype(
    String studentId,
    String questionType,
    String questionSubType,
  ) async {
    try {
      final QuerySnapshot qSnapshot = await FirebaseFirestore.instance
          .collection('feedbacks')
          .where('student_id', isEqualTo: studentId)
          .where('type', isEqualTo: questionType)
          .where('sub type', isEqualTo: questionSubType)
          .get();
      final int qDocuments = qSnapshot.docs.length;
      if (qDocuments > 0) {
        return "Feedback Given";
      } else {
        return "Feedback Not Given Yet";
      }
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar("Failed Error Message: $e.message");
    }
    return "Feedback Not Given Yet";
  }

  static Future<String> getFeedbackGiven(
    String studentId,
    String questionType,
    String questionSubType,
  ) async {
    try {
      final QuerySnapshot qSnapshot = await FirebaseFirestore.instance
          .collection('feedbacks')
          .where('student_id', isEqualTo: studentId)
          .where('type', isEqualTo: questionType)
          .where('sub type', isEqualTo: questionSubType)
          .get();
      for (var doc in qSnapshot.docs) {
        if (qSnapshot.docs.isNotEmpty) {
          String feedback = doc.get('feedback');
          return feedback;
        } else {
          return "Coach has not Given feedback yet";
        }
      }
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar("Failed Error Message: $e.message");
    }
    return "Coach has not Given feedback yet";
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
      Utils.showSnackBar("Failed Error Message: $e.message");
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
      Utils.showSnackBar("Failed Error Message: $e.message");
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
      Utils.showSnackBar("Failed Error Message: $e.message");
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
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar("Failed Error Message: $e.message");
    }
  }

  static Future getAllQuestionList() async {
    List itemsList = [];
    final CollectionReference questions =
        FirebaseFirestore.instance.collection('questions');
    try {
      await questions.orderBy("type").get().then((querySnapshot) async {
        for (var element in querySnapshot.docs) {
          itemsList.add(element.id);
        }
      });
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar("Failed Error Message: $e.message");
    }
    return itemsList;
  }

  static Future getQuestionListByType(String type) async {
    List itemsList = [];
    final CollectionReference questions =
        FirebaseFirestore.instance.collection('questions');
    try {
      await questions
          .where('type', isEqualTo: type)
          .get()
          .then((querySnapshot) async {
        for (var element in querySnapshot.docs) {
          itemsList.add(element.id);
        }
      });
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar("Failed Error Message: $e.message");
    }
    return itemsList;
  }

  static Future getFeedbackGivenUserList() async {
    List itemsList = [];
    final CollectionReference submissions =
        FirebaseFirestore.instance.collection('submissions');
    try {
      await submissions.get().then((querySnapshot) async {
        bool feedbackGiven = false;

        for (var element in querySnapshot.docs) {
          feedbackGiven = await checkIfFeedbackIsGiven(element.id);
          if (feedbackGiven) {
            itemsList.add(element.id);
          }
        }
      });
      return itemsList;
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar("Failed Error Message: $e.message");
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
          feedbackGiven = await checkIfFeedbackIsGiven(element.id);
          if (!feedbackGiven) {
            itemsList.add(element.id);
          }
        }
      });

      return itemsList;
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar("Failed Error Message: $e.message");
    }
  }

  static Future searchStudentList(String searchText) async {
    List itemsList = [];
    final CollectionReference users =
        FirebaseFirestore.instance.collection('users');
    try {
      await users
          .where("full name", isGreaterThanOrEqualTo: searchText)
          .where("full name", isLessThanOrEqualTo: "$searchText\uf7ff")
          .get()
          .then((querySnapshot) async {
        for (var element in querySnapshot.docs) {
          itemsList.add(element.id);
        }
      });
      return itemsList;
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar("Failed Error Message: $e.message");
    }
  }

  static Future<bool> checkIfFeedbackIsGiven(String studentId) async {
    try {
      bool hasDocument =
          await hasThisDocument("feedback_submissions", studentId);
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
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar("Failed Error Message: $e.message");
    }
    return false;
  }

  static Future<String> getCoachTypeReturnData(
      String type, String studentId) async {
    try {
      final QuerySnapshot aSnapshot = await FirebaseFirestore.instance
          .collection('feedbacks')
          .where('student_id', isEqualTo: studentId)
          .where('type', isEqualTo: type)
          .get();
      final int aDocuments = aSnapshot.docs.length;

      return "$aDocuments/6";
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar("Failed Error Message: $e.message");
      return "Error/6";
    }
  }

  static Future<String> getCoachSubTypeReturnData(
      String type, String subType, String studentId) async {
    String returnText = "";
    try {
      final QuerySnapshot aSnapshot = await FirebaseFirestore.instance
          .collection('feedbacks')
          .where('student_id', isEqualTo: studentId)
          .where('type', isEqualTo: type)
          .where('sub type', isEqualTo: subType)
          .get();
      final int aDocuments = aSnapshot.docs.length;

      if (aDocuments >= 1) {
        returnText = "Feedback Given";
      } else {
        returnText = "NO Feedback Given";
      }
      return returnText;
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar("Failed Error Message: $e.message");
      return returnText;
    }
  }

  static Future<String> getStudentSubTypeReturnData(
      String type, String subType) async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      final QuerySnapshot qSnapshot = await FirebaseFirestore.instance
          .collection('questions')
          .where('type', isEqualTo: type)
          .where('sub type', isEqualTo: subType)
          .get();
      final int qDocuments = qSnapshot.docs.length;

      final QuerySnapshot aSnapshot = await FirebaseFirestore.instance
          .collection('answers')
          .where('uid', isEqualTo: uid)
          .where('type', isEqualTo: type)
          .where('sub type', isEqualTo: subType)
          .get();
      final int aDocuments = aSnapshot.docs.length;
      String returnText = "Completed : $aDocuments/$qDocuments";
      return returnText;
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar("Failed Error Message: $e.message");
      return "Failed Error Message: $e.message";
    }
  }

  static Future addQuestionToDatabase(
      String question, String type, String subType) async {
    try {
      final CollectionReference questionCollection =
          FirebaseFirestore.instance.collection('questions');
      int questionNumber = 0;
      int max = 0;
      await FirebaseFirestore.instance
          .collection('questions')
          .where('type', isEqualTo: type)
          .where('sub type', isEqualTo: subType)
          .get()
          .then((QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          int qNo = int.parse(doc["number"]);
          if (max < qNo) max = qNo;
        }
      });

      questionNumber = max + 1;
      log("questionNumber = $questionNumber");
      await questionCollection.doc().set({
        'number': questionNumber.toString(),
        'question': question,
        'type': type,
        'sub type': subType,
      });
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar("Failed Error Message: $e.message");
    }
  }

  static Future updateQuestion(
      String questionId, String question, String type, String subType) async {
    try {
      final CollectionReference questionCollection =
          FirebaseFirestore.instance.collection('questions');
      await questionCollection.doc(questionId).update({
        'question': question,
        'type': type,
        'sub type': subType,
      });
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar("Failed Error Message: $e.message");
    }
  }

  static Future<String> getTotalDataInThisDocument(
    String documentName,
    String field,
    String fieldData,
  ) async {
    int totalDocuments = 0;
    if (field != "") {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(documentName)
          .where(field, isEqualTo: fieldData)
          .get();
      totalDocuments = querySnapshot.docs.length;
    } else {
      final QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection(documentName).get();
      totalDocuments = querySnapshot.docs.length;
    }
    log("totalDocuments = $totalDocuments");
    return totalDocuments.toString();
  }

  static Future<void> deleteQuestion(
    String documentId,
  ) async {
    FirebaseFirestore.instance
        .collection("questions")
        .doc(documentId)
        .delete()
        .then(
          (doc) => log("Document deleted"),
          onError: (e) => log("Error updating document $e"),
        );
  }
}
