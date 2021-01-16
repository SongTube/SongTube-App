import 'package:flutter/material.dart';
import 'package:songtube/ui/components/scrollDetector.dart';

class AutoHideScaffold extends StatefulWidget {
  final Widget appBar;
  final Widget body;
  final Widget bottomNavigationBar;
  final bool resizeToAvoidBottomInset;
  final Key key;
  final Color backgroundColor;
  AutoHideScaffold({
    this.appBar,
    @required this.body,
    this.bottomNavigationBar,
    this.resizeToAvoidBottomInset,
    this.backgroundColor,
    this.key
  }) : super(key: key);
  @override
  _AutoHideScaffoldState createState() => _AutoHideScaffoldState();
}

class _AutoHideScaffoldState extends State<AutoHideScaffold> with TickerProviderStateMixin {

  AnimationController _hideAnimationController;

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
          backgroundColor: widget.backgroundColor,
          resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
          appBar: widget.appBar != null ? PreferredSize(
            preferredSize: Size(
              double.infinity,
              kToolbarHeight * _hideAnimationController.value
            ),
            child: widget.appBar,
          ): null,
          body: child,
          bottomNavigationBar: widget.bottomNavigationBar != null ? Container(
            width: double.infinity,
            height: kBottomNavigationBarHeight *
              _hideAnimationController.value,
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: widget.bottomNavigationBar,
            ),
          ) : null,
        );
      },
      child: ScrollDetector(
        onScrollDown: () => _hideAnimationController.reverse(),
        onScrollUp: () => _hideAnimationController.forward(),
        child: widget.body
      ),
    );
  }
}