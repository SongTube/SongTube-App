import 'dart:math';
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

enum FloatingWidgetState{
  OPEN,
  CLOSED
}

class FloatingWidgetTwins {

  final Widget expanded;
  final Widget collapsed;

  FloatingWidgetTwins({
    @required this.expanded,
    @required this.collapsed
  });

}

class FloatingWidgetConfig {

  final bool backdropEnabled;
  final void Function(double position) onSlide;
  final VoidCallback onOpened;
  final VoidCallback onClosed;
  final FloatingWidgetState defaultState;
  final double backdropBlurStrength;
  final Color backdropColor;
  final double backdropOpacity;
  final double maxHeight;
  final double minHeight;
  final bool isPanelVisible;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;

  FloatingWidgetConfig({
    this.backdropEnabled = true,
    this.onSlide,
    this.onOpened,
    this.onClosed,
    this.defaultState = FloatingWidgetState.CLOSED,
    this.backdropBlurStrength = 0,
    this.backdropColor = Colors.black,
    this.backdropOpacity = 0.5,
    this.maxHeight,
    this.minHeight = kToolbarHeight * 1.15,
    this.isPanelVisible = true,
    this.margin = EdgeInsets.zero,
    this.padding
  });

}

class FancyScaffold extends StatefulWidget {

  // Scaffold values
  final Widget appBar;
  final Widget body;
  final Widget bottomNavigationBar;
  final bool resizeToAvoidBottomInset;
  final Color backgroundColor;
  final GlobalKey<ScaffoldState> internalKey;

  // Floating Widget values
  final FloatingWidgetTwins floatingWidgetTwins;
  final FloatingWidgetController floatingWidgetController;
  final FloatingWidgetConfig floatingWidgetConfig;

  FancyScaffold({
    this.appBar,
    @required this.body,
    this.bottomNavigationBar,
    this.floatingWidgetTwins,
    this.resizeToAvoidBottomInset,
    this.backgroundColor,
    this.internalKey,
    this.floatingWidgetConfig,
    this.floatingWidgetController
  });

  @override
  _FancyScaffoldState createState() => _FancyScaffoldState();
}

class _FancyScaffoldState extends State<FancyScaffold> with TickerProviderStateMixin {

  // Navigation bar animation controller
  AnimationController _navigationBarAnimationController;

  // Floating Widget values
  AnimationController _floatingWidgetAnimationController;
  ScrollController _floatingWidgetScrollController;
  VelocityTracker _vt = new VelocityTracker.withKind(PointerDeviceKind.touch);
  bool _scrollingEnabled = false;

  // Configuration
  bool navigationBarScrolledDown = false;

  // Pixels Scrolled
  double pixelsScrolled = 0;

  @override
  void initState() {
    super.initState();

    // Navigation bar animation controller
    _navigationBarAnimationController = AnimationController(
      duration: Duration(milliseconds: 250), vsync: this
    );
    _navigationBarAnimationController.animateTo(1, duration: Duration.zero);

    // Floating widget animation controller
    _floatingWidgetAnimationController = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      value: widget.floatingWidgetConfig.defaultState == FloatingWidgetState.CLOSED ? 0.0 : 1.0
    )..addListener((){

      if(widget.floatingWidgetConfig.onSlide != null)
        widget.floatingWidgetConfig.onSlide(_floatingWidgetAnimationController.value);

      if(widget.floatingWidgetConfig.onOpened != null && _floatingWidgetAnimationController.value == 1.0)
        widget.floatingWidgetConfig.onOpened();

      if(widget.floatingWidgetConfig.onClosed != null && _floatingWidgetAnimationController.value == 0.0)
        widget.floatingWidgetConfig.onClosed();

      // Adjust navigation bar animation controller based on floating widget
      if (!navigationBarScrolledDown)
        _navigationBarAnimationController.value =
          ((1 - _floatingWidgetAnimationController.value));

    });

