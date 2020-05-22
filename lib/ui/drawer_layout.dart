// Flutter
import 'package:flutter/material.dart';

class DrawerLayout extends StatelessWidget{

  final Color headerColor;
  final Widget title;
  final List<Widget> children;
  final Widget leftBottomIcon;
  final Widget rightBottomIcon;
  DrawerLayout({
    @required this.headerColor,
    this.title,
    @required this.children,
    this.leftBottomIcon,
    this.rightBottomIcon
  });

  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(topRight: Radius.circular(20)),
      child: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: headerColor
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(height: kTextTabBarHeight*1.3),
                  Image.asset('assets/images/ic_launcher.png', width: 130, height: 130),
                  title == null
                    ? Container()
                    : title,
                  SizedBox(height: kTextTabBarHeight*1.3),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 14, bottom: 14),
              child: Divider(indent: 16, endIndent: 16),
            ),
            MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: Expanded(
                child: ListView(
                  children: children
                ),
              ),
            ),
            Divider(indent: 16, endIndent: 16),
            Padding(
              padding: EdgeInsets.only(left: 14, bottom: 14, right: 14, top: 7),
              child: Row(
                children: <Widget>[
                  leftBottomIcon == null ? Container() : leftBottomIcon,
                  Spacer(),
                  rightBottomIcon == null ? Container() : rightBottomIcon
                ],
              ),
            )
          ],
        )
      ),
    );
  }
}