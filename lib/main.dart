import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motivational_leadership/Coach/coach_home.dart';
import 'package:motivational_leadership/Student/home.dart';
import 'package:motivational_leadership/Utility/colors.dart';
import 'package:motivational_leadership/Utility/utils.dart';
import 'package:motivational_leadership/providers/autonomy_provider.dart';
import 'package:motivational_leadership/providers/belonging_provider.dart';
import 'package:motivational_leadership/providers/competence_provider.dart';
import 'package:motivational_leadership/screen/signin.dart';
import 'package:motivational_leadership/services/database.dart';
import 'package:provider/provider.dart';

import 'screen/admin_home.dart';

String userType = "loading";
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        designSize: const Size(360, 592),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (BuildContext context, Widget? child) {
          return buildMaterialApp();
        },
      ),
    );
  }

  MaterialApp buildMaterialApp() {
    return MaterialApp(
      scaffoldMessengerKey: Utils.messengerKey,
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: _title,
      theme: ThemeData(
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: backgroundColor)),
      home: const MainPage(),
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
        builder: (context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.data == null) {
            return SignIn();
          } else {
            return FutureBuilder(
              future: getType(),
              builder: ((context, AsyncSnapshot<String?> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Scaffold(
                    appBar: AppBar(),
                    body: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                if (snapshot.data != null && snapshot.hasData) {
                  final userType = snapshot.data;
                  log("usertype:$userType");
                  if (userType == 'admin') {
                    return const AdminHome();
                  } else if (userType == 'coach') {
                    return const CoachHome();
                  } else if (userType == 'student') {
                    return const StudentHome();
                  } else {
                    return Container();
                  }
                } else {
                  return SignIn();
                }
              }),
            );
          }
        });
  }

  Future<String?> getType() async {
    userType = "loading";
    log("getType executed : usertype = $userType");
    if (FirebaseAuth.instance.currentUser != null) {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      userType = await DatabaseService.getUserType(uid);
      log("main.dart : getType : userType = $userType");
      return userType;
    }
    return null;
  }
}
