import 'package:flutter/material.dart';
import 'package:songtube/main.dart';
import 'package:songtube/ui/animations/animated_icon.dart';
import 'package:songtube/ui/sheet_phill.dart';
import 'package:songtube/ui/text_styles.dart';

void showSnackbar({required CustomSnackBar customSnackBar}) {
  ScaffoldMessenger.of(snackbarKey.currentContext!).clearSnackBars();
  ScaffoldMessenger.of(snackbarKey.currentContext!).showSnackBar(
    SnackBar(
      padding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      content: customSnackBar));
}

class CustomSnackBar extends StatelessWidget {
  const CustomSnackBar({
    this.icon,
    required this.title,
    this.trailing,
    this.leading,
    super.key});
  final IconData? icon;
  final String title;
  final Widget? trailing;
  final Widget? leading;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 8),
          const BottomSheetPhill(),
          ListTile(
            contentPadding: const EdgeInsets.only(bottom: 0, left: 12, right: 12, top: 0),
            leading: Padding(
              padding: const EdgeInsets.only(left: 12),
              child: leading ?? (icon != null ? AppAnimatedIcon(icon!) : null),
            ),
            title: Text(title, style: textStyle(context, bold: true).copyWith(fontSize: 16)),
            trailing: trailing,
          ),
        ],
      ),
    );
  }
}