import 'package:flutter/material.dart';
import 'package:songtube/ui/internal/scrollDetector.dart';

class AutoHideScaffold extends StatefulWidget {
  final Widget appBar;
  final Widget body;
  final bool resizeToAvoidBottomInset;
  final Color backgroundColor;
  AutoHideScaffold({
    this.appBar,
    @required this.body,
    this.resizeToAvoidBottomInset,
    this.backgroundColor,
    Key key
  }) : super(key: key);

  @override
  AutoHideScaffoldState createState() => AutoHideScaffoldState();
}

class AutoHideScaffoldState extends State<AutoHideScaffold> with TickerProviderStateMixin {

  AnimationController _hideAnimationController;
  bool navigationBarScrolledDown = false;

  @override
  void initState() {
    _hideAnimationController = AnimationController(
      duration: Duration(milliseconds: 250), vsync: this
    );
    _hideAnimationController.animateTo(1, duration: Duration.zero);
    super.initState();
  }

  /// For any implementation of the [floatingWidget] made, you will need
  /// to add a GlobaKey<AutoHideScaffoldState> and use it to update the AppBar/NavBar
  /// position if you need them to hide them (ex: [floatingWidget] is a slidable panel
  /// and you want to hide the appbar and navbar on panel slide)
  void updateInternalController(double position) {
    if (!navigationBarScrolledDown) {
      _hideAnimationController.animateTo((1 - position));
    }
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
      child: ScrollDetector(
        onScrollDown: () {
          _hideAnimationController.reverse();
          navigationBarScrolledDown = true;
        },
        onScrollUp: () {
          _hideAnimationController.forward();
          navigationBarScrolledDown = false;
        },
        child: widget.body
      ),
    );
  }
}