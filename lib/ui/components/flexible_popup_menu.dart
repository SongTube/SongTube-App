import 'package:flutter/material.dart';
import 'package:songtube/ui/text_styles.dart';

class FlexiblePopupItem {

  final String title;
  final String value;

  FlexiblePopupItem({
    required this.title,
    required this.value
  });

}

class FlexiblePopupMenu extends StatelessWidget {
  final Widget child;
  final List<FlexiblePopupItem> items;
  final Function(String) onItemTap;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;
  const FlexiblePopupMenu({
    required this.child,
    required this.items,
    required this.onItemTap,
    this.borderRadius,
    this.padding,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        showMenu<String>(
          color: Theme.of(context).popupMenuTheme.color,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius == null
              ? BorderRadius.zero
              : BorderRadius.circular(borderRadius!),
          ),
          context: context,
          position: RelativeRect.fromLTRB(
            details.globalPosition.dx,
            details.globalPosition.dy,
            0, 0
          ),
          items: items.map((e) {
            return PopupMenuItem<String>(
              value: e.value,
              child: Text(
                e.title, style: smallTextStyle(context)
              ),
            );
          }).toList()
        ).then((value) {
          onItemTap(value!);
        });
      },
      child: Padding(
        padding: padding == null ? EdgeInsets.zero : padding!,
        child: child
      ),
    );
  }
}