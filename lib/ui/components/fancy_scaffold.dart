import 'dart:math';
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:songtube/internal/global.dart';
import 'package:songtube/providers/app_settings.dart';
import 'package:songtube/providers/content_provider.dart';
import 'package:songtube/providers/ui_provider.dart';
import 'package:songtube/ui/animations/show_up.dart';
import 'package:uuid/uuid.dart';

enum FloatingWidgetState { open, closed }

class FloatingWidgetConfig {
  final bool backdropEnabled;
  final void Function(double position)? onSlide;
  final VoidCallback? onOpened;
  final VoidCallback? onClosed;
  final FloatingWidgetState defaultState;
  final Color backdropColor;
  final double backdropOpacity;
  final double? maxHeight;
  final double minHeight;
  final bool isPanelVisible;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final bool enableGlobalPlayer;

  const FloatingWidgetConfig(
      {this.backdropEnabled = true,
      this.onSlide,
      this.onOpened,
      this.onClosed,
      this.defaultState = FloatingWidgetState.closed,
      this.backdropColor = Colors.black,
      this.backdropOpacity = 0.5,
      this.maxHeight,
      this.minHeight = kToolbarHeight * 1.6,
      this.isPanelVisible = true,
      this.margin = EdgeInsets.zero,
      this.padding = const EdgeInsets.all(4),
      this.enableGlobalPlayer = false});
}

class FancyScaffold extends StatefulWidget {
  // Scaffold values
  final Widget body;
  final Widget? bottomNavigationBar;
  final bool? resizeToAvoidBottomInset;
  final Color? backgroundColor;

  // Floating Widget values
  final Widget? musicFloatingWidget;
  final Widget? videoFloatingWidget;
  final FloatingWidgetController? floatingWidgetController;
  final FloatingWidgetConfig floatingWidgetConfig;

  const FancyScaffold(
      {required this.body,
      this.bottomNavigationBar,
      this.musicFloatingWidget,
      this.videoFloatingWidget,
      this.resizeToAvoidBottomInset,
      this.backgroundColor,
      this.floatingWidgetConfig = const FloatingWidgetConfig(),
      this.floatingWidgetController,
      Key? key})
      : super(key: key);

  @override
  FancyScaffoldState createState() => FancyScaffoldState();
}

