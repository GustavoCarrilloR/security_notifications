import 'package:auto_size_text/auto_size_text.dart';
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
    super.initState();
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
        _backgroundColor = Colors.blueGrey;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: _backgroundColor,
          centerTitle: true,
          title: Text(
            "Details",
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40)),
              child: Container(
                height: 200,
                width: double.infinity,
                color: _backgroundColor,
                child: Image(
                  image: AssetImage("assets/images/first.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 20, top: 20),
                    child: Text(
                      "Received at: ${DateFormat("MM/dd/yyyy hh:mm aa").format(DateTime.now())}",
                      style: TextStyle(
                        color: Colors.black,
                        shadows: <Shadow>[
                          Shadow(
                            color: Colors.blueGrey,
                            offset: Offset(1, 1),
                            blurRadius: 3.0,
                          ),
                        ],
                        fontFamily: "Lato",
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: AutoSizeText(
                      widget.notificationTitle,
                      maxLines: 2,
                      minFontSize: 3,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black,
                        shadows: <Shadow>[
                          Shadow(
                            color: Colors.blueGrey,
                            offset: Offset(1, 1),
                            blurRadius: 3.0,
                          ),
                        ],
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
              margin: EdgeInsets.only(top: 30, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.notificationBody,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontFamily: "Lato",
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
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
}
