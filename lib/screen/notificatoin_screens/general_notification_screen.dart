import 'package:flutter/material.dart';

class GeneralNotificationScreen extends StatefulWidget {
  final String notificationTitle;
  final String notificationBody;

  const GeneralNotificationScreen(
      {Key key, this.notificationTitle = "", this.notificationBody = ""})
      : super(key: key);

  @override
  _GeneralNotificationScreenState createState() =>
      _GeneralNotificationScreenState();
}

class _GeneralNotificationScreenState extends State<GeneralNotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Colors.green,
                ),
                child: Text(
                  widget.notificationTitle,
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green, width: 5),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Text(
                  widget.notificationBody,
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