    // prevent the panel content from being scrolled only if the widget is
    // draggable and panel scrolling is enabled
    _floatingWidgetScrollController = new ScrollController();
    _floatingWidgetScrollController.addListener((){
      if(!_scrollingEnabled)
        _floatingWidgetScrollController.jumpTo(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    widget.floatingWidgetController?._addState(this);
    return AnimatedBuilder(
      animation: _floatingWidgetAnimationController,
      builder: (context, mainChild) {
        return AnimatedBuilder(
          animation: _navigationBarAnimationController,
          builder: (context, child) {
            return Column(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Scaffold(
                        key: widget.internalKey,
                        backgroundColor: widget.backgroundColor,
                        resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
                        appBar: widget.appBar != null ? PreferredSize(
                          preferredSize: Size(
                            double.infinity,
                            kToolbarHeight * _navigationBarAnimationController.value
                          ),
                          child: Container(
                            color: Theme.of(context).cardColor,
                            child: Opacity(
                              opacity: (_navigationBarAnimationController.value - (1 - _navigationBarAnimationController.value)) > 0
                                ? (_navigationBarAnimationController.value - (1 - _navigationBarAnimationController.value)) : 0,
                              child: widget.appBar
                            ),
                          ),
                        ): null,
                        body: child,
                        bottomNavigationBar: widget.bottomNavigationBar != null ? Container(
                          width: double.infinity,
                          color: Colors.transparent,
                          height: (kBottomNavigationBarHeight) *
                            _navigationBarAnimationController.value,
                          child: SingleChildScrollView(
                            physics: NeverScrollableScrollPhysics(),
                            child: Opacity(
                              opacity: (_navigationBarAnimationController.value - (1 - _navigationBarAnimationController.value)) > 0
                                ? (_navigationBarAnimationController.value - (1 - _navigationBarAnimationController.value)) : 0,
                              child: widget.bottomNavigationBar)
                          ),
                        ) : null,
                      ),
                      AnimatedSwitcher(
                        duration: Duration(milliseconds: 300),
                        child: widget.floatingWidgetTwins != null
                          ? Padding(
                              padding: EdgeInsets.only(
                                bottom: kBottomNavigationBarHeight *
                                  _navigationBarAnimationController.value
                              ),
                              child: Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  _backdropWidget(),
                                  _actualSlidingPanel()
                                ],
                              )
                          ) : Container()
                      )
                    ],
                  ),
                ),
                Container(
                  height: (MediaQuery.of(context).padding.bottom * (widget.floatingWidgetTwins != null
                    ? (1-_floatingWidgetAnimationController.value) : 1)) * (1-_floatingWidgetAnimationController.value),
                  color: Theme.of(context).cardColor
                )
              ],
            );
          },
          child: Listener(
            onPointerUp: (_) {
              pixelsScrolled = 0;
              if (_navigationBarAnimationController.value > 0.5) {
                _navigationBarAnimationController.animateTo(1);
                navigationBarScrolledDown = false;
              } else {
                _navigationBarAnimationController.animateTo(0);
                navigationBarScrolledDown = true;
              }
            },
            child: NotificationListener<ScrollUpdateNotification>(
              onNotification: (ScrollUpdateNotification details) {
                pixelsScrolled = (pixelsScrolled + details.scrollDelta.abs()).clamp(0, 100)/100;
                if (details.scrollDelta > 0.0 && details.metrics.axis == Axis.vertical) {
                  _navigationBarAnimationController.value -= pixelsScrolled;
                } else {
                  _navigationBarAnimationController.value += pixelsScrolled;
                }
                return false;
              },
              child: mainChild,
            ),
          ),
        );
      },
      child: widget.body,
    );
  }

  Widget _actualSlidingPanel() {
    return !widget.floatingWidgetConfig.isPanelVisible ? Container() : _gestureHandler(
      child: AnimatedBuilder(
        animation: _floatingWidgetAnimationController,
        builder: (context, child) {
          return Container(
            height: _floatingWidgetAnimationController.value *
              (widget.floatingWidgetConfig.maxHeight -
              widget.floatingWidgetConfig.minHeight) +
              widget.floatingWidgetConfig.minHeight,
            margin: widget.floatingWidgetConfig.margin *
              (1 - _floatingWidgetAnimationController.value),
            padding: widget.floatingWidgetConfig.padding,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: 5,
                  offset: Offset(0,-5),
                  color: Colors.black.withOpacity(0.05)
                )
              ],
              borderRadius: _floatingWidgetAnimationController.value == 1
                ? BorderRadius.zero
                : BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
              color: Colors.transparent
            ),
            child: child 
          );
        },
        child: Stack(
          children: <Widget>[
            // Expanded Panel
            AnimatedBuilder(
              animation: _floatingWidgetAnimationController,
              builder: (context, child) {
                return ClipRRect(
                  borderRadius: _floatingWidgetAnimationController.value == 1
                    ? BorderRadius.zero
                    : BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                  child: Container(
                    height: (widget.floatingWidgetConfig.maxHeight *
                      _floatingWidgetAnimationController.value) +
                      (widget.floatingWidgetConfig.minHeight *
                      (1 - _floatingWidgetAnimationController.value)),
                    width:  MediaQuery.of(context).size.width -
                      (widget.floatingWidgetConfig.margin.horizontal *
                      (1 - _floatingWidgetAnimationController.value)),
                    child: child
                  ),
                );
              },
              child: widget.floatingWidgetTwins.expanded
            ),
            // Collapsed Panel
            AnimatedBuilder(
              animation: _floatingWidgetAnimationController,
              builder: (context, child) {
                return Opacity(
                  opacity: (( 1 - _floatingWidgetAnimationController.value) - _floatingWidgetAnimationController.value) > 0
                    ? (( 1 - _floatingWidgetAnimationController.value) - _floatingWidgetAnimationController.value) : 0,
                  child: _floatingWidgetAnimationController.value == 1
                    ? Container()
                    : child,
                );
              },
              child: Container(
                color: Colors.transparent,
                height: widget.floatingWidgetConfig.minHeight,
                child: widget.floatingWidgetTwins.collapsed
              )
            ),
          ],
        ),
      ),
    );
  }

  Widget _backdropWidget() {
    return !widget.floatingWidgetConfig.backdropEnabled ? Container() : AnimatedBuilder(
      animation: _floatingWidgetAnimationController,
      builder: (context, _) {
        if (widget.floatingWidgetConfig.backdropBlurStrength != 0) {
          return BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: _floatingWidgetAnimationController.value *
                widget.floatingWidgetConfig.backdropBlurStrength,
              sigmaY: _floatingWidgetAnimationController.value *
                widget.floatingWidgetConfig.backdropBlurStrength
            ),
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,

              //set color to null so that touch events pass through
              //to the body when the panel is closed, otherwise,
              //if a color exists, then touch events won't go through
              color: _floatingWidgetAnimationController.value == 0.0 ? null
                : widget.floatingWidgetConfig.backdropColor.withOpacity(
                    widget.floatingWidgetConfig.backdropOpacity *
                    _floatingWidgetAnimationController.value),
            ),
          );
        } else {
          return Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,

            //set color to null so that touch events pass through
            //to the body when the panel is closed, otherwise,
            //if a color exists, then touch events won't go through
            color: _floatingWidgetAnimationController.value == 0.0 ? null
              : widget.floatingWidgetConfig.backdropColor.withOpacity(
                  widget.floatingWidgetConfig.backdropOpacity *
                  _floatingWidgetAnimationController.value),
          );
        }
      }
    );
  }

  // returns a gesture detector if panel is used
  // and a listener if panelBuilder is used.
  // this is because the listener is designed only for use with linking the scrolling of
  // panels and using it for panels that don't want to linked scrolling yields odd results
  Widget _gestureHandler({Widget child}){
    if (widget.floatingWidgetTwins != null){
      return GestureDetector(
        onVerticalDragUpdate: (DragUpdateDetails dets) => _onGestureSlide(dets.delta.dy),
        onVerticalDragEnd: (DragEndDetails dets) => _onGestureEnd(dets.velocity),
        child: child,
      );
    }

    return Listener(
      onPointerDown: (PointerDownEvent p) => _vt.addPosition(p.timeStamp, p.position),
      onPointerMove: (PointerMoveEvent p){
        _vt.addPosition(p.timeStamp, p.position); // add current position for velocity tracking
        _onGestureSlide(p.delta.dy);
      },
      onPointerUp: (PointerUpEvent p) => _onGestureEnd(_vt.getVelocity()),
      child: child,
    );
  }

  // handles the sliding gesture
  void _onGestureSlide(double dy){

    // only slide the panel if scrolling is not enabled
    if(!_scrollingEnabled){
      _floatingWidgetAnimationController.value -= dy /
        (widget.floatingWidgetConfig.maxHeight - widget.floatingWidgetConfig.minHeight);
    }

    // if the panel is open and the user hasn't scrolled, we need to determine
    // whether to enable scrolling if the user swipes up, or disable closing and
    // begin to close the panel if the user swipes down
    if (
      _isPanelOpen && _floatingWidgetScrollController.hasClients &&
      _floatingWidgetScrollController.offset <= 0
    ) {
      setState(() {
        if (dy < 0) {
          _scrollingEnabled = true;
        } else 
          _scrollingEnabled = false;
        }
      );
    }
  }

  // handles when user stops sliding
  void _onGestureEnd(Velocity v){
    double minFlingVelocity = 365.0;

    //let the current animation finish before starting a new one
    if(_floatingWidgetAnimationController.isAnimating) return;

    // if scrolling is allowed and the panel is open, we don't want to close
    // the panel if they swipe up on the scrollable
    if(_isPanelOpen && _scrollingEnabled) return;

    //check if the velocity is sufficient to constitute fling to end
    double visualVelocity = -v.pixelsPerSecond.dy /
      (widget.floatingWidgetConfig.maxHeight - widget.floatingWidgetConfig.minHeight);

    // get minimum distances to figure out where the panel is at
    double d2Close = _floatingWidgetAnimationController.value;
    double d2Open = 1 - _floatingWidgetAnimationController.value;
    double d2Snap = (3 -_floatingWidgetAnimationController.value).abs(); // large value if null results in not every being the min
    double minDistance = min(d2Close, min(d2Snap, d2Open));

    // check if velocity is sufficient for a fling
    if(v.pixelsPerSecond.dy.abs() >= minFlingVelocity){
      _floatingWidgetAnimationController.fling(velocity: visualVelocity);
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
      _floatingWidgetAnimationController.value,
      targetPos,
      velocity
    );

    _floatingWidgetAnimationController.animateWith(simulation);
  }

  //---------------------------------
  //PanelController related functions
  //---------------------------------

  //close the panel
  Future<void> _close(){
    return _floatingWidgetAnimationController.fling(velocity: -1.0);
  }

  //open the panel
  Future<void> _open(){
    return _floatingWidgetAnimationController.fling(velocity: 1.0);
  }

  //animate the panel position to value - must
  //be between 0.0 and 1.0
  Future<void> _animatePanelToPosition(double value, {Duration duration, Curve curve = Curves.linear}){
    assert(0.0 <= value && value <= 1.0);
    return _floatingWidgetAnimationController.animateTo(value, duration: duration, curve: curve);
  }

  //set the panel position to value - must
  //be between 0.0 and 1.0
  set _panelPosition(double value){
    assert(0.0 <= value && value <= 1.0);
    _floatingWidgetAnimationController.value = value;
  }

  //get the current panel position
  //returns the % offset from collapsed state
  //as a decimal between 0.0 and 1.0
  double get _panelPosition => _floatingWidgetAnimationController.value;

  //returns whether or not
  //the panel is still animating
  bool get _isPanelAnimating => _floatingWidgetAnimationController.isAnimating;

  //returns whether or not the
  //panel is open
  bool get _isPanelOpen => _floatingWidgetAnimationController.value == 1.0;

  //returns whether or not the
  //panel is closed
  bool get _isPanelClosed => _floatingWidgetAnimationController.value == 0.0;

}

