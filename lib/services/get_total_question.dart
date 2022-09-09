import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetUserName extends StatelessWidget {
  final String documentId;
  const GetUserName({super.key, required this.documentId});

  Future<int> getQuestionCount(String type) async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('questions')
        .where('type'.toLowerCase(), isEqualTo: type.toLowerCase())
        .get();
    final int documents = snapshot.docs.length;

    if (documents > 0) {
      return documents;
    } else {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference questions =
        FirebaseFirestore.instance.collection('questions');

    return FutureBuilder<DocumentSnapshot>(
      future: questions.doc().get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Text("Full Name: ${data['full_name']} ${data['last_name']}");
        }

        return const Text("loading");
      },
    );
  }

  Future<int> countDocuments() async {
    QuerySnapshot myDoc = await FirebaseFirestore.instance
        .collection('questions')
        .where('type'.toLowerCase(), isEqualTo: "autonomy")
        .get();
    List<DocumentSnapshot> myDocCount = myDoc.docs;

    return myDocCount.length;
// Count of Documents in Collection
  }
}
