import 'dart:convert';

NotificationModel notificationFromJson(String str) =>
    NotificationModel.fromJson(json.decode(str));

String notificationToJson(NotificationModel data) => json.encode(data.toJson());

class NotificationModel {
  String notificationId;
  int notificationType;
  String modelType;
  String modelId;
  Map<String, dynamic> extraFields;

  NotificationModel({
    this.notificationId,
    this.notificationType,
    this.modelType,
    this.modelId,
    this.extraFields,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
        notificationId: json["notificationId"],
        notificationType: json["notificationType"],
        modelType: json["modelType"],
        modelId: json["modelId"],
        extraFields: json["extraFields"],
      );

  Map<String, dynamic> toJson() => {
        "notificationId": notificationId,
        "notificationType": notificationType,
        "modelType": modelType,
        "modelId": modelId,
        "extraFields": extraFields,
      };

  bool validNotification(NotificationModel notification) =>
      (notification.notificationId != null &&
          notification.notificationType != null &&
          notification.modelId != null &&
          notification.modelType != null);
}