class FloatingWidgetController{
  _FancyScaffoldState _scaffoldState;

  void _addState(_FancyScaffoldState panelState){
    this._scaffoldState = panelState;
  }

  /// Determine if the panelController is attached to an instance
  /// of the SlidingUpPanel (this property must return true before any other
  /// functions can be used)
  bool get isAttached => _scaffoldState != null;

  /// Closes the sliding panel to its collapsed state (i.e. to the  minHeight)
  Future<void> close(){
    assert(isAttached, "PanelController must be attached to a SlidingUpPanel");
    return _scaffoldState._close();
  }

  /// Opens the sliding panel fully
  /// (i.e. to the maxHeight)
  Future<void> open(){
    assert(isAttached, "PanelController must be attached to a SlidingUpPanel");
    return _scaffoldState._open();
  }

  /// Animates the panel position to the value.
  /// The value must between 0.0 and 1.0
  /// where 0.0 is fully collapsed and 1.0 is completely open.
  /// (optional) duration specifies the time for the animation to complete
  /// (optional) curve specifies the easing behavior of the animation.
  Future<void> animatePanelToPosition(double value, {Duration duration, Curve curve = Curves.linear}){
    assert(isAttached, "PanelController must be attached to a SlidingUpPanel");
    assert(0.0 <= value && value <= 1.0);
    return _scaffoldState._animatePanelToPosition(value, duration: duration, curve: curve);
  }

