import 'package:flutter/material.dart';
import 'package:security_notifications/model/notification_model.dart';

class NotificationCard extends StatefulWidget {
  final NotificationModel notificationModel;
  final Function updateNotification;
  final Function seeNotification;
  final Color backgroundColor;

  const NotificationCard(
      {Key key,
      this.notificationModel,
      this.updateNotification,
      this.seeNotification,
      this.backgroundColor})
      : super(key: key);

  @override
  _NotificationCardState createState() => _NotificationCardState();
}

class CustomPopupMenu {
  CustomPopupMenu({this.title, this.icon, this.index});

  String title;
  IconData icon;
  int index;
}

class _NotificationCardState extends State<NotificationCard> {
  List<CustomPopupMenu> choices = <CustomPopupMenu>[
    CustomPopupMenu(title: 'Mark as Seen', icon: Icons.visibility, index: 0),
    CustomPopupMenu(title: 'Remove', icon: Icons.delete, index: 1),
  ];

  Widget _newNotificationIcon = Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 5),
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 5, top: 5),
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                  Center(
                    child: Icon(
                      Icons.new_releases,
                      color: Colors.red,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );

  Widget _newNotificationImage = Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 70,
          width: 70,
          margin: EdgeInsets.only(left: 15),
          child: ClipRRect(
            borderRadius: BorderRadius.all(new Radius.circular(10)),
            child: Image(
              image: AssetImage("assets/images/first.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    ),
  );

  Widget _newNotificationDetails() {
    return GestureDetector(
      onTap: () {
        NotificationModel updated = widget.notificationModel;
        updated.seen = true;
        widget.updateNotification(updated);
        widget.seeNotification(updated);
      },
      child: Container(
        margin: EdgeInsets.only(top: 20, bottom: 20, right: 10, left: 50),
        padding: EdgeInsets.only(left: 40),
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.all(new Radius.circular(15)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black38,
              offset: Offset(1.0, 1.0),
              blurRadius: 5.0,
              spreadRadius: 2.0,
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            Flexible(
              fit: FlexFit.tight,
              child: Column(
                children: <Widget>[
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                            fit: FlexFit.tight,
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: 10, top: 10, bottom: 15),
                              child: Text(
                                widget.notificationModel.notificationTitle,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: "Lato",
                                  shadows: <Shadow>[
                                    Shadow(
                                      color: Colors.black45,
                                      offset: Offset(1, 1),
                                      blurRadius: 5.0,
                                    ),
                                  ],
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            )),
                        Container(
                          child: PopupMenuButton<CustomPopupMenu>(
                            elevation: 3.2,
                            icon: Icon(
                              Icons.more_vert,
                              color: Colors.white,
                              size: 30,
                            ),
                            onCanceled: () {
                              print('You have not chossed any option');
                            },
                            tooltip: "Display notification's options",
                            onSelected: (CustomPopupMenu custom) {
                              if (custom.index == 0) {
                                NotificationModel updated =
                                    widget.notificationModel;
                                updated.seen = true;
                                widget.updateNotification(updated);
                              } else if (custom.index == 1) {
                                NotificationModel updated =
                                    widget.notificationModel;
                                updated.status = 0;
                                widget.updateNotification(updated);
                              }
                            },
                            itemBuilder: (BuildContext context) {
                              return choices.map((CustomPopupMenu choice) {
                                return PopupMenuItem<CustomPopupMenu>(
                                  value: choice,
                                  child: Text(choice.title),
                                );
                              }).toList();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    widget.notificationModel.notificationBody,
                                    style: TextStyle(
                                      fontFamily: "Lato",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      child: Stack(
        children: <Widget>[
          _newNotificationDetails(),
          _newNotificationImage,
          !widget.notificationModel.seen ? _newNotificationIcon : Container(),
        ],
      ),
    );
  }
}