class FancyScaffoldState extends State<FancyScaffold>
    with TickerProviderStateMixin {
  // Navigation bar animation controller
  late final navigationBarAnimationController = AnimationController(
      duration: const Duration(milliseconds: 250), vsync: this, value: 1);

  // Floating Widget values
  late final floatingWidgetAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
      value:
          widget.floatingWidgetConfig.defaultState == FloatingWidgetState.closed
              ? 0.0
              : 1.0);

  // Scroll Controller
  final _floatingWidgetScrollController = ScrollController();
  final _vt = VelocityTracker.withKind(PointerDeviceKind.touch);
  bool _scrollingEnabled = false;

  // Configuration
  bool navigationBarScrolledDown = false;

  // Pixels Scrolled
  double pixelsScrolled = 0;

  // Floating player dismiss unique ID
  Key dismissKey = ValueKey(const Uuid().v4());

  @override
  void initState() {
    super.initState();
    // Floating widget animation controller
    floatingWidgetAnimationController.addListener(() {
      if (widget.floatingWidgetConfig.onSlide != null) {
        widget.floatingWidgetConfig
            .onSlide!(floatingWidgetAnimationController.value);
      }

      if (widget.floatingWidgetConfig.onOpened != null &&
          floatingWidgetAnimationController.value == 1.0) {
        widget.floatingWidgetConfig.onOpened!();
      }

      if (widget.floatingWidgetConfig.onClosed != null &&
          floatingWidgetAnimationController.value == 0.0) {
        widget.floatingWidgetConfig.onClosed!();
      }

      // Adjust navigation bar animation controller based on floating widget
      if (!navigationBarScrolledDown) {
        navigationBarAnimationController.value =
            ((1 - floatingWidgetAnimationController.value));
      }
    });

    // prevent the panel content from being scrolled only if the widget is
    // draggable and panel scrolling is enabled
    _floatingWidgetScrollController.addListener(() {
      if (!_scrollingEnabled) {
        _floatingWidgetScrollController.jumpTo(0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    widget.floatingWidgetController?._addState(this);
    final systemBottomPadding = ((deviceInfo.version.sdkInt ?? 28) >= 29
        ? MediaQuery.of(context).padding.bottom
        : 0);
    return AnimatedBuilder(
      animation: floatingWidgetAnimationController,
      builder: (context, mainChild) {
        return AnimatedBuilder(
          animation: navigationBarAnimationController,
          builder: (context, child) {
            return Stack(
              children: [
                Scaffold(
                  backgroundColor: widget.backgroundColor,
                  resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
                  body: widget.floatingWidgetConfig.enableGlobalPlayer
                      ? WillPopScope(
                          onWillPop: () async {
                            if (widget.floatingWidgetController!.navigatorKey
                                    .currentState
                                    ?.canPop() ??
                                false) {
                              widget.floatingWidgetController!.navigatorKey
                                  .currentState!
                                  .pop();
                              return false;
                            }
                            return true;
                          },
                          child: Navigator(
                            key: widget.floatingWidgetController!.navigatorKey,
                            onGenerateRoute: (RouteSettings settings) {
                              return MaterialPageRoute(
                                builder: (BuildContext context) => child!,
                                settings: settings,
                              );
                            },
                          ),
                        )
                      : child!,
                  bottomNavigationBar: widget.bottomNavigationBar != null
                      ? Container(
                          width: double.infinity,
                          color: Colors.transparent,
                          height:
                              (80 * navigationBarAnimationController.value) +
                                  systemBottomPadding,
                          child: Column(
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    child: widget.bottomNavigationBar),
                              ),
                              Container(
                                height: systemBottomPadding.roundToDouble(),
                                color: Theme.of(context).cardColor,
                              )
                            ],
                          ),
                        )
                      : null,
                ),
                AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: widget.musicFloatingWidget != null ||
                            widget.videoFloatingWidget != null
                        ? Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              _backdropWidget(),
                              Builder(builder: (context) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                      bottom: (82 *
                                              navigationBarAnimationController
                                                  .value) +
                                          (systemBottomPadding *
                                              (1 -
                                                  floatingWidgetAnimationController
                                                      .value))),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: (1 -
                                              floatingWidgetAnimationController
                                                  .value) *
                                          widget.floatingWidgetConfig.padding
                                              .horizontal,
                                      vertical: (1 -
                                              floatingWidgetAnimationController
                                                  .value) *
                                          widget.floatingWidgetConfig.padding
                                              .vertical,
                                    ),
                                    child: _actualSlidingPanel(),
                                  ),
                                );
                              })
                            ],
                          )
                        : const SizedBox.shrink())
              ],
            );
          },
          child: AppSettings.lockNavigationBar
              ? mainChild!
              : Listener(
                  onPointerUp: (_) {
                    pixelsScrolled = 0;
                    if (navigationBarAnimationController.value > 0.5) {
                      navigationBarAnimationController.animateTo(1);
                      navigationBarScrolledDown = false;
                    } else {
                      navigationBarAnimationController.animateTo(0);
                      navigationBarScrolledDown = true;
                    }
                  },
                  child: NotificationListener<ScrollUpdateNotification>(
                      onNotification: (ScrollUpdateNotification details) {
                        if (widget.floatingWidgetController
                                ?.lockNotificationListener ??
                            false) {
                          return false;
                        }
                        if (details.metrics.axis == Axis.horizontal)
                          return false;
                        pixelsScrolled =
                            (pixelsScrolled + (details.scrollDelta ?? 0).abs())
                                    .clamp(0, 100) /
                                100;
                        if ((details.scrollDelta ?? 0) > 0.0 &&
                            details.metrics.axis == Axis.vertical) {
                          if (details.metrics.pixels <= 0) return false;
                          navigationBarAnimationController.value -=
                              pixelsScrolled;
                        } else {
                          if (details.metrics.pixels >=
                              details.metrics.maxScrollExtent) return false;
                          navigationBarAnimationController.value +=
                              pixelsScrolled;
                        }
                        return false;
                      },
                      child: mainChild!),
                ),
        );
      },
      child: widget.body,
    );
  }

  Widget _musicSlidingPanel() {
    return AnimatedBuilder(
        animation: floatingWidgetAnimationController,
        builder: (context, child) {
          return SizedBox(
              height: ((widget.floatingWidgetConfig.maxHeight ??
                          MediaQuery.of(context).size.height) *
                      floatingWidgetAnimationController.value) +
                  (widget.floatingWidgetConfig.minHeight *
                      (1 - floatingWidgetAnimationController.value)),
              child: child);
        },
        child: widget.musicFloatingWidget!);
  }

  Widget _videoSlidingPanel() {
    return AnimatedBuilder(
        animation: floatingWidgetAnimationController,
        builder: (context, child) {
          return SizedBox(
              height: ((widget.floatingWidgetConfig.maxHeight ??
                          MediaQuery.of(context).size.height) *
                      floatingWidgetAnimationController.value) +
                  (widget.floatingWidgetConfig.minHeight *
                      (1 - floatingWidgetAnimationController.value)),
              child: child);
        },
        child: widget.videoFloatingWidget!);
  }

  Widget _actualSlidingPanel() {
    UiProvider uiProvider = Provider.of(context);
    ContentProvider contentProvider = Provider.of(context);
    if (widget.floatingWidgetConfig.isPanelVisible) {
      return Row(
        children: [
          Expanded(
            child: AnimatedSize(
              duration: const Duration(milliseconds: 300),
              child: _gestureHandler(
                child: AnimatedBuilder(
                  animation: floatingWidgetAnimationController,
                  builder: (context, child) {
                    return Dismissible(
                      key: dismissKey,
                      onDismissed: (direction) async {
                        if (uiProvider.currentPlayer == CurrentPlayer.video) {
                          // Dismiss Video Player
                          uiProvider.currentPlayer = CurrentPlayer.music;
                          contentProvider.endVideoPlayer();
                          setState(() {
                            dismissKey = ValueKey(const Uuid().v4());
                          });
                        } else {
                          // Dismiss Music Player
                          await audioHandler.stop();
                          uiProvider.currentPlayer = CurrentPlayer.video;
                          setState(() {
                            dismissKey = ValueKey(const Uuid().v4());
                          });
                        }
                      },
                      direction: widget
                                  .floatingWidgetController!.isPanelClosed ||
                              widget.floatingWidgetController!.isPanelAnimating
                          ? DismissDirection.horizontal
                          : DismissDirection.none,
                      child: Container(
                          decoration: BoxDecoration(
                            color: ColorTween(
                                    end: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    begin: Theme.of(context).cardColor)
                                .animate(floatingWidgetAnimationController)
                                .value,
                            borderRadius:
                                floatingWidgetAnimationController.value == 1
                                    ? BorderRadius.zero
                                    : BorderRadius.circular(30),
                          ),
                          child: child),
                    );
                  },
                  child: Stack(
                    children: [
                      ShowUpTransition(
                        delay: const Duration(milliseconds: 250),
                        forward:
                            uiProvider.currentPlayer == CurrentPlayer.video &&
                                widget.videoFloatingWidget != null,
                        child: widget.videoFloatingWidget != null
                            ? _videoSlidingPanel()
                            : const SizedBox(),
                      ),
                      ShowUpTransition(
                        delay: const Duration(milliseconds: 250),
                        forward:
                            uiProvider.currentPlayer == CurrentPlayer.music &&
                                widget.musicFloatingWidget != null,
                        child: widget.musicFloatingWidget != null
                            ? _musicSlidingPanel()
                            : const SizedBox(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (widget.videoFloatingWidget != null &&
              widget.musicFloatingWidget != null)
            AnimatedBuilder(
                animation: floatingWidgetAnimationController,
                builder: (context, snapshot) {
                  return ShowUpTransition(
                    slideSide: SlideFromSlide.right,
                    child: SizedBox(
                      width: Tween<double>(begin: 48 + 12, end: 0)
                          .animate(floatingWidgetAnimationController)
                          .value,
                      height: Tween<double>(begin: 48, end: 0)
                          .animate(floatingWidgetAnimationController)
                          .value,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Opacity(
                          opacity: Tween<double>(begin: 1, end: 0)
                              .animate(floatingWidgetAnimationController)
                              .value,
                          child: Material(
                            color: Colors.transparent,
                            child: Bounce(
                              onPressed: () => uiProvider.switchPlayers(),
                              duration: const Duration(milliseconds: 150),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Theme.of(context).cardColor,
                                    borderRadius: BorderRadius.circular(100)),
                                child: AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 300),
                                    child: uiProvider.currentPlayer ==
                                            CurrentPlayer.video
                                        ? Icon(Ionicons.musical_note,
                                            color: Theme.of(context)
                                                .iconTheme
                                                .color,
                                            size: Tween<double>(
                                                    begin: 18, end: 0)
                                                .animate(
                                                    floatingWidgetAnimationController)
                                                .value)
                                        : Icon(Ionicons.logo_youtube,
                                            color: Theme.of(context)
                                                .iconTheme
                                                .color,
                                            size: Tween<double>(
                                                    begin: 18, end: 0)
                                                .animate(
                                                    floatingWidgetAnimationController)
                                                .value)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                })
        ],
      );
    } else {
      return const SizedBox();
    }
  }

  Widget _backdropWidget() {
    return !widget.floatingWidgetConfig.backdropEnabled
        ? const SizedBox.shrink()
        : AnimatedBuilder(
            animation: floatingWidgetAnimationController,
            builder: (context, _) {
              return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,

                //set color to null so that touch events pass through
                //to the body when the panel is closed, otherwise,
                //if a color exists, then touch events won't go through
                color: floatingWidgetAnimationController.value == 0.0
                    ? null
                    : widget.floatingWidgetConfig.backdropColor.withOpacity(
                        widget.floatingWidgetConfig.backdropOpacity *
                            floatingWidgetAnimationController.value),
              );
            });
  }

  // returns a gesture detector if panel is used
  // and a listener if panelBuilder is used.
  // this is because the listener is designed only for use with linking the scrolling of
  // panels and using it for panels that don't want to linked scrolling yields odd results
  Widget _gestureHandler({required Widget child}) {
    if (widget.musicFloatingWidget != null ||
        widget.videoFloatingWidget != null) {
      return GestureDetector(
        onVerticalDragUpdate: (DragUpdateDetails dets) =>
            _onGestureSlide(dets.delta.dy),
        onVerticalDragEnd: (DragEndDetails dets) =>
            _onGestureEnd(dets.velocity),
        child: child,
      );
    }

    return Listener(
      onPointerDown: (PointerDownEvent p) =>
          _vt.addPosition(p.timeStamp, p.position),
      onPointerMove: (PointerMoveEvent p) {
        _vt.addPosition(p.timeStamp,
            p.position); // add current position for velocity tracking
        _onGestureSlide(p.delta.dy);
      },
      onPointerUp: (PointerUpEvent p) => _onGestureEnd(_vt.getVelocity()),
      child: child,
    );
  }

  // handles the sliding gesture
  void _onGestureSlide(double dy) {
    // only slide the panel if scrolling is not enabled
    if (!_scrollingEnabled) {
      floatingWidgetAnimationController.value -= dy /
          ((widget.floatingWidgetConfig.maxHeight ??
                  MediaQuery.of(context).size.height) -
              widget.floatingWidgetConfig.minHeight);
    }

    // if the panel is open and the user hasn't scrolled, we need to determine
    // whether to enable scrolling if the user swipes up, or disable closing and
    // begin to close the panel if the user swipes down
    if (_isPanelOpen &&
        _floatingWidgetScrollController.hasClients &&
        _floatingWidgetScrollController.offset <= 0) {
      setState(() {
        if (dy < 0) {
          _scrollingEnabled = true;
        } else {
          _scrollingEnabled = false;
        }
      });
    }
  }

  // handles when user stops sliding
  void _onGestureEnd(Velocity v) {
    double minFlingVelocity = 365.0;

    //let the current animation finish before starting a new one
    if (floatingWidgetAnimationController.isAnimating) return;

    // if scrolling is allowed and the panel is open, we don't want to close
    // the panel if they swipe up on the scrollable
    if (_isPanelOpen && _scrollingEnabled) return;

    //check if the velocity is sufficient to constitute fling to end
    double visualVelocity = -v.pixelsPerSecond.dy /
        ((widget.floatingWidgetConfig.maxHeight ??
                MediaQuery.of(context).size.height) -
            widget.floatingWidgetConfig.minHeight);

    // get minimum distances to figure out where the panel is at
    double d2Close = floatingWidgetAnimationController.value;
    double d2Open = 1 - floatingWidgetAnimationController.value;
    double d2Snap = (3 - floatingWidgetAnimationController.value)
        .abs(); // large value if null results in not every being the min
    double minDistance = min(d2Close, min(d2Snap, d2Open));

    // check if velocity is sufficient for a fling
    if (v.pixelsPerSecond.dy.abs() >= minFlingVelocity) {
      floatingWidgetAnimationController.fling(velocity: visualVelocity);
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

  void _flingPanelToPosition(double targetPos, double velocity) {
    final Simulation simulation = SpringSimulation(
        SpringDescription.withDampingRatio(
          mass: 1.0,
          stiffness: 500.0,
          ratio: 1.0,
        ),
        floatingWidgetAnimationController.value,
        targetPos,
        velocity);

    floatingWidgetAnimationController.animateWith(simulation);
  }

  //---------------------------------
  //PanelController related functions
  //---------------------------------

  //close the panel
  Future<void> _close() {
    return floatingWidgetAnimationController.fling(velocity: -1.0);
  }

  //open the panel
  Future<void> _open() {
    return floatingWidgetAnimationController.fling(velocity: 1.0);
  }

  //animate the panel position to value - must
  //be between 0.0 and 1.0
  Future<void> _animatePanelToPosition(double value,
      {Duration duration = const Duration(milliseconds: 200),
      Curve curve = Curves.linear}) {
    assert(0.0 <= value && value <= 1.0);
    return floatingWidgetAnimationController.animateTo(value,
        duration: duration, curve: curve);
  }

  //set the panel position to value - must
  //be between 0.0 and 1.0
  set _panelPosition(double value) {
    assert(0.0 <= value && value <= 1.0);
    floatingWidgetAnimationController.value = value;
  }

  //get the current panel position
  //returns the % offset from collapsed state
  //as a decimal between 0.0 and 1.0
  double get _panelPosition => floatingWidgetAnimationController.value;

  //returns whether or not
  //the panel is still animating
  bool get _isPanelAnimating => floatingWidgetAnimationController.isAnimating;

  //returns whether or not the
  //panel is open
  bool get _isPanelOpen => floatingWidgetAnimationController.value == 1.0;

  //returns whether or not the
  //panel is closed
  bool get _isPanelClosed => floatingWidgetAnimationController.value == 0.0;
}

class FloatingWidgetController {
  FancyScaffoldState? _scaffoldState;

  void _addState(FancyScaffoldState panelState) {
    _scaffoldState = panelState;
  }

  /// Navigator Key
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // Determine if we have to listen for scrolling notifications to turn up/down
  // the floating widget based on the navigation bar visibility
  bool lockNotificationListener = false;

  /// Determine if the panelController is attached to an instance
  /// of the SlidingUpPanel (this property must return true before any other
  /// functions can be used)
  bool get isAttached => _scaffoldState != null;

  AnimationController get animationController =>
      _scaffoldState!.floatingWidgetAnimationController;
  AnimationController get navbarAnimationController =>
      _scaffoldState!.navigationBarAnimationController;
  bool get navbarScrolledDown => _scaffoldState!.navigationBarScrolledDown;
  set navbarScrolledDown(bool value) {
    _scaffoldState!.navigationBarScrolledDown = value;
  }

  /// Closes the sliding panel to its collapsed state (i.e. to the  minHeight)
  Future<void> close() {
    assert(isAttached, "PanelController must be attached to a SlidingUpPanel");
    return _scaffoldState!._close();
  }

  /// Opens the sliding panel fully
  /// (i.e. to the maxHeight)
  Future<void> open() {
    assert(isAttached, "PanelController must be attached to a SlidingUpPanel");
    return _scaffoldState!._open();
  }

  /// Animates the panel position to the value.
  /// The value must between 0.0 and 1.0
  /// where 0.0 is fully collapsed and 1.0 is completely open.
  /// (optional) duration specifies the time for the animation to complete
  /// (optional) curve specifies the easing behavior of the animation.
  Future<void> animatePanelToPosition(double value,
      {Duration duration = const Duration(milliseconds: 200),
      Curve curve = Curves.linear}) {
    assert(isAttached, "PanelController must be attached to a SlidingUpPanel");
    assert(0.0 <= value && value <= 1.0);
    return _scaffoldState!
        ._animatePanelToPosition(value, duration: duration, curve: curve);
  }

  /// Sets the panel position (without animation).
  /// The value must between 0.0 and 1.0
  /// where 0.0 is fully collapsed and 1.0 is completely open.
  set panelPosition(double value) {
    assert(isAttached, "PanelController must be attached to a SlidingUpPanel");
    assert(0.0 <= value && value <= 1.0);
    _scaffoldState!._panelPosition = value;
  }

  /// Gets the current panel position.
  /// Returns the % offset from collapsed state
  /// to the open state
  /// as a decimal between 0.0 and 1.0
  /// where 0.0 is fully collapsed and
  /// 1.0 is full open.
  double get panelPosition {
    assert(isAttached, "PanelController must be attached to a SlidingUpPanel");
    return _scaffoldState!._panelPosition;
  }

  /// Returns whether or not the panel is
  /// currently animating.
  bool get isPanelAnimating {
    assert(isAttached, "PanelController must be attached to a SlidingUpPanel");
    return _scaffoldState!._isPanelAnimating;
  }

  /// Returns whether or not the
  /// panel is open.
  bool get isPanelOpen {
    assert(isAttached, "PanelController must be attached to a SlidingUpPanel");
    return _scaffoldState!._isPanelOpen;
  }

  /// Returns whether or not the
  /// panel is closed.
  bool get isPanelClosed {
    assert(isAttached, "PanelController must be attached to a SlidingUpPanel");
    return _scaffoldState!._isPanelClosed;
  }
}
