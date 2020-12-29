import 'package:flutter/material.dart';

class LoadingDownloadMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(width: 16),
        CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(
            Theme.of(context).accentColor
          ),
        ),
        SizedBox(width: 16),
        Text(
          "Loading...",
          style: TextStyle(
            fontFamily: 'YTSans',
            color: Theme.of(context).textTheme.bodyText1.color,
            fontWeight: FontWeight.w600,
            fontSize: 18
          ),
        )
      ],
    );
  }
}