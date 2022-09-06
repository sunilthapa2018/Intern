import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motivational_leadership/providers/coach/subtype/coach_action_provider.dart';
import 'package:motivational_leadership/providers/coach/subtype/coach_future_provider.dart';
import 'package:motivational_leadership/providers/coach/subtype/coach_imp_provider.dart';
import 'package:motivational_leadership/providers/coach/subtype/coach_io_provider.dart';
import 'package:motivational_leadership/providers/coach/subtype/coach_oc_provider.dart';
import 'package:motivational_leadership/providers/coach/subtype/coach_si_provider.dart';
import 'package:motivational_leadership/providers/coach/type/coach_autonomy_provider.dart';
import 'package:motivational_leadership/providers/coach/type/coach_belonging_provider.dart';
import 'package:motivational_leadership/providers/coach/type/coach_competence_provider.dart';
import 'package:motivational_leadership/providers/student/feedback/subtype/student_feedback_action_provider.dart';
import 'package:motivational_leadership/providers/student/feedback/subtype/student_feedback_future_provider.dart';
import 'package:motivational_leadership/providers/student/feedback/subtype/student_feedback_imp_provider.dart';
import 'package:motivational_leadership/providers/student/feedback/subtype/student_feedback_io_provider.dart';
import 'package:motivational_leadership/providers/student/feedback/subtype/student_feedback_oc_provider.dart';
import 'package:motivational_leadership/providers/student/feedback/subtype/student_feedback_si_provider.dart';
import 'package:motivational_leadership/providers/student/feedback/type/student_feedback_autonomy_provider.dart';
import 'package:motivational_leadership/providers/student/feedback/type/student_feedback_belonging_provider.dart';
import 'package:motivational_leadership/providers/student/feedback/type/student_feedback_competence_provider.dart';
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
import 'package:motivational_leadership/ui/student/student_home_page.dart';
import 'package:motivational_leadership/utility/colors.dart';
import 'package:motivational_leadership/utility/utils.dart';
import 'package:provider/provider.dart';

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
        //Student feedback type providers
        ChangeNotifierProvider(
            create: (_) => StudentFeedbackAutonomyProvider()),
        ChangeNotifierProvider(
            create: (_) => StudentFeedbackBelongingProvider()),
        ChangeNotifierProvider(
            create: (_) => StudentFeedbackCompetenceProvider()),
        //Student Feedback Sub type providers
        ChangeNotifierProvider(create: (_) => StudentFeedbackActionProvider()),
        ChangeNotifierProvider(create: (_) => StudentFeedbackOCProvider()),
        ChangeNotifierProvider(create: (_) => StudentFeedbackSIProvider()),
        ChangeNotifierProvider(
            create: (_) => StudentFeedbackImplementationProvider()),
        ChangeNotifierProvider(create: (_) => StudentFeedbackIOProvider()),
        ChangeNotifierProvider(create: (_) => StudentFeedbackFutureProvider()),
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
                fontSize: 16.sp,
                color: Colors.white,
                decoration: TextDecoration.none),
            headline3: TextStyle(
                fontWeight: FontWeight.w500,
                fontFamily: 'Roboto',
                fontSize: 36.sp,
                color: orangeColor,
                decoration: TextDecoration.none),
            headline4: TextStyle(
                fontWeight: FontWeight.w500,
                fontFamily: 'Roboto',
                fontSize: 16.sp,
                color: orangeColor,
                decoration: TextDecoration.none),
            headline5: TextStyle(
                fontWeight: FontWeight.w300,
                fontFamily: 'Roboto',
                fontSize: 12.sp,
                color: Colors.white,
                decoration: TextDecoration.none),
            headline6: TextStyle(
                fontWeight: FontWeight.w300,
                fontFamily: 'Roboto',
                fontSize: 20.sp,
                color: Colors.white,
                decoration: TextDecoration.none),
          ),
          fontFamily: 'Roboto',
          primarySwatch: Colors.deepPurple,
          colorScheme: ColorScheme.fromSwatch()
              .copyWith(primary: orangeColor, secondary: backgroundColor)),
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
            return const SignIn();
          } else {
            return FutureBuilder(
              future: getType(),
              builder: ((context, AsyncSnapshot<String?> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Scaffold(
                    // appBar: newAppBar(),
                    body: Center(
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
                    return const SignIn();
                  }
                } else {
                  return const SignIn();
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

  newAppBar() {
    return AppBar(
      backgroundColor: appBarColor,
      systemOverlayStyle: SystemUiOverlayStyle.light,
    );
  }
}
