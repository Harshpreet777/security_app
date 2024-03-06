import 'dart:developer';

import 'package:firebase_demo3/model/notification_model.dart';
import 'package:http/http.dart' as http;

class PostNotifcationData {
  static Future postData(NotificationModel notificationModel) async {
    try {
      final resposne = await http.post(
          Uri.parse('https://fcm.googleapis.com/fcm/send'),
          body: notificationModelToJson(notificationModel),
          headers: <String, String>{
            "Content-Type": "application/json",
            "Authorization":
                "key=AAAAVVlmI1A:APA91bEVwChbM7N8hbKz8FlLx_jIQihqLm7hDjEhUCLS_Gqpwk-vgqMqijdsEmO-G_C8C_zLJwLimdPlWzvKINoJ5asMc592DEVicf3M417s_DGvgzAidVVkJVUJqDeIoHcOAea6Wiff"
          });
      log(resposne.body.toString());
    } catch (e) {
      log("Failed to Load $e");
    }
  }
}
