import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motivational_leadership/firebase_options.dart';
import 'package:motivational_leadership/providers/coach/subtype/coach_action_provider.dart';
import 'package:motivational_leadership/providers/coach/subtype/coach_future_provider.dart';
import 'package:motivational_leadership/providers/coach/subtype/coach_imp_provider.dart';
import 'package:motivational_leadership/providers/coach/subtype/coach_io_provider.dart';
import 'package:motivational_leadership/providers/coach/subtype/coach_oc_provider.dart';
import 'package:motivational_leadership/providers/coach/subtype/coach_si_provider.dart';
import 'package:motivational_leadership/providers/coach/type/coach_autonomy_provider.dart';
import 'package:motivational_leadership/providers/coach/type/coach_belonging_provider.dart';
import 'package:motivational_leadership/providers/coach/type/coach_competence_provider.dart';
import 'package:motivational_leadership/providers/student/subtype/student_feedback_action_provider.dart';
import 'package:motivational_leadership/providers/student/subtype/student_feedback_future_provider.dart';
import 'package:motivational_leadership/providers/student/subtype/student_feedback_imp_provider.dart';
import 'package:motivational_leadership/providers/student/subtype/student_feedback_io_provider.dart';
import 'package:motivational_leadership/providers/student/subtype/student_feedback_oc_provider.dart';
import 'package:motivational_leadership/providers/student/subtype/student_feedback_si_provider.dart';
import 'package:motivational_leadership/providers/student/type/student_autonomy_provider.dart';
import 'package:motivational_leadership/providers/student/type/student_belonging_provider.dart';
import 'package:motivational_leadership/providers/student/type/student_competence_provider.dart';
import 'package:motivational_leadership/services/database.dart';
import 'package:motivational_leadership/ui/admin/admin_home_page.dart';
import 'package:motivational_leadership/ui/auth/sign_in_page.dart';
import 'package:motivational_leadership/ui/coach/coach_home_page.dart';
import 'package:motivational_leadership/ui/common/error_page.dart';
import 'package:motivational_leadership/ui/student/student_home_page.dart';
import 'package:motivational_leadership/utility/colors.dart';
import 'package:motivational_leadership/utility/utils.dart';
import 'package:motivational_leadership/widget/circular_progress_indicator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

String userType = "loading";
String localType = "";

