import 'package:flutter/material.dart';
import 'package:songtube/ui/searchResult/videoTile.dart';

class SearchPage extends StatefulWidget {
  final List results;
  final Function onSelect;
  SearchPage({
    @required this.results,
    @required this.onSelect,
  });

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with TickerProviderStateMixin {
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