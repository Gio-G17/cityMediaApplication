import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:voiceofgospel/services/local_notification_service.dart';

class FirebaseServices {



  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> init() async {

    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      NotificationService().showNotification(title:message.notification!.title,body:message.notification!.body );
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    });
  }
}
