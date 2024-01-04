import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:songtube/ui/animations/fade_in.dart';

class CustomScrollbar extends StatefulWidget {
  const CustomScrollbar({
    required this.list,
    required this.scrollController,
    this.bottomPadding = 0,
    this.labelTextBuilder,
    super.key});
  final BoxScrollView list;
  final ScrollController? scrollController;
  final double bottomPadding;
  final Text Function(double)? labelTextBuilder;
  @override
  State<CustomScrollbar> createState() => _CustomScrollbarState();
}

class _CustomScrollbarState extends State<CustomScrollbar> {

  // Scroll Controller
  late ScrollController scrollController = widget.scrollController ?? ScrollController();

  // Calibrate our Scrollbar position in case our list is updated
  void _calibrateScrollbarPosition() {
    final double offset = scrollController.offset;
    scrollController.jumpTo(0.0);
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
    scrollController.jumpTo(offset);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _calibrateScrollbarPosition();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollbar(
      padding: EdgeInsets.only(bottom: widget.bottomPadding),
      scrollbarTimeToFade: const Duration(seconds: 2),
      heightScrollThumb: 72,
      controller: scrollController,
      backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.6),
      scrollThumbBuilder: (backgroundColor, thumbAnimation, labelAnimation, height, {labelConstraints, labelText}) {
        return FadeTransition(
          opacity: thumbAnimation,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (labelText != null)
              FadeInTransition(
                child: Container(
                  height: 56, width: 56,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(16)
                  ),
                  child: Center(child: labelText)
                ),
              ),
              Container(
                color: Colors.transparent,
                width: 20,
                child: Container(
                  height: height,
                  width: 4,
                  margin: const EdgeInsets.only(left: 16),
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(100)
                  ),
                ),
              ),
            ],
          ),
        );
      },
      labelTextBuilder: widget.labelTextBuilder,
      child: widget.list
    );
  }
}