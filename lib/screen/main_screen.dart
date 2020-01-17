import 'package:carousel_slider/carousel_slider.dart';
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
    listenNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
          padding: EdgeInsets.only(bottom: 20),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _title,
                _searchBox,
                _notificationButtons(),
                _notificationBoardTitle,
                _notificationBoard(),
              ],
            ),
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
              fontSize: 15,
              fontWeight: FontWeight.w400,
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
      margin: EdgeInsets.only(bottom: 10, top: 20),
      child: Row(
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
            key: messNotificationKey,
            notificationType: "Message",
          ),
          NotificationIcon(
            key: busNotificationKey,
            notificationType: "Business",
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
        fontSize: 22,
        fontWeight: FontWeight.w500,
      ),
    ),
  );

  Widget _notificationBoard() {
    return Container(
      margin: EdgeInsets.only(top: 12),
      child: CarouselSlider(
        height: 285.0,
        items: [0, 1, 2, 3, 4].map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  color: Colors.cyan,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(2.0, 2.0),
                    )
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Center(
                    child: Stack(
                      children: <Widget>[
                        Container(
                          height: 285.0,
                          child: Image(
                            image: AssetImage(images[i]),
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 10),
                                child: Text(
                                  "This is a sample text from a notification. This text can be modified with the latest notifications from the app.",
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Lato",
                                    fontSize: 18,
                                    fontWeight: FontWeight.w300,
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
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
