import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotifications {
  static String getToken = '';

  static final _firebaseMsg = FirebaseMessaging.instance;

  static Future intt() async {
    await _firebaseMsg.subscribeToTopic('subscription');
    await _firebaseMsg.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: true,
      sound: true,
    );

    String? token = await _firebaseMsg.getToken();
    getToken = token ?? '';
    log('Token $token');
  }
}
