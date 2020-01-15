import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:security_notifications/screen/notificatoin_screens/widget/notification_icon.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  AnimationController controller;
  Animation<double> animation;

  final GlobalKey<NotificationIconState> empNotificationKey =
      GlobalKey<NotificationIconState>();
  final GlobalKey<NotificationIconState> mailNotificationKey =
      GlobalKey<NotificationIconState>();
  final GlobalKey<NotificationIconState> generalNotificationKey =
      GlobalKey<NotificationIconState>();
  final GlobalKey<NotificationIconState> messNotificationKey =
      GlobalKey<NotificationIconState>();
  final GlobalKey<NotificationIconState> mapNotificationKey =
      GlobalKey<NotificationIconState>();
  final GlobalKey<NotificationIconState> busNotificationKey =
      GlobalKey<NotificationIconState>();

  void initialAnimation() {
    controller =
        AnimationController(duration: Duration(seconds: 1), vsync: this);

    animation = Tween<double>(
      begin: 0.00,
      end: 1.00,
    ).animate(controller)
      ..addListener(() {
        setState(() {});
      });

    controller.forward();
  }

  void listenNotifications() {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        final data = message["data"];
        final notification = message["notification"];

        if (data["notificationType"] == "Employee") {
          if (data != null) {
            empNotificationKey.currentState.updateNotification();
          }
          if (notification != null) {
            empNotificationKey.currentState.setNotificationTitle(
                notificationTitle: notification["title"],
                notificationBody: notification["body"]);
          }
        } else if (data["notificationType"] == "Mail") {
          if (data != null) {
            mailNotificationKey.currentState.updateNotification();
          }
          if (notification != null) {
            mailNotificationKey.currentState.setNotificationTitle(
                notificationTitle: notification["title"],
                notificationBody: notification["body"]);
          }
        } else if (data["notificationType"] == "General") {
          if (data != null) {
            generalNotificationKey.currentState.updateNotification();
          }
          if (notification != null) {
            generalNotificationKey.currentState.setNotificationTitle(
                notificationTitle: notification["title"],
                notificationBody: notification["body"]);
          }
        } else if (data["notificationType"] == "Message") {
          if (data != null) {
            messNotificationKey.currentState.updateNotification();
          }
          if (notification != null) {
            messNotificationKey.currentState.setNotificationTitle(
                notificationTitle: notification["title"],
                notificationBody: notification["body"]);
          }
        } else if (data["notificationType"] == "Map") {
          if (data != null) {
            mapNotificationKey.currentState.updateNotification();
          }
          if (notification != null) {
            mapNotificationKey.currentState.setNotificationTitle(
                notificationTitle: notification["title"],
                notificationBody: notification["body"]);
          }
        } else if (data["notificationType"] == "Business") {
          if (data != null) {
            busNotificationKey.currentState.updateNotification();
          }
          if (notification != null) {
            busNotificationKey.currentState.setNotificationTitle(
                notificationTitle: notification["title"],
                notificationBody: notification["body"]);
          }
        }
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialAnimation();
    listenNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Row(
            children: <Widget>[
              Flexible(
                fit: FlexFit.tight,
                child: Opacity(
                  opacity: animation != null && animation.value != null
                      ? animation.value
                      : 0.00,
                  child: Align(
                    alignment: Alignment(
                        animation != null && animation.value != null
                            ? -1.00 + animation.value
                            : -1.00,
                        0.00),
                    child: Container(
                      width: 80,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          NotificationIcon(
                            key: empNotificationKey,
                            notificationType: "Employee",
                          ),
                          NotificationIcon(
                            key: mailNotificationKey,
                            notificationType: "Mail",
                          ),
                          NotificationIcon(
                            key: generalNotificationKey,
                            notificationType: "General",
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: Opacity(
                  opacity: animation != null && animation.value != null
                      ? animation.value
                      : 0.00,
                  child: Align(
                    alignment: Alignment(
                        animation != null && animation.value != null
                            ? 1 - animation.value
                            : 1.00,
                        0.00),
                    child: Container(
                      width: 80,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          NotificationIcon(
                            key: messNotificationKey,
                            notificationType: "Message",
                          ),
                          NotificationIcon(
                            key: mapNotificationKey,
                            notificationType: "Map",
                          ),
                          NotificationIcon(
                            key: busNotificationKey,
                            notificationType: "Business",
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
