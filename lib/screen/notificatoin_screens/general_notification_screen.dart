import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GeneralNotificationScreen extends StatefulWidget {
  final String notificationTitle;
  final String notificationBody;
  final String notificationType;

  const GeneralNotificationScreen(
      {Key key,
      this.notificationTitle = "",
      this.notificationBody = "",
      this.notificationType = ""})
      : super(key: key);

  @override
  _GeneralNotificationScreenState createState() =>
      _GeneralNotificationScreenState();
}

class _GeneralNotificationScreenState extends State<GeneralNotificationScreen> {
  Color _backgroundColor = Colors.orange;

  @override
  void initState() {
    // TODO: implement initState
    setNotificationData();
  }

  void setNotificationData() {
    switch (widget.notificationType) {
      case "Employee":
        _backgroundColor = Colors.green;
        break;
      case "Mail":
        _backgroundColor = Colors.red;
        break;
      case "General":
        _backgroundColor = Colors.amber;
        break;
      case "Message":
        _backgroundColor = Colors.blueAccent;
        break;
      case "Business":
        _backgroundColor = Colors.black54;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "${widget.notificationType}'s Notification",
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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 150,
                width: double.infinity,
                color: _backgroundColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 20, top: 20),
                      child: Text(
                        "Received at: ${DateFormat("MM/dd/yyyy hh:mm aa").format(DateTime.now())}",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Lato",
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20, top: 40),
                      child: Text(
                        widget.notificationTitle,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Lato",
                          fontSize: 36,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 50, left: 20, right: 20),
                child: Text(
                  widget.notificationBody,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontFamily: "Lato",
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
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
