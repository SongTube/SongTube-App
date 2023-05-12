import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

class SlidablePanel extends StatefulWidget {
  const SlidablePanel({
    this.initialState = SlidablePanelStatus.closed,
    required this.maxHeight,
    this.enableBackdrop = false,
    required this.child,
    this.backdropColor = Colors.black,
    this.backdropOpacity = 0.3,
    this.borderRadius = BorderRadius.zero,
    this.color,
    this.padding = 8,
    this.animatePadding = false,
    this.collapsedColor,
    required this.onControllerCreate,
    super.key});
  final SlidablePanelStatus initialState;
  final double maxHeight;
  final bool enableBackdrop;
  final Widget child;
  final Color backdropColor;
  final double backdropOpacity;
  final BorderRadiusGeometry borderRadius;
  final Color? color;
  final double padding;
  final bool animatePadding;
  final Color? collapsedColor;
  final Function(SlidablePanelController) onControllerCreate;
  @override
  State<SlidablePanel> createState() => SlidablePanelState();
}

class SlidablePanelState extends State<SlidablePanel> with TickerProviderStateMixin {

  // Panel Controller
  SlidablePanelController controller = SlidablePanelController();

  // Floating Widget values
  late final animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 600),
    value: widget.initialState == SlidablePanelStatus.closed ? 0.0 : 1.0
  );

  // Scroll Controller
  final _floatingWidgetScrollController = ScrollController();

  // Minimum Panel Size
  double minHeight = kToolbarHeight*1.5;

  @override
  void initState() {
    controller._addState(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    widget.onControllerCreate(controller);
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        _backdropWidget(),
        Builder(
          builder: (context) {
            return _actualSlidingPanel();
          }
        )
      ],
    );
  }

  Widget _actualSlidingPanel() {
    return _gestureHandler(
      child: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              color: widget.collapsedColor != null
                ? ColorTween(begin: widget.collapsedColor, end: widget.color ?? Theme.of(context).cardColor).animate(animationController).value
                : widget.color ?? Theme.of(context).cardColor,
              borderRadius: widget.borderRadius
            ),
            margin: widget.animatePadding
              ? EdgeInsets.all((1 - animationController.value) * widget.padding)
              : EdgeInsets.all(widget.padding),
            child: SizedBox(
              width: double.infinity,
              height: (widget.maxHeight *
                animationController.value) +
                (minHeight * (1 - animationController.value)),
              child: child
            ),
          );
        },
        child: widget.child,
      ),
    );
  }

  Widget _backdropWidget() {
    return !widget.enableBackdrop ? Container() : AnimatedBuilder(
      animation: animationController,
      builder: (context, _) {
        return Container(
          height: widget.maxHeight,
          width: MediaQuery.of(context).size.width,
          //set color to null so that touch events pass through
          //to the body when the panel is closed, otherwise,
          //if a color exists, then touch events won't go through
          color: animationController.value == 0.0 ? null
            : widget.backdropColor.withOpacity(
                widget.backdropOpacity *
                animationController.value),
        );
      }
    );
  }

  // returns a gesture detector if panel is used
  // and a listener if panelBuilder is used.
  // this is because the listener is designed only for use with linking the scrolling of
  // panels and using it for panels that don't want to linked scrolling yields odd results
  Widget _gestureHandler({required Widget child}){
    return GestureDetector(
      onVerticalDragUpdate: (DragUpdateDetails dets) => _onGestureSlide(dets.delta.dy),
      onVerticalDragEnd: (DragEndDetails dets) => _onGestureEnd(dets.velocity),
      child: child,
    );
  }

  // handles the sliding gesture
  void _onGestureSlide(double dy){

    // only slide the panel if scrolling is not enabled
    animationController.value -= dy /
      ((widget.maxHeight) - minHeight);

    // if the panel is open and the user hasn't scrolled, we need to determine
    // whether to enable scrolling if the user swipes up, or disable closing and
    // begin to close the panel if the user swipes down
    if (
      _isPanelOpen && _floatingWidgetScrollController.hasClients &&
      _floatingWidgetScrollController.offset <= 0
    ) {
      setState(() {});
    }
  }

  // handles when user stops sliding
  void _onGestureEnd(Velocity v){
    double minFlingVelocity = 365.0;

    //let the current animation finish before starting a new one
    if(animationController.isAnimating) return;

    // if scrolling is allowed and the panel is open, we don't want to close
    // the panel if they swipe up on the scrollable
    if(_isPanelOpen) return;

    //check if the velocity is sufficient to constitute fling to end
    double visualVelocity = -v.pixelsPerSecond.dy /
      ((widget.maxHeight) - minHeight);

    // get minimum distances to figure out where the panel is at
    double d2Close = animationController.value;
    double d2Open = 1 - animationController.value;
    double d2Snap = (3 -animationController.value).abs(); // large value if null results in not every being the min
    double minDistance = min(d2Close, min(d2Snap, d2Open));

    // check if velocity is sufficient for a fling
    if(v.pixelsPerSecond.dy.abs() >= minFlingVelocity){
      animationController.fling(velocity: visualVelocity);
      return;
    }

    // check if the controller is already halfway there
    if (minDistance == d2Close) {
      _close();
    } else if (minDistance == d2Snap) {
      _flingPanelToPosition(0.4, visualVelocity);
    } else {
      _open();
    }
  }

  void _flingPanelToPosition(double targetPos, double velocity){
    final Simulation simulation = SpringSimulation(
      SpringDescription.withDampingRatio(
        mass: 1.0,
        stiffness: 500.0,
        ratio: 1.0,
      ),
      animationController.value,
      targetPos,
      velocity
    );

    animationController.animateWith(simulation);
  }

  //---------------------------------
  //PanelController related functions
  //---------------------------------

  //close the panel
  Future<void> _close(){
    return animationController.fling(velocity: -1.0);
  }

  //open the panel
  Future<void> _open(){
    return animationController.fling(velocity: 1.0);
  }

  //animate the panel position to value - must
  //be between 0.0 and 1.0
  Future<void> _animatePanelToPosition(double value, {Duration duration = const Duration(milliseconds: 200), Curve curve = Curves.linear}){
    assert(0.0 <= value && value <= 1.0);
    return animationController.animateTo(value, duration: duration, curve: curve);
  }

  //set the panel position to value - must
  //be between 0.0 and 1.0
  set _panelPosition(double value){
    assert(0.0 <= value && value <= 1.0);
    animationController.value = value;
  }

  //get the current panel position
  //returns the % offset from collapsed state
  //as a decimal between 0.0 and 1.0
  double get _panelPosition => animationController.value;

  //returns whether or not
  //the panel is still animating
  bool get _isPanelAnimating => animationController.isAnimating;

  //returns whether or not the
  //panel is open
  bool get _isPanelOpen => animationController.value == 1.0;

  //returns whether or not the
  //panel is closed
  bool get _isPanelClosed => animationController.value == 0.0;

}

