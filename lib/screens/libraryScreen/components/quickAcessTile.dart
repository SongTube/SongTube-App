// Flutter
import 'package:flutter/material.dart';

// Packages
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

class QuickAccessTile extends StatelessWidget {
  final Icon tileIcon;
  final String title;
  final Function onTap;
  QuickAccessTile({
    required this.tileIcon,
    required this.title,
    required this.onTap
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap as void Function()?,
      child: Padding(
        padding: EdgeInsets.only(
          left: 32,
          right: 32,
          top: 8,
          bottom: 8
        ),
        child: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          height: kToolbarHeight,
          child: Row(
            children: <Widget>[
              SizedBox(width: 32),
              tileIcon,
              SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: "Varela",
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).iconTheme.color
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.all(8),
                child: Icon(EvaIcons.arrowForwardOutline)
              ),
              SizedBox(width: 32)
            ],
          ),
        ),
      ),
    );
  }
}