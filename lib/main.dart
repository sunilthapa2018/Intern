import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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
import 'package:motivational_leadership/services/local_push_notification.dart';
import 'package:motivational_leadership/ui/admin/admin_home_page.dart';
import 'package:motivational_leadership/ui/auth/sign_in_page.dart';
import 'package:motivational_leadership/ui/coach/coach_home_page.dart';
import 'package:motivational_leadership/ui/student/student_home_page.dart';
import 'package:motivational_leadership/utility/colors.dart';
import 'package:motivational_leadership/utility/utils.dart';
import 'package:motivational_leadership/widget/circular_progress_indicator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

String userType = "loading";
Future<void> backgroundHandler(RemoteMessage message) async {
  log(message.data.toString());
  log(message.notification!.title.toString());
}

initializeFcm() async {
  FirebaseMessaging.instance.getInitialMessage().then(
    (message) {
      log("FirebaseMessaging.instance.getInitialMessage");
      if (message != null) {
        log("New Notification");
      }
    },
  );

  FirebaseMessaging.onMessage.listen(
    (message) {
      log("FirebaseMessaging.onMessage.listen");
      if (message.notification != null) {
        String? title = message.notification?.title;
        String? body = message.notification?.body;
        log("FirebaseMessaging.onMessage.listen || title = $title");
        log("FirebaseMessaging.onMessage.listen || body = $body");
        log("message.datail ${message.data}");
        NotificationService()
            .showNotification(1, title.toString(), body.toString(), 5);
        // LocalNotificationService.createanddisplaynotification(message);
      }
    },
  );
  FirebaseMessaging.onMessageOpenedApp.listen(
    (message) {
      log("FirebaseMessaging.onMessageOpenedApp.listen");
      if (message.notification != null) {
        log(message.notification!.title ?? "");
        log(message.notification!.body ?? "");
        log("message.data22 ${message.data['_id']}");
      }
    },
  );
}

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initializeFcm();

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
                fontWeight: FontWeight.w500,
                fontFamily: 'Roboto',
                fontSize: 16.sp,
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
                  return myCircularProgressIndicator(context);
                }
                if (snapshot.data != null && snapshot.hasData) {
                  final userType = snapshot.data;
                  if (userType == 'Admin') {
                    return const AdminHome();
                  } else if (userType == 'Coach') {
                    return const CoachHome();
                  } else if (userType == 'Student') {
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

  Future<String?> getTypeFromLocal() async {
    final prefs = await SharedPreferences.getInstance();
    final savedType = prefs.getString('type').toString();
    return savedType;
  }

  Future<String?> getType() async {
    userType = "loading";
    if (FirebaseAuth.instance.currentUser != null) {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      userType = await DatabaseService.getUserType(uid);
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
