import 'dart:convert';

class NotificationPushModel {
  NotificationPushModel({
    required this.id,
    required this.uid,
    required this.message,
    required this.status,
    required this.title,
  });

  String id;
  String uid;
  String message;
  String status;
  String title;

  factory NotificationPushModel.fromJson(String str) =>
      NotificationPushModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory NotificationPushModel.fromMap(Map<String, dynamic> json) =>
      NotificationPushModel(
        id: json["_id"],
        uid: json["UID"],
        message: json["message"],
        status: json["status"],
        title: json["title"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "UID": uid,
        "message": message,
        "status": status,
        "title": title,
      };
}

enum StatudNotificationPush {
  unread,
  read,
  delete,
}
