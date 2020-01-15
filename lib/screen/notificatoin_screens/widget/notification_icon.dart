import 'package:flutter/material.dart';
import 'package:security_notifications/screen/notificatoin_screens/general_notification_screen.dart';

class NotificationIcon extends StatefulWidget {
  final String notificationType;

  const NotificationIcon({
    Key key,
    this.notificationType = "",
  }) : super(key: key);

  @override
  NotificationIconState createState() => NotificationIconState();
}

class NotificationIconState extends State<NotificationIcon>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;
  int _notificationQty = 0;
  IconData _iconData = Icons.notifications;
  Color _color = Colors.yellow;
  String _notificationTitle = "", _notificationBody = "";

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
        _color = Colors.green;
        break;
      case "Mail":
        _iconData = Icons.mail;
        _color = Colors.redAccent;
        break;
      case "General":
        _iconData = Icons.notifications;
        _color = Colors.yellowAccent;
        break;
      case "Message":
        _iconData = Icons.message;
        _color = Colors.lightBlueAccent;
        break;
      case "Map":
        _iconData = Icons.map;
        _color = Colors.deepOrangeAccent;
        break;
      case "Business":
        _iconData = Icons.business;
        _color = Colors.grey;
        break;
    }
  }

  void setNotificationTitle(
      {String notificationTitle = "", String notificationBody = ""}) {
    _notificationTitle = notificationTitle;
    _notificationBody = notificationBody;
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
        } else if (status == AnimationStatus.dismissed) {}
      });

    _animationController.forward();
  }

  void seeNotification() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GeneralNotificationScreen(
          notificationTitle: _notificationTitle,
          notificationBody: _notificationBody,
        ),
      ),
    );
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
      onTap: seeNotification,
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
                child: Icon(
                  _iconData,
                  color: _color,
                  size: 75,
                ),
              ),
            ),
            _notificationQty > 0
                ? Container(
                    height: 75,
                    width: 75,
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.all(Radius.circular(2)),
                        ),
                        child: Center(
                          child: Text(
                            "$_notificationQty",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
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
