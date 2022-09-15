import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class MyHomePageTest extends StatefulWidget {
  @override
  _MyHomePageTestState createState() => _MyHomePageTestState();
}

class _MyHomePageTestState extends State<MyHomePageTest> {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var android = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var ios = const IOSInitializationSettings();
    var initSettings = InitializationSettings(android: android, iOS: ios);
    flutterLocalNotificationsPlugin.initialize(initSettings,
        onSelectNotification: (payload) => selectNotification(payload ?? ""));
  }

  selectNotification(String payload) {
    debugPrint('print payload : $payload');
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Notification'),
        content: Text(payload),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Local Notification'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            ElevatedButton(
                onPressed: showNotification, child: const Text('Click me'))
          ],
        ),
      ),
    );
  }

  showNotification() async {
    var android = const AndroidNotificationDetails("channelId", "channelName",
        priority: Priority.high, importance: Importance.max);
    var iOS = const IOSNotificationDetails();

    var platform = NotificationDetails(android: android, iOS: iOS);
    await flutterLocalNotificationsPlugin.show(
        0, 'Muhammed Essa', 'Ahmed Osama', platform,
        payload: 'This is my name');
  }
}
