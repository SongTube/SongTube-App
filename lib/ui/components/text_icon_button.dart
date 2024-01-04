import 'package:flutter/material.dart';
import 'package:songtube/ui/animations/animated_text.dart';
import 'package:songtube/ui/components/custom_inkwell.dart';
import 'package:songtube/ui/text_styles.dart';

class TextIconButton extends StatelessWidget {
  const TextIconButton({
    required this.icon,
    required this.text,
    this.onTap,
    this.selected,
    this.selectedIcon,
    super.key});
  final Icon icon;
  final String text;
  final Function()? onTap;
  final Icon? selectedIcon;
  final bool? selected;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 65,
      height: 65,
      child: CustomInkWell(
        borderRadius: BorderRadius.circular(25),
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: (selected ?? false) ? selectedIcon ?? icon : icon),
            const SizedBox(height: 2),
            Text(text, style: tinyTextStyle(context))
          ],
        ),
      ),
    );
  }
}

class TextIconSlimButton extends StatelessWidget {
  const TextIconSlimButton({
    required this.icon,
    required this.text,
    this.onTap,
    this.selected,
    this.selectedIcon,
    this.backgroundColor,
    this.applyColor = false,
    super.key});
  final Widget icon;
  final String text;
  final Function()? onTap;
  final Icon? selectedIcon;
  final bool? selected;
  final Color? backgroundColor;
  final bool applyColor;
  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: onTap,
      child: AnimatedContainer(
        padding: const EdgeInsets.only(left: 16, right: 16),
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: backgroundColor ?? Theme.of(context).cardColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: (selected ?? false) ? selectedIcon ?? icon : icon),
            const SizedBox(width: 8),
            AnimatedText(text, style: smallTextStyle(context, opacity: 1).copyWith(letterSpacing: 0.2, fontSize: 12), auto: applyColor)
          ],
        ),
      ),
    );
  }
}