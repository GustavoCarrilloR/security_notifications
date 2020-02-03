import 'dart:convert';

NotificationModel notificationFromJson(String str) =>
    NotificationModel.fromJson(json.decode(str));

String notificationToJson(NotificationModel data) => json.encode(data.toJson());

class NotificationModel {
  String notificationId;
  String notificationType;
  String notificationTitle;
  String notificationBody;
  int status;
  bool seen;

  NotificationModel({
    this.notificationId = "",
    this.notificationType = "",
    this.notificationTitle = "",
    this.notificationBody = "",
    this.status = 1,
    this.seen = false,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        notificationId: json["notificationId"],
        notificationType: json["notificationType"],
        notificationTitle: json["notificationTitle"],
        notificationBody: json["notificationBody"],
      );

  Map<String, dynamic> toJson() => {
        "notificationId": notificationId,
        "notificationType": notificationType,
        "notificationTitle": notificationTitle,
        "notificationBody": notificationBody,
        "status": status,
        "seen": seen,
      };

  factory NotificationModel.fromMap(Map<String, dynamic> map) =>
      NotificationModel(
        notificationId: map["notificationId"],
        notificationType: map["notificationType"],
        notificationTitle: map["notificationTitle"],
        notificationBody: map["notificationBody"],
        seen: map["seen"] == 1,
        status: 1,
      );

  Map<String, dynamic> toMap() => {
        "notificationId": notificationId,
        "notificationType": notificationType,
        "notificationTitle": notificationTitle,
        "notificationBody": notificationBody,
        "seen": seen ? 1 : 0,
        "status": status,
      };

  static bool validate(NotificationModel notificationModel) {
    return notificationModel.notificationId.isNotEmpty &&
        notificationModel.notificationType.isNotEmpty &&
        notificationModel.notificationTitle.isNotEmpty &&
        notificationModel.notificationBody.isNotEmpty;
  }
}
