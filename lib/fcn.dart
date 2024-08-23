import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FCN {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static Future<String?> getToken() async {
    String? token = await messaging.getToken();
    return token;
  }

  static Future<void> permessions() async {
    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage msg) async {
    await Firebase.initializeApp();
  }

  static Future<void> init() async {
    await permessions();
    await getToken();
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }

  foreGround() async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.max,
    );
  }
}
