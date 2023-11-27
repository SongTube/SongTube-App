import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:songtube/ui/animations/animated_icon.dart';
import 'package:songtube/ui/text_styles.dart';

class CommonSheetWidget extends StatefulWidget {
  const CommonSheetWidget({
    required this.title,
    required this.body,
    this.actions = const [],
    Key? key}) : super(key: key);
  final String title;
  final Widget body;
  final List<Widget> actions;
  @override
  State<CommonSheetWidget> createState() => _CommonSheetWidgetState();
}

class _CommonSheetWidgetState extends State<CommonSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20)
      ),
      padding: const EdgeInsets.all(12).copyWith(top: 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const AppAnimatedIcon(Iconsax.arrow_left, size: 22)
              ),
              const SizedBox(width: 12),
              Expanded(child: Text(widget.title, style: textStyle(context, bold: false))),
            ],
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: widget.body,
          ),
          if (widget.actions.isNotEmpty)
          const SizedBox(height: 8),
          if (widget.actions.isNotEmpty)
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: widget.actions,
            ),
          ),
        ],
      ),
    );
  }
}