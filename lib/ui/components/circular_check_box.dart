import 'package:flutter/material.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

class CircularCheckbox extends StatelessWidget {
  const CircularCheckbox({
    required this.value,
    required this.onChange,
    super.key});
  final bool value;
  final Function(bool)? onChange;
  @override
  Widget build(BuildContext context) {
    return RoundCheckBox(
      size: 24,
      isRound: true,
      checkedColor: Theme.of(context).primaryColor,
      checkedWidget: const Icon(Icons.check, size: 14, color: Colors.white),
      borderColor: Theme.of(context).dividerColor,
      border: Border.all(width: 0.5, color: Theme.of(context).dividerColor),
      isChecked: value,
      disabledColor: Colors.transparent,
      onTap: onChange != null ? (e) {
        onChange!(e!);
      } : null,
    );
  }
}