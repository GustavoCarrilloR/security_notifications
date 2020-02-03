import 'package:flutter/material.dart';
import 'package:security_notifications/helpers/database/database_helper.dart';
import 'package:security_notifications/model/notification_model.dart';
import 'package:security_notifications/screen/notification_screens/general_notification_screen.dart';
import 'package:security_notifications/screen/notification_screens/widget/notification_card.dart';

class NotificationListScreen extends StatefulWidget {
  final String notificationType;
  final Function onPopUpFun;

  const NotificationListScreen(
      {Key key, this.notificationType = "", this.onPopUpFun})
      : super(key: key);

  @override
  _NotificationListScreenState createState() => _NotificationListScreenState();
}

class _NotificationListScreenState extends State<NotificationListScreen> {
  List<Widget> notificationsWidgets = [];

  Color appBarColor = Colors.green;
  Color cardColor = Colors.green;

  void updateNotification(NotificationModel notificationModel) {
    DatabaseHelper.db.updateNotification(notificationModel);
    getNotificationsFromDB();
  }

  void getNotificationsFromDB() async {
    List<Map> list =
        await DatabaseHelper.db.getRecords(widget.notificationType);
    if (mounted) {
      setState(() {
        notificationsWidgets.clear();
        notificationsWidgets = (list
            .map(
              (element) => NotificationCard(
                notificationModel: NotificationModel.fromMap(element),
                updateNotification: updateNotification,
                seeNotification: seeNotifications,
                backgroundColor: cardColor,
              ),
            )
            .toList());
      });
    }
  }

  void seeNotifications(NotificationModel notificationModel) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GeneralNotificationScreen(
          notificationType: widget.notificationType,
          notificationBody: notificationModel.notificationBody,
          notificationTitle: notificationModel.notificationTitle,
        ),
      ),
    );
  }

  void setNotificationTypeDetails() {
    switch (widget.notificationType) {
      case "Employee":
        appBarColor = Colors.green;
        cardColor = appBarColor;
        break;
      case "Mail":
        appBarColor = Colors.red;
        cardColor = appBarColor;
        break;
      case "Message":
        appBarColor = Colors.blue;
        cardColor = appBarColor;
        break;
      case "Business":
        appBarColor = Colors.blueGrey;
        cardColor = appBarColor;
        break;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNotificationsFromDB();
    setNotificationTypeDetails();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: appBarColor,
            centerTitle: true,
            title: Text(
              "Notifications",
              style: TextStyle(
                fontFamily: "Lato",
              ),
            ),
            actions: <Widget>[
              Container(
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: Icon(
                    Icons.account_circle,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
          body: ListView(
            children: notificationsWidgets,
          ),
        ),
        onWillPop: () async {
          widget.onPopUpFun();
          return true;
        });
  }
}
