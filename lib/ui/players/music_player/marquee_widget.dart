// Flutter
import 'dart:ui';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';

class MarqueeWidget extends StatefulWidget {
  final Widget child;
  final Axis direction;
  final Duration animationDuration, backDuration, pauseDuration;
  final MediaItem? currentSong;
  final Color textColor;
  const MarqueeWidget({
    required this.child,
    this.direction = Axis.horizontal,
    this.animationDuration = const Duration(milliseconds: 3000),
    this.backDuration = const Duration(milliseconds: 800),
    this.pauseDuration = const Duration(milliseconds: 800),
    required this.currentSong,
    required this.textColor,
    Key? key,
  }) : super(key: key);

  @override
  _MarqueeWidgetState createState() => _MarqueeWidgetState();
}

class _MarqueeWidgetState extends State<MarqueeWidget> with TickerProviderStateMixin {
  
  @override
  void didUpdateWidget(covariant MarqueeWidget oldWidget) {
    if (oldWidget.currentSong?.id != widget.currentSong?.id) {
      if (scrollController.hasClients) {
        scrollController.animateTo(0, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  ScrollController scrollController = ScrollController(initialScrollOffset: 0);

  // Animate gradient on scroll
  late AnimationController animationController = AnimationController(vsync: this);

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(scroll);
    super.initState();
  }

  @override
  void dispose(){
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.dstIn,
      shaderCallback: (rect) {
        return LinearGradient(
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
          colors: [Colors.transparent, widget.textColor, widget.textColor, widget.textColor, widget.textColor, widget.textColor,widget.textColor],
        ).createShader(Rect.fromLTRB(rect.left, rect.height, rect.right, rect.height));
      },
      child: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          return ShaderMask(
            blendMode: BlendMode.dstIn,
            shaderCallback: (rect) {
            return LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [widget.textColor.withOpacity(1 - animationController.value), widget.textColor, widget.textColor, widget.textColor, widget.textColor, widget.textColor,widget.textColor],
              ).createShader(Rect.fromLTRB(rect.left, rect.height, rect.right, rect.height));
            },
            child: child,
          );
        },
        child: NotificationListener<ScrollNotification>(
          onNotification: (position) {
            final pixels = position.metrics.pixels.clamp(0, 10)/10;
            animationController.value = pixels;
            return true;
          },
          child: SingleChildScrollView(
            scrollDirection: widget.direction,
            controller: scrollController,
            child: widget.child,
          ),
        ),
      ),
    );
  }

  void scroll(_) async {
    while (scrollController.hasClients) {
        await Future.delayed(widget.pauseDuration);
        if(scrollController.hasClients) {
          await scrollController.animateTo(
              scrollController.position.maxScrollExtent,
              duration: widget.animationDuration,
              curve: Curves.easeIn);
        }
        await Future.delayed(widget.pauseDuration);
        if(scrollController.hasClients) {
          await scrollController.animateTo(0.0,
              duration: widget.backDuration, curve: Curves.easeOut);
        }
    }
  }
}