import 'package:firebase_auth/firebase_auth.dart';

Future<String?> getUserId() async {
  FirebaseAuth auth = FirebaseAuth.instance;
  String? userId = auth.currentUser?.uid.toString();
  return userId;
}
