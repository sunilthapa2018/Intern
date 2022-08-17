import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:motivational_leadership/Utility/utils.dart';
import 'package:motivational_leadership/screen/admin_home.dart';
import 'package:motivational_leadership/screen/coach_home.dart';
import 'package:motivational_leadership/screen/signin.dart';
import 'Student/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
String userType = "student";
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.black45,
  ));
  runApp(const MyApp());
}
final navigatorKey = GlobalKey<NavigatorState>();


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Coaching app';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: Utils.messengerKey,
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: _title,
      theme: ThemeData.light(),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          getUserType();
          print('MYTAG : From main.dart UserType = $userType');
          if(userType=='admin'){
            return AdminHome();
          }else if(userType=='coach'){
            return CoachHome();
          }else{
            return StudentHome();
          }
          // return Scaffold(
          //   appBar: AppBar(
          //     //toolbarHeight: 20,
          //     title: Text("GGGG"),
          //     // backgroundColor: Colors.transparent,
          //     // elevation: 0.0,
          //     systemOverlayStyle: SystemUiOverlayStyle.dark,
          //   ),
          //   //body: screens[_selectedIndex],
          //   // bottomNavigationBar: const BottomNavBar(),
          // );
        }else{
          return SignIn();
        }

      }
    );
  }
  void getUserType() {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        try{
          userType = documentSnapshot.get("type");
        }on FirebaseAuthException catch (e) {
          userType = "student";
          print("mytag " + e.toString());
          Utils.showSnackBar("Usertype not found : $e.message");
        }

      } else {
        print('Document does not exist on the database');
      }
    });
  }
}