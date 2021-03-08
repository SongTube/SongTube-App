import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:songtube/provider/preferencesProvider.dart';

typedef FloatingWidgetCallback = void Function(double position);

class SlidablePanelBase extends StatefulWidget {
  final FloatingWidgetCallback callback;
  final PanelController controller;
  final Widget collapsedPanel;
  final Widget expandedPanel;
  final Function onPanelClosed;
  final Function onPanelOpened;
  final Color backdropColor;
  final Function(double) onPanelSlide;
  final bool openOnInitState;
  SlidablePanelBase({
    @required this.callback,
    @required this.controller,
    @required this.collapsedPanel,
    @required this.expandedPanel,
    this.onPanelClosed,
    this.onPanelOpened,
    this.backdropColor,
    this.onPanelSlide,
    this.openOnInitState = false
  });
  @override
  _SlidablePanelBaseState createState() => _SlidablePanelBaseState();
}

class _SlidablePanelBaseState extends State<SlidablePanelBase> {

  @override
  void initState() {
    super.initState();
    if (widget.openOnInitState) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        widget.controller.open();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    PreferencesProvider prefs = Provider.of<PreferencesProvider>(context);
    var borderRadius = 10.0;
    return SlidingUpPanel(
      controller: widget.controller,
      minHeight: kToolbarHeight * 1.15,
      maxHeight: MediaQuery.of(context).size.height,
      isPanelVisible: true,
      margin: EdgeInsets.only(
        left: 12, right: 12,
        bottom: 12
      ),
      backdropColor: Colors.black,
      backdropEnabled: true,
      borderRadius: borderRadius,
      backdropBlurStrength: prefs.enableBlurUI ? 15 : 0,
      onPanelSlide: widget.onPanelSlide,
      boxShadow: [
        BoxShadow(
          blurRadius: 5,
          offset: Offset(0,-5),
          color: Colors.black.withOpacity(0.05)
        )
      ],
      color: Theme.of(context).cardColor,
      onPanelClosed: widget.onPanelClosed,
      onPanelOpened: widget.onPanelOpened,
      panel: widget.expandedPanel,
      collapsed: GestureDetector(
        onTap: () {
          widget.controller.open();
        },
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(10)
          ),
          child: widget.collapsedPanel,
        )
      ),
    );
  }
}