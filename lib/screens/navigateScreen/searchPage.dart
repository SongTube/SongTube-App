import 'package:flutter/material.dart';
import 'package:songtube/screens/navigateScreen/components/videoTile.dart';

class SearchPage extends StatelessWidget {
  final List<dynamic> results;
  SearchPage({
    @required this.results,
  });
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: results.length,
      itemExtent: 310,
      itemBuilder: (context, index) {
        return Column(
          children: [
            VideoTile(
              searchItem: results[index],
            ),
          ],
        );
      }
    );
  }
}