import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:security_notifications/helpers/database/database_helper.dart';
import 'package:security_notifications/model/notification_model.dart';
import 'package:security_notifications/screen/notification_screens/general_notification_screen.dart';
import 'package:security_notifications/screen/notification_screens/widget/notification_icon.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  final GlobalKey<NotificationIconState> empNotificationKey =
      GlobalKey<NotificationIconState>();
  final GlobalKey<NotificationIconState> mailNotificationKey =
      GlobalKey<NotificationIconState>();
  final GlobalKey<NotificationIconState> messNotificationKey =
      GlobalKey<NotificationIconState>();
  final GlobalKey<NotificationIconState> busNotificationKey =
      GlobalKey<NotificationIconState>();
  final GlobalKey<NotificationIconState> generalNotificationKey =
      GlobalKey<NotificationIconState>();

  String lastId = "";

  List<String> images = [
    "assets/images/first.jpg",
    "assets/images/second.jpg",
    "assets/images/third.jpg",
    "assets/images/fourth.jpg",
    "assets/images/fifth.jpg",
  ];

  void listenNotifications() {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        final data = message["data"];
        final notification = message["notification"];

        if (lastId != data["notificationId"]) {
          lastId = data["notificationId"];

          NotificationModel newNotification = NotificationModel();

          if (data["notificationType"] == "Employee") {
            empNotificationKey.currentState.updateNotification();
          } else if (data["notificationType"] == "Mail") {
            mailNotificationKey.currentState.updateNotification();
          } else if (data["notificationType"] == "General") {
            generalNotificationKey.currentState.updateNotification();
          } else if (data["notificationType"] == "Message") {
            messNotificationKey.currentState.updateNotification();
          } else if (data["notificationType"] == "Business") {
            busNotificationKey.currentState.updateNotification();
          }

          newNotification.notificationType = data["notificationType"];
          newNotification.notificationId = data["notificationId"];
          newNotification.notificationTitle = notification["title"];
          newNotification.notificationBody = notification["body"];

          if (NotificationModel.validate(newNotification)) {
            DatabaseHelper.db.addNewNotification(newNotification);
          }
        }
      },
      onResume: (Map<String, dynamic> message) async {
        final data = message["data"];
        final notification = message["notification"];

        if (lastId != data["notificationId"]) {
          lastId = data["notificationId"];

          bool alreadyExists =
              await DatabaseHelper.db.existRecord(data["notificationId"]);
          if (!alreadyExists) {
            NotificationModel newNotification = NotificationModel();

            if (data["notificationType"] == "Employee") {
              empNotificationKey.currentState.updateNotification();
            } else if (data["notificationType"] == "Mail") {
              mailNotificationKey.currentState.updateNotification();
            } else if (data["notificationType"] == "General") {
              generalNotificationKey.currentState.updateNotification();
            } else if (data["notificationType"] == "Message") {
              messNotificationKey.currentState.updateNotification();
            } else if (data["notificationType"] == "Business") {
              busNotificationKey.currentState.updateNotification();
            }

            newNotification.notificationType = data["notificationType"];
            newNotification.notificationId = data["notificationId"];
            newNotification.notificationTitle = notification["title"];
            newNotification.notificationBody = notification["body"];
            newNotification.seen = true;

            if (NotificationModel.validate(newNotification)) {
              DatabaseHelper.db.addNewNotification(newNotification);
            }
          }

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GeneralNotificationScreen(
                notificationType: data["notificationType"],
                notificationBody: notification["body"],
                notificationTitle: notification["title"],
              ),
            ),
          );
        }
      },
      onLaunch: (Map<String, dynamic> message) async {
        final data = message["data"];
        final notification = message["notification"];

        if (lastId != data["notificationId"]) {
          lastId = data["notificationId"];

          bool alreadyExists =
              await DatabaseHelper.db.existRecord(data["notificationId"]);
          if (!alreadyExists) {
            NotificationModel newNotification = NotificationModel();

            if (data["notificationType"] == "Employee") {
              empNotificationKey.currentState.updateNotification();
            } else if (data["notificationType"] == "Mail") {
              mailNotificationKey.currentState.updateNotification();
            } else if (data["notificationType"] == "General") {
              generalNotificationKey.currentState.updateNotification();
            } else if (data["notificationType"] == "Message") {
              messNotificationKey.currentState.updateNotification();
            } else if (data["notificationType"] == "Business") {
              busNotificationKey.currentState.updateNotification();
            }

            newNotification.notificationType = data["notificationType"];
            newNotification.notificationId = data["notificationId"];
            newNotification.notificationTitle = notification["title"];
            newNotification.notificationBody = notification["body"];
            newNotification.seen = true;

            if (NotificationModel.validate(newNotification)) {
              DatabaseHelper.db.addNewNotification(newNotification);
            }
          }

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GeneralNotificationScreen(
                notificationType: data["notificationType"],
                notificationBody: notification["body"],
                notificationTitle: notification["title"],
              ),
            ),
          );
        }
      },
    );
  }

  void setDataFromDB() async {
    int empQty = 0, mailQty = 0, messQty = 0, busQty = 0 /*, genQty = 0*/;
    empQty = await DatabaseHelper.db.countNotifications("Employee");
    mailQty = await DatabaseHelper.db.countNotifications("Mail");
    messQty = await DatabaseHelper.db.countNotifications("Message");
    busQty = await DatabaseHelper.db.countNotifications("Business");
//    genQty =
//        await DatabaseHelper.countNotifications("notifications", "General");
    if (mounted) {
      setState(() {
        empNotificationKey.currentState.setNotificationsQty(empQty);
        mailNotificationKey.currentState.setNotificationsQty(mailQty);
        messNotificationKey.currentState.setNotificationsQty(messQty);
        busNotificationKey.currentState.setNotificationsQty(busQty);
//        generalNotificationKey.currentState.setNotificationsQty(genQty);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listenNotifications();
    setDataFromDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Security Notifications",
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
      drawer: Drawer(),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _title,
              _notificationButtons(),
              _notificationBoardTitle,
              _notificationBoard(),
              _version,
            ],
          ),
        ),
      ),
    );
  }

  Widget _title = Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 10, bottom: 10, left: 25),
          child: Text(
            "Check what's new today!",
            style: TextStyle(
              fontFamily: "Lato",
              shadows: <Shadow>[
                Shadow(
                  color: Colors.blueGrey,
                  offset: Offset(1, 1),
                  blurRadius: 3.0,
                ),
              ],
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
  );

  Widget _searchBox = Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 350,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.black87,
              width: .1,
            ),
            borderRadius: BorderRadius.all(new Radius.circular(30)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black26,
                offset: Offset(1.0, 2.0),
                blurRadius: 2.0,
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 15,
          ),
          child: TextField(
            style: TextStyle(
              fontFamily: "Lato",
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
            decoration: InputDecoration(
              hintText: "Search by Topic",
              hintStyle: TextStyle(
                fontFamily: "Lato",
                fontSize: 15,
                fontWeight: FontWeight.w300,
              ),
              border: InputBorder.none,
              suffixIcon: Icon(
                Icons.search,
                size: 25,
              ),
            ),
          ),
        ),
      ],
    ),
  );

  Widget _notificationButtons() {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          NotificationIcon(
            key: empNotificationKey,
            notificationType: "Employee",
            onPopUpFun: setDataFromDB,
          ),
          NotificationIcon(
            key: mailNotificationKey,
            notificationType: "Mail",
            onPopUpFun: setDataFromDB,
          ),
          NotificationIcon(
            key: messNotificationKey,
            notificationType: "Message",
            onPopUpFun: setDataFromDB,
          ),
          NotificationIcon(
            key: busNotificationKey,
            notificationType: "Business",
            onPopUpFun: setDataFromDB,
          ),
        ],
      ),
    );
  }

  Widget _notificationBoardTitle = Container(
    child: Text(
      "Notifications Board",
      style: TextStyle(
        fontFamily: "Lato",
        shadows: <Shadow>[
          Shadow(
            color: Colors.blueGrey,
            offset: Offset(1, 1),
            blurRadius: 3.0,
          ),
        ],
        fontSize: 24,
        fontWeight: FontWeight.w700,
      ),
    ),
  );

  Widget _notificationBoard() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: CarouselSlider(
        height: 390.0,
        items: [0, 1, 2, 3, 4].map((i) {
          return Builder(
            builder: (BuildContext context) {
              Widget _notificationImage = ClipRRect(
                borderRadius: BorderRadius.all(new Radius.circular(10)),
                child: Container(
                  child: Image(
                    image: AssetImage(images[i]),
                    height: 250,
                    width: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? 350
                        : 550,
                    fit: BoxFit.fill,
                  ),
                ),
              );

              Widget _notificationDetails = Flexible(
                fit: FlexFit.tight,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Text(
                                "Notification Title",
                                style: TextStyle(
                                  fontFamily: "Lato",
                                  fontSize: 22,
                                  fontWeight: FontWeight.w400,
                                  shadows: <Shadow>[
                                    Shadow(
                                      color: Colors.blueGrey,
                                      offset: Offset(0.5, 0.5),
                                      blurRadius: 2.0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 30,
                        child: Tooltip(
                          message: "seen by +99 users",
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                fit: FlexFit.tight,
                                child: Container(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "This is a sample description of the notification message sent to all the users of the app",
                                      style: TextStyle(
                                        fontFamily: "Lato",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 55,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Container(
                                      child: Icon(
                                        Icons.visibility,
                                        size: 25,
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        "+99",
                                        style: TextStyle(
                                          fontFamily: "Lato",
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "SAVE",
                              style: TextStyle(
                                color: Colors.lightBlueAccent,
                                fontFamily: "Lato",
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "MARK AS SEEN",
                              style: TextStyle(
                                color: Colors.lightBlueAccent,
                                fontFamily: "Lato",
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );

              return Container(
                width:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? 350
                        : 550,
                margin: EdgeInsets.only(
                    left: 15.0, right: 15.0, bottom: 30.0, top: 10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(3.0, 3.0),
                      blurRadius: 5.0,
                      spreadRadius: 4.0,
                    )
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        _notificationImage,
                        _notificationDetails,
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }

  Widget _version = Align(
    alignment: Alignment.bottomLeft,
    child: Container(
      margin: EdgeInsets.only(top: 5, bottom: 10),
      child: Text(
        "Version 4 (02/01/2019)",
        style: TextStyle(
          fontFamily: "Lato",
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}
