import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Notify {
  FlutterLocalNotificationsPlugin plugin = FlutterLocalNotificationsPlugin();
  AndroidInitializationSettings androidSettings;
  IOSInitializationSettings iosSetting;
  InitializationSettings initSettings;

  Notify() {
    init();
  }

  void init() async {
    androidSettings = AndroidInitializationSettings('app_icon');
    iosSetting = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    initSettings =
        InitializationSettings(android: androidSettings, iOS: iosSetting);
    await plugin.initialize(initSettings,
        onSelectNotification: onSelectNotification);
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(body),
      actions: <Widget>[
        CupertinoDialogAction(
            isDefaultAction: true, onPressed: () {}, child: Text('OK'))
      ],
    );
  }

  Future onSelectNotification(String payload) {
    //navigator
  }

  void show(String title, String body) async {
    await notifications(title, body);
  }

  Future<void> notifications(String title, String body) async {
    AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
        'channelId', 'channelName', 'channelDescription',
        priority: Priority.high, importance: Importance.max, ticker: 'Test');
    IOSNotificationDetails iosDetail = IOSNotificationDetails();
    NotificationDetails details =
        NotificationDetails(android: androidDetails, iOS: iosDetail);
    await plugin.show(0, title, body, details);
  }
}
