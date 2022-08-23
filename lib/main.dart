import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:motivational_leadership/Utility/utils.dart';
import 'package:motivational_leadership/screen/admin_home.dart';
import 'package:motivational_leadership/Coach/coach_home.dart';
import 'package:motivational_leadership/screen/signin.dart';
import 'package:motivational_leadership/services/database.dart';
import 'Student/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

late String userType = "loading";
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.black45,
  ));
  runApp(const MyApp());
}
final navigatorKey = GlobalKey<NavigatorState>();
final String uID = FirebaseAuth.instance.currentUser!.uid;

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
    Future.wait([getType(),]);
    bool entered = false;
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          //getType();
          // Future.wait([getType(),]);
          print('MYTAG : From main.dart UserType = $userType');
          if(userType=='admin'){
            entered = true;
            return AdminHome();
          }else if(userType=='coach'){
            entered = true;
            return CoachHome();
          }else{
            return StudentHome();
          }
        }else{
          entered;
          return SignIn();
        }
      }
    );
  }
  Future getType() async {
    String uid = await FirebaseAuth.instance.currentUser!.uid;
    userType = await DatabaseService.getUserType(uid);
    print("MYTAG : getType : userType = $userType");
    //return userType.toString();

  }

  @override
  void initState() {
    Future.wait([getType(),]);
    WidgetsBinding.instance.addPostFrameCallback((_){
      getType();
    });
    // userType = getType().toString();
    // if(userType!='admin' && userType!='coach' && userType != 'student'){
    //   userType = getType().toString();
    // }
    super.initState();

  }
}