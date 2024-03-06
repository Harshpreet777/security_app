import 'dart:convert';

NotificationModel notificationModelFromJson(String str) => NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) => json.encode(data.toJson());

class NotificationModel {
  String to;
  Notifications notification;

  NotificationModel({
    required this.to,
    required this.notification,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
        to: json["to"],
        notification: Notifications.fromJson(json["notification"]),
      );

  Map<String, dynamic> toJson() => {
        "to": to,
        "notification": notification.toJson(),
      };
}

class Notifications {
  String title;
  String body;

  Notifications({
    required this.title,
    required this.body,
  });

  factory Notifications.fromJson(Map<String, dynamic> json) => Notifications(
        title: json["title"],
        body: json["body"],
      );

  Map<String, String> toJson() => {
        "title": title,
        "body": body,
      };
}