Future main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        //Student type providers
        ChangeNotifierProvider(create: (_) => StudentAutonomyProvider()),
        ChangeNotifierProvider(create: (_) => StudentBelongingProvider()),
        ChangeNotifierProvider(create: (_) => StudentCompetenceProvider()),
        //Student Sub type providers
        ChangeNotifierProvider(create: (_) => StudentActionProvider()),
        ChangeNotifierProvider(create: (_) => StudentOCProvider()),
        ChangeNotifierProvider(create: (_) => StudentSIProvider()),
        ChangeNotifierProvider(create: (_) => StudentImplementationProvider()),
        ChangeNotifierProvider(create: (_) => StudentIOProvider()),
        ChangeNotifierProvider(create: (_) => StudentFutureProvider()),
        //Coach type providers
        ChangeNotifierProvider(create: (_) => CoachAutonomyProvider()),
        ChangeNotifierProvider(create: (_) => CoachBelongingProvider()),
        ChangeNotifierProvider(create: (_) => CoachCompetenceProvider()),
        //Coach Sub type providers
        ChangeNotifierProvider(create: (_) => CoachActionProvider()),
        ChangeNotifierProvider(create: (_) => CoachOCProvider()),
        ChangeNotifierProvider(create: (_) => CoachSIProvider()),
        ChangeNotifierProvider(create: (_) => CoachImplementationProvider()),
        ChangeNotifierProvider(create: (_) => CoachIOProvider()),
        ChangeNotifierProvider(create: (_) => CoachFutureProvider()),
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
        textTheme: TextTheme(
          headline1: TextStyle(
              fontWeight: FontWeight.w400,
              fontFamily: 'Roboto',
              fontSize: 24.sp,
              color: Colors.white,
              decoration: TextDecoration.none),
          headline2: TextStyle(
              fontWeight: FontWeight.w300,
              fontFamily: 'Roboto',
              fontSize: 14.sp,
              color: Colors.white,
              decoration: TextDecoration.none),
          headline3: TextStyle(
              fontWeight: FontWeight.w500,
              fontFamily: 'Roboto',
              fontSize: 24.sp,
              color: titleOrange,
              decoration: TextDecoration.none),
          headline4: TextStyle(
              fontWeight: FontWeight.w500,
              fontFamily: 'Roboto',
              fontSize: 14.sp,
              color: titleOrange,
              decoration: TextDecoration.none),
          headline5: TextStyle(
              fontWeight: FontWeight.w300,
              fontFamily: 'Roboto',
              fontSize: 12.sp,
              color: Colors.white,
              decoration: TextDecoration.none),
          headline6: TextStyle(
              fontWeight: FontWeight.w400,
              fontFamily: 'Roboto',
              fontSize: 17.sp,
              color: Colors.white,
              decoration: TextDecoration.none),
        ),
        fontFamily: 'Roboto',
        primarySwatch: Colors.orange,
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(primary: orangeColor, secondary: backgroundColor),
      ),
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
    log("Main page built");
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return myCircularProgressIndicator(context);
          }
          if (snapshot.data == null) {
            log("Sign in 1");
            return const SignIn();
          } else {
            return FutureBuilder(
              future: getFromAdmin(),
              builder: ((context, AsyncSnapshot<String?> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return myCircularProgressIndicator(context);
                }
                if (snapshot.data != null && snapshot.hasData) {
                  final fromAdmin = snapshot.data;
                  if (fromAdmin == 'true') {
                    return buildFutureByUserType();
                  }
                }
                return buildFutureByUserType2();
              }),
            );
          }
        });
  }

  FutureBuilder<String?> buildFutureByUserType() {
    log("buildFutureByUserType");
    return FutureBuilder(
      future: getType(),
      builder: ((context, AsyncSnapshot<String?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return myCircularProgressIndicator(context);
        }
        log("Snapshot = ${snapshot.data}");
        if (snapshot.data != null && snapshot.hasData) {
          final userType = snapshot.data;
          if (userType == 'Admin') {
            return const AdminHome();
          } else if (userType == 'Coach') {
            signInAdminAgain();
            return const CoachHome();
          } else if (userType == 'Student') {
            signInAdminAgain();
            return const StudentHome();
          }
        }
        log("Sign in 2");
        return const SignIn();
      }),
    );
  }

  FutureBuilder<String?> buildFutureByUserType2() {
    log("buildFutureByUserType2  buildFutureByUserType2");
    return FutureBuilder(
      future: getType(),
      builder: ((context, AsyncSnapshot<String?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return myCircularProgressIndicator(context);
        }
        if (snapshot.data != null) {
          final userType = snapshot.data;
          if (userType == 'Admin') {
            return const AdminHome();
          } else if (userType == 'Coach') {
            return const CoachHome();
          } else if (userType == 'Student') {
            return const StudentHome();
          } else {
            log("ErrorPage");
            return const ErrorPage();
          }
        } else {}
        log("Sign in 3");
        return const SignIn();
      }),
    );
  }

  Future<String?> getType() async {
    userType = "loading";
    if (FirebaseAuth.instance.currentUser != null) {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      userType = await DatabaseService.getUserType(uid);
      log(userType);
      return userType;
    }
    return null;
  }

  Future<String?> getFromAdmin() async {
    userType = "loading";
    //Reading saved password from local db and re-authenticating user with credentials
    final prefs = await SharedPreferences.getInstance();
    final fromAdmin = prefs.getBool('fromAdmin');
    if (fromAdmin != null) {
      if (fromAdmin) {
        return "true";
      } else {
        return "false";
      }
    }
    return null;
  }

  newAppBar() {
    return AppBar(
      backgroundColor: appBarColor,
      systemOverlayStyle: SystemUiOverlayStyle.light,
    );
  }
}

Future<void> signInAdminAgain() async {
  //Reading saved password from local db and re-authenticating user with credentials
  final prefs = await SharedPreferences.getInstance();
  final email = prefs.getString('email').toString();
  final savedPass = prefs.getString('password').toString();
  await FirebaseAuth.instance
      .signInWithEmailAndPassword(email: email, password: savedPass);
}
