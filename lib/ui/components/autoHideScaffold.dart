import 'package:flutter/material.dart';

class AutoHideScaffold extends StatefulWidget {
  final Widget? appBar;
  final Widget body;
  final bool? resizeToAvoidBottomInset;
  final Color? backgroundColor;
  AutoHideScaffold({
    this.appBar,
    required this.body,
    this.resizeToAvoidBottomInset,
    this.backgroundColor,
    Key? key
  }) : super(key: key);

  @override
  _AutoHideScaffoldState createState() => _AutoHideScaffoldState();
}

class _AutoHideScaffoldState extends State<AutoHideScaffold> with TickerProviderStateMixin {

  late AnimationController _hideAnimationController;
  bool navigationBarScrolledDown = false;

  // Pixels Scrolled
  double pixelsScrolled = 0;

  @override
  void initState() {
    _hideAnimationController = AnimationController(
      duration: Duration(milliseconds: 250), vsync: this
    );
    _hideAnimationController.animateTo(1, duration: Duration.zero);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _hideAnimationController,
      builder: (context, child) {
        return Scaffold(
          key: widget.key,
          backgroundColor: widget.backgroundColor,
          resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
          appBar: widget.appBar != null ? PreferredSize(
            preferredSize: Size(
              double.infinity,
              kToolbarHeight * _hideAnimationController.value
            ),
            child: Container(
              color: Theme.of(context).cardColor,
              child: Opacity(
                opacity: (_hideAnimationController.value - (1 - _hideAnimationController.value)) > 0
                  ? (_hideAnimationController.value - (1 - _hideAnimationController.value)) : 0,
                child: widget.appBar
              ),
            ),
          ): null,
          body: child,
        );
      },
      child: Listener(
        onPointerUp: (_) {
          pixelsScrolled = 0;
          if (_hideAnimationController.value > 0.5) {
            _hideAnimationController.animateTo(1);
            navigationBarScrolledDown = false;
          } else {
            _hideAnimationController.animateTo(0);
            navigationBarScrolledDown = true;
          }
        },
        child: NotificationListener<ScrollUpdateNotification>(
          onNotification: (ScrollUpdateNotification details) {
            pixelsScrolled = (pixelsScrolled + details.scrollDelta!.abs()).clamp(0, 100)/100;
            if (details.scrollDelta! > 0.0 && details.metrics.axis == Axis.vertical) {
              _hideAnimationController.value -= pixelsScrolled;
            } else {
              _hideAnimationController.value += pixelsScrolled;
            }
            return false;
          },
          child: widget.body
        ),
      ),
    );
  }
}