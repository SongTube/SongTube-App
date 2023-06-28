import 'package:flutter/material.dart';
import 'package:songtube/main.dart';
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
      padding: const EdgeInsets.all(8).copyWith(left: 8, right: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.only(bottom: 0, left: 12, right: 12, top: 6),
        leading: leading ?? (icon != null ? Icon(icon, color: Theme.of(context).primaryColor) : null),
        title: Text(title, style: textStyle(context, bold: true).copyWith(fontSize: 16)),
        trailing: trailing,
      ),
    );
  }
}