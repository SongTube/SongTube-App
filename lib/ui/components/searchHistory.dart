import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:songtube/provider/configurationProvider.dart';

class SearchHistoryList extends StatelessWidget {
  final Function(String) onItemTap;
  SearchHistoryList({
    @required this.onItemTap,
  });
  @override
  Widget build(BuildContext context) {
    ConfigurationProvider config = Provider.of<ConfigurationProvider>(context);
    List<String> searchHistory = config.getSearchHistory();
    return ListView.builder(
      itemExtent: 40,
      physics: BouncingScrollPhysics(),
      itemCount: searchHistory.length,
      itemBuilder: (context, index) {
        String item = searchHistory[index];
        return ListTile(
          title: Text(
            "$item",
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyText1.color,
              fontSize: 14
            ),
            maxLines: 1,
            overflow: TextOverflow.fade,
            softWrap: false,
          ),
          leading: SizedBox(
            width: 40,
            height: 40,
            child: Icon(Icons.history,
              color: Theme.of(context).iconTheme.color),
          ),
          trailing: IconButton(
            icon: Icon(Icons.clear, size: 20),
            onPressed: () {
              config.removeStringfromSearchHistory(index);
            },
          ),
          onTap: () => onItemTap(item),
        );
      },
    );
  }
}