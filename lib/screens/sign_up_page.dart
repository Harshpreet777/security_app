import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo3/services/post_notification_data.dart';
import 'package:firebase_demo3/services/auth_service.dart';
import 'package:firebase_demo3/model/notification_model.dart';
import 'package:firebase_demo3/utils/string_constants.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPage();
}

class _SignUpPage extends State<SignUpPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final User? user = Auth().currentUser;
  final Auth _auth = Auth();
  @override
  Widget build(BuildContext context) {
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      log('Message clicked!');
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      log("Message recieved");
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(event.notification?.title ?? ''),
              content: Text(event.notification?.body ?? ''),
              actions: [
                TextButton(
                  child: Text(StringConstants.ok),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    });
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: StringConstants.emailHint,
                    label: Text(StringConstants.email)),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: passController,
                obscureText: true,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: StringConstants.passHint,
                    label: Text(StringConstants.passHint)),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 50,
                width: 200,
                child: ElevatedButton(
                    onPressed: signUp,
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    child: Text(
                      StringConstants.signUp,
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    )),
              )
            ]),
      ),
    ));
  }

  void signUp() async {
    String email = emailController.text;
    String pass = passController.text;

    User? user = await _auth.signUpWithEmailAndPassword(email, pass);
    if (user != null) {
      log("User is Successfully created");
      await PostNotifcationData.postData(NotificationModel(
          to: StringConstants.subTopic,
          notification:
              Notifications(title: 'Signed Up', body: 'User $email created')));
    }
  }
}
