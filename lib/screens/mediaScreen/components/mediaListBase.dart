// Flutter
import 'package:flutter/material.dart';

class MediaListBase extends StatelessWidget {
  final Widget noPermissionWidget;
  final Widget loadingWidget;
  final Widget baseWidget;
  final bool permissionStatus;
  final bool listStatus;
  MediaListBase({
    @required this.noPermissionWidget,
    @required this.loadingWidget,
    @required this.baseWidget,
    @required this.permissionStatus,
    @required this.listStatus
  });
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 200),
      child: animatedSwitcherChild(),
    );
  }

  Widget animatedSwitcherChild() {
    if (!permissionStatus) {
      return noPermissionWidget;
    } else if (!listStatus) {
      return loadingWidget;
    } else {
      return baseWidget;
    }
  }

}