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
      itemBuilder: (context, index) {
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                bottom: index+1 == results.length ? 10 : 0,
              ),
              child: VideoTile(
                searchItem: results[index],
              ),
            ),
          ],
        );
      }
    );
  }
}