import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StudentFirebaseService {
  Future<String> getData(String type) async {
    final QuerySnapshot qSnapshot = await FirebaseFirestore.instance
        .collection('questions')
        .where('type', isEqualTo: type)
        .get();
    final int qDocuments = qSnapshot.docs.length;

    String uid = FirebaseAuth.instance.currentUser!.uid;
    final QuerySnapshot aSnapshot = await FirebaseFirestore.instance
        .collection('answers')
        .where('uid', isEqualTo: uid)
        .where('type', isEqualTo: type)
        .get();
    final int aDocuments = aSnapshot.docs.length;
    String returnText = "Completed : $aDocuments/$qDocuments";
    return returnText;
  }
}
