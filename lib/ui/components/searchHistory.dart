import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:songtube/provider/configurationProvider.dart';

class SearchHistoryList extends StatelessWidget {
  final EdgeInsetsGeometry margin;
  final double borderRadius;
  final Function(String) onItemTap;
  SearchHistoryList({
    @required this.onItemTap,
    this.margin = const EdgeInsets.all(12),
    this.borderRadius = 10
  });
  @override
  Widget build(BuildContext context) {
    ConfigurationProvider appData = Provider.of<ConfigurationProvider>(context);
    List<String> searchHistory = appData.getSearchHistory();
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.08),
            offset: Offset(0,0),
            spreadRadius: 0.01,
            blurRadius: 20.0
          )
        ]
      ),
      child: ListView.builder(
        itemExtent: 40,
        itemCount: searchHistory.length,
        itemBuilder: (context, index) {
          String item = searchHistory[index];
          return ListTile(
            title: Text("$item", style: TextStyle(
              color: Theme.of(context).textTheme.bodyText1.color)),
            leading: SizedBox(
              width: 40,
              height: 40,
              child: Icon(Icons.history,
                color: Theme.of(context).iconTheme.color),
            ),
            trailing: IconButton(
              icon: Icon(Icons.clear, size: 20),
              onPressed: () {
                appData.removeStringfromSearchHistory(index);
              },
            ),
            onTap: () => onItemTap(item),
          );
        },
      ),
    );
  }
}