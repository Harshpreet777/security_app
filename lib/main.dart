import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_demo3/utils/firebase_option.dart';
import 'package:firebase_demo3/services/notifications_service.dart';
import 'package:firebase_demo3/screens/sign_up_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

Future _firebaseBackMsg(RemoteMessage message) async {
  if (message.notification != null) {
    log('Some Notification Received');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  PushNotifications.intt();
  FirebaseMessaging.onBackgroundMessage(_firebaseBackMsg);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SignUpPage());
  }
}
