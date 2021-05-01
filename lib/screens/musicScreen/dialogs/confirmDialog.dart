// Flutter
import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {
  final Function onConfirm;
  final Function onCancel;
  ConfirmDialog({
    @required this.onConfirm,
    @required this.onCancel
  });
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
      ),
      title: Text(
        "Are you sure?",
        style: TextStyle(color: Theme.of(context).textTheme.bodyText1.color)
      ),
      content: Text(
        "You are going to permanently delete this Song",
        style: TextStyle(color: Theme.of(context).textTheme.bodyText1.color)
      ),
      actions: [
        TextButton(
          child: Text("OK", style: TextStyle(color: Theme.of(context).accentColor)),
          onPressed: onConfirm
        ),
        TextButton(
          child: Text("Cancel", style: TextStyle(color: Theme.of(context).accentColor)),
          onPressed: onCancel,
        )
      ],
    );
  }
}