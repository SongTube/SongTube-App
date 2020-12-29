import 'package:flutter/material.dart';

class FlexiblePopupItem {

  String title;
  String value;

  FlexiblePopupItem({
    this.title,
    this.value
  });

}

class FlexiblePopupMenu extends StatelessWidget {
  final Widget child;
  final List<FlexiblePopupItem> items;
  final Function(String) onItemTap;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  FlexiblePopupMenu({
    @required this.child,
    @required this.items,
    @required this.onItemTap,
    this.borderRadius,
    this.padding
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        showMenu<String>(
          color: Theme.of(context).popupMenuTheme.color,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius == null
              ? BorderRadius.zero
              : BorderRadius.circular(borderRadius),
          ),
          context: context,
          position: RelativeRect.fromLTRB(
            details.globalPosition.dx,
            details.globalPosition.dy,
            0, 0
          ),
          items: items.map((e) {
            return PopupMenuItem<String>(
              child: Text(
                e.title, style: TextStyle(
                  color: Theme.of(context)
                    .textTheme.bodyText1.color,
                  fontSize: 14
                ),
              ),
              value: "${e.value}",
            );
          }).toList()
        ).then((value) {
          onItemTap(value);
        });
      },
      child: Padding(
        padding: padding == null ? EdgeInsets.zero : padding,
        child: child
      ),
    );
  }
}