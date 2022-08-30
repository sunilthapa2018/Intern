import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetUserName extends StatelessWidget {
  final String documentId;
  const GetUserName({required this.documentId});

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          String fullName = data['full name'];
          var splitted = fullName.split(' ');
          String firstName = splitted[0].trim();
          return Text(
            firstName,
            style: const TextStyle(
              color: Color(0xFFff6600),
              fontWeight: FontWeight.w900,
              fontSize: 36,
            ),
          );
        }
        //return Text('Anonymous');
        return const Text(
          'User',
          style: TextStyle(
            color: Color(0xFFff6600),
            fontWeight: FontWeight.w900,
            fontSize: 36,
          ),
        );
      }),
    );
  }
}