class SlidablePanelController{
  SlidablePanelState? _state;

  void _addState(SlidablePanelState panelState){
    _state = panelState;
  }

  // Determine if we have to listen for scrolling notifications to turn up/down
  // the floating widget based on the navigation bar visibility
  bool lockNotificationListener = false;

  /// Determine if the panelController is attached to an instance
  /// of the SlidingUpPanel (this property must return true before any other
  /// functions can be used)
  bool get isAttached => _state != null;

  AnimationController get animationController => _state!.animationController;

  /// Closes the sliding panel to its collapsed state (i.e. to the  minHeight)
  Future<void> close(){
    assert(isAttached, "PanelController must be attached to a SlidingUpPanel");
    return _state!._close();
  }

  /// Opens the sliding panel fully
  /// (i.e. to the maxHeight)
  Future<void> open(){
    assert(isAttached, "PanelController must be attached to a SlidingUpPanel");
    return _state!._open();
  }

  /// Animates the panel position to the value.
  /// The value must between 0.0 and 1.0
  /// where 0.0 is fully collapsed and 1.0 is completely open.
  /// (optional) duration specifies the time for the animation to complete
  /// (optional) curve specifies the easing behavior of the animation.
  Future<void> animatePanelToPosition(double value, {Duration duration = const Duration(milliseconds: 200), Curve curve = Curves.linear}){
    assert(isAttached, "PanelController must be attached to a SlidingUpPanel");
    assert(0.0 <= value && value <= 1.0);
    return _state!._animatePanelToPosition(value, duration: duration, curve: curve);
  }

  /// Sets the panel position (without animation).
  /// The value must between 0.0 and 1.0
  /// where 0.0 is fully collapsed and 1.0 is completely open.
  set panelPosition(double value){
    assert(isAttached, "PanelController must be attached to a SlidingUpPanel");
    assert(0.0 <= value && value <= 1.0);
    _state!._panelPosition = value;
  }

  /// Gets the current panel position.
  /// Returns the % offset from collapsed state
  /// to the open state
  /// as a decimal between 0.0 and 1.0
  /// where 0.0 is fully collapsed and
  /// 1.0 is full open.
  double get panelPosition{
    assert(isAttached, "PanelController must be attached to a SlidingUpPanel");
    return _state!._panelPosition;
  }

  /// Returns whether or not the panel is
  /// currently animating.
  bool get isPanelAnimating{
    assert(isAttached, "PanelController must be attached to a SlidingUpPanel");
    return _state!._isPanelAnimating;
  }

  /// Returns whether or not the
  /// panel is open.
  bool get isPanelOpen{
    assert(isAttached, "PanelController must be attached to a SlidingUpPanel");
    return _state!._isPanelOpen;
  }

  /// Returns whether or not the
  /// panel is closed.
  bool get isPanelClosed{
    assert(isAttached, "PanelController must be attached to a SlidingUpPanel");
    return _state!._isPanelClosed;
  }

}

enum SlidablePanelStatus { open, closed }