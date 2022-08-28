import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motivational_leadership/Coach/coach_home.dart';
import 'package:motivational_leadership/Utility/utils.dart';
import 'package:motivational_leadership/providers/autonomy_provider.dart';
import 'package:motivational_leadership/providers/belonging_provider.dart';
import 'package:motivational_leadership/providers/competence_provider.dart';
import 'package:motivational_leadership/screen/admin_home.dart';
import 'package:motivational_leadership/screen/signin.dart';
import 'package:motivational_leadership/services/database.dart';
import 'package:provider/provider.dart';

import 'Student/home.dart';

String userType = "loading";
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AutonomyProvider()),
        ChangeNotifierProvider(create: (_) => BelongingProvider()),
        ChangeNotifierProvider(create: (_) => CompetenceProvider()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(392, 802),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (BuildContext context, Widget? child) {
          return MaterialApp(
            scaffoldMessengerKey: Utils.messengerKey,
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            title: _title,
            theme: ThemeData.light(),
            home: const StudentHome(),
          );
        },
      ),
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
    bool entered = false;
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            //getType();
            // Future.wait([getType(),]);
            print('MYTAG : From main.dart UserType = $userType');
            if (userType == 'admin') {
              entered = true;
              return const AdminHome();
            } else if (userType == 'coach') {
              entered = true;
              return const CoachHome();
            } else {
              return const StudentHome();
            }
          } else {
            entered;
            return SignIn();
          }
        });
  }

  Future getType() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    userType = await DatabaseService.getUserType(uid);
    print("MYTAG : getType : userType = $userType");
    //return userType.toString();
  }

  @override
  void initState() {
    Future.wait([
      getType(),
    ]);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getType();
    });
    // userType = getType().toString();
    // if(userType!='admin' && userType!='coach' && userType != 'student'){
    //   userType = getType().toString();
    // }
    super.initState();
  }
}
