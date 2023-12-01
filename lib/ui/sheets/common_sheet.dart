import 'package:flutter/material.dart';
import 'package:songtube/internal/global.dart';
import 'package:songtube/ui/sheet_phill.dart';

class CommonSheet extends StatelessWidget {
  const CommonSheet({
    required this.builder,
    this.bottomWidget,
    this.useCustomScroll = true,
    this.useInitChildSize = false,
    this.useMaxSize = false,
    Key? key}) : super(key: key);
  final Widget Function(BuildContext context, ScrollController? scrollController) builder;
  final Widget? bottomWidget;
  final bool useCustomScroll;
  final bool useInitChildSize;
  final bool useMaxSize;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Container(
        color: const Color.fromRGBO(0, 0, 0, 0.001),
        padding: const EdgeInsets.all(12).copyWith(bottom: MediaQuery.of(context).padding.bottom+MediaQuery.of(context).viewInsets.bottom+12, top: kToolbarHeight),
        child: GestureDetector(
          onTap: () {},
          child: useCustomScroll ? DraggableScrollableSheet(
            snap: true,
            shouldCloseOnMinExtent: false,
            initialChildSize: useMaxSize ? 0.85 : useInitChildSize ? 0.6 : 0.4,
            minChildSize: useMaxSize ? 0.85 : 0.4,
            maxChildSize: 0.85,
            builder: (context, controller) {
              return content(context, controller);
            },
          ) : content(context, null),
        ),
      ),
    );
  }

  Widget content(BuildContext context, ScrollController? controller) {
    return Flex(
      direction: Axis.vertical,
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Flex(
              mainAxisSize: MainAxisSize.min,
              direction: Axis.vertical,
              children: [
                const SizedBox(height: 16),
                BottomSheetPhill(color: Colors.grey.withOpacity(0.4)),
                const SizedBox(height: 8),
                Flexible(
                  child: Container(
                    child: builder(context, controller))
                ),
              ],
            ),
          ),
        ),
        AnimatedSize(
          duration: kAnimationDuration,
          curve: kAnimationCurve,
          child: AnimatedContainer(
            duration: kAnimationDuration,
            curve: kAnimationCurve,
            margin: EdgeInsets.only(top: bottomWidget != null ? 12 : 0),
            height: bottomWidget != null ? kToolbarHeight*1.4 : 0,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: bottomWidget,
          ),
        )
      ],
    );
  }

}