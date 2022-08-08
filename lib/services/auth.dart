
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> getCurrentUID() async{
    return await FirebaseAuth.instance.currentUser!.uid;
  }
}
