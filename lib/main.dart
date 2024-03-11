import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_demo3/core/di/locator.dart';
import 'package:firebase_demo3/core/services/notifications_service.dart';
import 'package:firebase_demo3/core/utils/firebase_option.dart';
import 'package:firebase_demo3/ui/views/my_app_view.dart';
import 'package:flutter/material.dart';

void main() async {
  await setUpLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  PushNotifications.intt();
  runApp(const MyApp());
}
