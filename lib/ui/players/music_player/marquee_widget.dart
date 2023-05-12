// Flutter
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';

class MarqueeWidget extends StatefulWidget {
  final Widget child;
  final Axis direction;
  final Duration animationDuration, backDuration, pauseDuration;
  final MediaItem? currentSong;
  const MarqueeWidget({
    required this.child,
    this.direction = Axis.horizontal,
    this.animationDuration = const Duration(milliseconds: 3000),
    this.backDuration = const Duration(milliseconds: 800),
    this.pauseDuration = const Duration(milliseconds: 800),
    required this.currentSong,
    Key? key,
  }) : super(key: key);

  @override
  _MarqueeWidgetState createState() => _MarqueeWidgetState();
}

class _MarqueeWidgetState extends State<MarqueeWidget> {
  
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
    return SingleChildScrollView(
      scrollDirection: widget.direction,
      controller: scrollController,
      child: widget.child,
    );
  }

  void scroll(_) async {
    while (scrollController.hasClients) {
        await Future.delayed(widget.pauseDuration);
        if(scrollController.hasClients) {
          await scrollController.animateTo(
              scrollController.position.maxScrollExtent,
              duration: widget.animationDuration,
              curve: Curves.ease);
        }
        await Future.delayed(widget.pauseDuration);
        if(scrollController.hasClients) {
          await scrollController.animateTo(0.0,
              duration: widget.backDuration, curve: Curves.easeOut);
        }
    }
  }
}