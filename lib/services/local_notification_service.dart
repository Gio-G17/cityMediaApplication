import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const androidInitializationSetting = AndroidInitializationSettings('@mipmap/ic_launcher');
    // android/app/src/main/res/drawable/icon_notification.png
    const iosInitializationSetting = DarwinInitializationSettings(
     
    );
    const initSettings = InitializationSettings(android: androidInitializationSetting, iOS: iosInitializationSetting);
    await _flutterLocalNotificationsPlugin.initialize(initSettings);
    // const AndroidInitializationSettings initializationSettingsAndroid =
    // AndroidInitializationSettings("@drawable/ic_launcher");
    // const initializationSettingsIOS =
    //  DarwinInitializationSettings();
    // const InitializationSettings initializationSettings =
    // InitializationSettings(
    //     android: initializationSettingsAndroid,
    //     iOS: initializationSettingsIOS);
    // await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
    //
    // // Create a channel
    // const AndroidNotificationChannel channel = AndroidNotificationChannel(
    //   'high_importance', // id
    //   'high_importance', // title
    //   // 'channel_Description', // description
    //   importance: Importance.high,
    // );
    // await _flutterLocalNotificationsPlugin
    //     .resolvePlatformSpecificImplementation<
    //     AndroidFlutterLocalNotificationsPlugin>()
    //     ?.createNotificationChannel(channel);
  }

  Future<void> showNotification({String? title, String? body}) async {
    final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'high_importance',
      'high_importance',
      // 'channel_Description',
      importance: Importance.max,
      priority: Priority.high,
    );
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await _flutterLocalNotificationsPlugin.show(
        id, title, body, platformChannelSpecifics,
        payload: '');
  }
}