  /// Sets the panel position (without animation).
  /// The value must between 0.0 and 1.0
  /// where 0.0 is fully collapsed and 1.0 is completely open.
  set panelPosition(double value){
    assert(isAttached, "PanelController must be attached to a SlidingUpPanel");
    assert(0.0 <= value && value <= 1.0);
    _scaffoldState._panelPosition = value;
  }

  /// Gets the current panel position.
  /// Returns the % offset from collapsed state
  /// to the open state
  /// as a decimal between 0.0 and 1.0
  /// where 0.0 is fully collapsed and
  /// 1.0 is full open.
  double get panelPosition{
    assert(isAttached, "PanelController must be attached to a SlidingUpPanel");
    return _scaffoldState._panelPosition;
  }

  /// Returns whether or not the panel is
  /// currently animating.
  bool get isPanelAnimating{
    assert(isAttached, "PanelController must be attached to a SlidingUpPanel");
    return _scaffoldState._isPanelAnimating;
  }

  /// Returns whether or not the
  /// panel is open.
  bool get isPanelOpen{
    assert(isAttached, "PanelController must be attached to a SlidingUpPanel");
    return _scaffoldState._isPanelOpen;
  }

  /// Returns whether or not the
  /// panel is closed.
  bool get isPanelClosed{
    assert(isAttached, "PanelController must be attached to a SlidingUpPanel");
    return _scaffoldState._isPanelClosed;
  }

}