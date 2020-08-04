import 'package:flutter/material.dart';
import 'package:songtube/ui/searchResult/videoTile.dart';

class SearchResults extends StatefulWidget {
  final List results;
  final Function onSelect;
  SearchResults({
    @required this.results,
    @required this.onSelect,
  });

  @override
  _SearchResultsState createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: widget.results.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(
            top: widget.results[index] == widget.results.first ? 10 : 0,
            bottom: widget.results[index] == widget.results.last ? 10 : 0
          ),
          child: VideoTile(
            video: widget.results[index],
            onSelect: widget.onSelect,
          ),
        );
      },
    );
  }
}