import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationServices {
  static final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialize(BuildContext context) {
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings("@mipmap/ic_launcher"));

    _localNotificationsPlugin.initialize(initializationSettings, onSelectNotification: (String? route)async{
      if (route != null){
        Navigator.of(context).pushNamed(route);
      }
    });
  }

  static void display(RemoteMessage msg) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      final NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(
              "mbc", "mbc chanel", "this is our chanel",
              priority: Priority.high, importance: Importance.high));

      await _localNotificationsPlugin.show(id, msg.notification!.title,
          msg.notification!.body, notificationDetails, payload: msg.data["event"]);
    } catch (e) {
      print(e);
    }
  }
}
