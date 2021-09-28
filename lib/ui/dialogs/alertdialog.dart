// Flutter
import 'package:flutter/material.dart';

class CustomAlert extends StatelessWidget {
  final Icon leadingIcon;
  final String title;
  final String content;
  final List<Widget> actions;
  CustomAlert({
    this.leadingIcon,
    @required this.title,
    @required this.content,
    @required this.actions
  });
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ), 
      title: Row(
        children: <Widget>[
          leadingIcon,
          SizedBox(width: 6),
          Text(title, style: TextStyle(
            color: Theme.of(context).textTheme.bodyText1.color
          )),
        ],
      ),
      content: Text(content, style: TextStyle(
        color: Theme.of(context).textTheme.bodyText1.color
      )),
      actions: actions
    );
  }
}