import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:songtube/providers/app_settings.dart';
import 'package:songtube/providers/content_provider.dart';
import 'package:songtube/ui/info_item_renderer.dart';

class VideoPlayerSuggestions extends StatefulWidget {
  const VideoPlayerSuggestions({
    required this.suggestions,
    super.key});
  final List<dynamic> suggestions;
  @override
  State<VideoPlayerSuggestions> createState() => VideoPlayerSuggestionsState();
}

class VideoPlayerSuggestionsState extends State<VideoPlayerSuggestions> {

  @override
  Widget build(BuildContext context) {
    ContentProvider contentProvider = Provider.of(context);
    contentProvider.playingContent!.videoSuggestionsController._addState(this);
    return widget.suggestions.isNotEmpty
      ? _suggestionsList()
      : _suggestionsShimmer();
  }

  Widget _suggestionsList() {
    final bool expand = AppSettings.videoSuggestionsViewMode == 'collapsed' ? false : true;
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        return Padding(
          padding: EdgeInsets.only(bottom: expand ? 24 : 12, left: expand ? 0 : 12, right: expand ? 0 : 12),
          child: InfoItemRenderer(infoItem: widget.suggestions[index], expandItem: expand),
        );
      }, childCount: widget.suggestions.length),
    );
  }

  Widget _suggestionsShimmer() {
    return const SliverToBoxAdapter(child: SizedBox());
  }

}

class VideoSuggestionsController {

  VideoPlayerSuggestionsState? _suggestionsState;

  void _addState(VideoPlayerSuggestionsState state) {
    _suggestionsState = state;
  }

  List<dynamic>? get relatedStreams => _suggestionsState?.widget.suggestions;

}