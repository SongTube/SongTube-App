// Flutter
import 'package:flutter/material.dart';

class SettingsColumnTile extends StatelessWidget {
  final List<Widget> children;
  final String title;
  final IconData icon;
  SettingsColumnTile({
    @required this.title,
    @required this.icon,
    this.children
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.02),
            offset: Offset(0, 3), //(x,y)
            blurRadius: 6.0,
            spreadRadius: 0.01 
          )
        ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget> [
          Container(
            margin: EdgeInsets.only(bottom: 8),
            padding: EdgeInsets.only(top: 16, bottom: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              color: Theme.of(context).accentColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12.withOpacity(0.10),
                  offset: Offset(0, 3), //(x,y)
                  blurRadius: 6.0,
                  spreadRadius: 0.11 
                )
              ]
            ),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                  ),
                  child: Icon(icon, color: Colors.white),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 8,
                  ),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.white
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          )
        ]
      )
    );
  }
}