import 'package:songtube/ui/sheet_phill.dart';
import 'package:songtube/ui/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class CommonSheet extends StatefulWidget {
  const CommonSheet({
    required this.title,
    required this.body,
    this.actions = const [],
    Key? key}) : super(key: key);
  final String title;
  final Widget body;
  final List<Widget> actions;
  @override
  State<CommonSheet> createState() => _CommonSheetState();
}

class _CommonSheetState extends State<CommonSheet> {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20)
      ),
      margin: const EdgeInsets.all(12).copyWith(bottom: MediaQuery.of(context).viewInsets.bottom+12),
      padding: const EdgeInsets.all(16).copyWith(left: 16, right: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Align(
            alignment: Alignment.center,
            child: BottomSheetPhill()),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Icon(Ionicons.arrow_back_outline, color: Theme.of(context).primaryColor),
                  )
                ),
                Expanded(child: Text(widget.title, style: textStyle(context))),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Divider(indent: 12, endIndent: 12, color: Theme.of(context).dividerColor),
          const SizedBox(height: 8),
          widget.body,
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