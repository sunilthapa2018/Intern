import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:motivational_leadership/ui/student/student_home_page.dart';
import 'package:motivational_leadership/ui/signin_page.dart';
import 'package:motivational_leadership/services/database.dart';
import 'package:motivational_leadership/ui/admin/admin_home_page.dart';
import 'package:motivational_leadership/ui/coach/coach_home_page.dart';
import 'package:motivational_leadership/utility/base_util.dart';

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
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          return FutureBuilder(
            future: getType(),
            builder: (context2, snapshot2) {
              if (snapshot.hasData) {
                getType();
                if (userType == 'admin') {
                  return AdminHome();
                } else if (userType == 'coach') {
                  return CoachHome();
                } else if (userType == 'student') {
                  return StudentHome();
                } else {
                  return Scaffold();
                }
              } else {
                return SignIn();
              }
            },
          );
        });
  }

  Future getType() async {
    String uid = await FirebaseAuth.instance.currentUser!.uid;
    userType = await DatabaseService.getUserType(uid);

    print("MYTAG : getType : userType = $userType");
    // if(userType=='admin'){
    //   return AdminHome();
    // }else if(userType=='coach'){
    //   return CoachHome();
    // }else if(userType=='coach'){
    //   return StudentHome();
    // }else{
    //   setState((){});
    //   return Scaffold();
    // }
  }

  @override
  void initState() {
    // getType();
    // WidgetsBinding.instance.addPostFrameCallback((_){
    //   getType();
    // });
    // userType = getType().toString();
    // if(userType!='admin' && userType!='coach' && userType != 'student'){
    //   userType = getType().toString();
    // }
    super.initState();
  }
}
