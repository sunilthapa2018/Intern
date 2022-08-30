import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> getCurrentUID() async {
    return FirebaseAuth.instance.currentUser!.uid;
  }
}
