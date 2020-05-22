// Flutter
import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget{

  final EdgeInsetsGeometry padding;
  final BorderRadiusGeometry borderRadius;
  final Color backgroundColor;
  final IconData leadingIcon;
  final Color leadingIconColor;
  final Widget title;
  final Function onTap;

  DrawerItem({
    this.padding = const EdgeInsets.only(left: 14, right: 14),
    this.borderRadius = const BorderRadius.all(Radius.circular(20)),
    @required this.backgroundColor,
    @required this.leadingIcon,
    @required this.leadingIconColor,
    @required this.title,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: backgroundColor
        ),
        child: ListTile(
          leading: Icon(leadingIcon, color: leadingIconColor),
          title: title,
          onTap: onTap
        ),
      ),
    );
  }
}