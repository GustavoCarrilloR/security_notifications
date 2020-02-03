import 'package:flutter/material.dart';

import '../notification_list_screen.dart';

class NotificationIcon extends StatefulWidget {
  final String notificationType;
  final Function onPopUpFun;
  final double iconSize;

  const NotificationIcon({
    Key key,
    this.notificationType = "",
    this.iconSize = 40,
    this.onPopUpFun,
  }) : super(key: key);

  @override
  NotificationIconState createState() => NotificationIconState();
}

class NotificationIconState extends State<NotificationIcon>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;

  int _notificationQty = 0;
  IconData _iconData = Icons.notifications;
  Color _backgroundColor = Colors.orange;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );

    setNotificationData();
  }

  void setNotificationData() {
    switch (widget.notificationType) {
      case "Employee":
        _iconData = Icons.person;
        _backgroundColor = Colors.green;
        break;
      case "Mail":
        _iconData = Icons.mail;
        _backgroundColor = Colors.red;
        break;
      case "General":
        _iconData = Icons.notifications;
        _backgroundColor = Colors.amber;
        break;
      case "Message":
        _iconData = Icons.message;
        _backgroundColor = Colors.blueAccent;
        break;
      case "Business":
        _iconData = Icons.business;
        _backgroundColor = Colors.blueGrey;
        break;
    }
  }

  void updateNotification() {
    setState(() {
      _notificationQty++;
    });
    startAnimation();
  }

  void startAnimation() {
    final CurvedAnimation curvedAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.bounceIn,
      reverseCurve: Curves.easeOut,
    );

    _animation = Tween<double>(
      begin: 0,
      end: 20,
    ).animate(curvedAnimation)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animationController.reverse();
        }
      });

    _animationController.forward();
  }

  void seeNotifications() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NotificationListScreen(
          notificationType: widget.notificationType,
          onPopUpFun: widget.onPopUpFun,
        ),
      ),
    );
  }

  void setNotificationsQty(int quantity) {
    _notificationQty = quantity;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        seeNotifications();
      },
      child: Container(
        child: Stack(
          children: <Widget>[
            Transform.translate(
              offset: Offset(
                0.0,
                _animation != null && _animation.value != null
                    ? -_animation.value
                    : 0,
              ),
              child: Center(
                child: Container(
                  height: 100,
                  width: 80,
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _backgroundColor,
                        ),
                        child: Icon(
                          _iconData,
                          color: Colors.white,
                          size: widget.iconSize,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Text(
                          widget.notificationType,
                          style: TextStyle(
                            fontFamily: "Lato",
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            _notificationQty > 0
                ? Container(
                    height: 100,
                    width: 80,
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.all(Radius.circular(3)),
                        ),
                        child: Center(
                          child: Text(
                            "$_notificationQty",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Lato",
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
