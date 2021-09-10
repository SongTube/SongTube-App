import 'package:flutter/material.dart';
import 'package:newpipeextractor_dart/models/filters.dart';
import 'package:provider/provider.dart';
import 'package:songtube/provider/managerProvider.dart';
import 'package:songtube/ui/components/styledBottomSheet.dart';

class SearchFiltersSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ManagerProvider manager = Provider.of<ManagerProvider>(context);
    return StyledBottomSheet(
      title: "Search Filters",
      contentPadding: EdgeInsets.all(12),
      content: ListView.builder(
        shrinkWrap: true,
        itemCount: YoutubeSearchFilter.searchFilters.length,
        itemBuilder: (context, index) {
          String filter = YoutubeSearchFilter.searchFilters[index];
          return CheckboxListTile(
            title: Text(
              (filter[0].toUpperCase() + filter.substring(1))
                .replaceAll("_", " "),
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyText1.color,
                fontSize: 16,
                fontFamily: 'Product Sans',
                fontWeight: FontWeight.w600
              ),
            ),
            value: manager.searchFilters.contains(filter),
            onChanged: (_) {
              if (manager.searchFilters.contains(filter)) {
                manager.searchFilters.removeWhere((element) => element == filter);
              } else {
                manager.searchFilters.add(filter);
              }
              manager.setState();
            }
          );
        },
      ),
      actions: [
        TextButton(
          child: Text(
            "Close",
            style: TextStyle(
              color: Theme.of(context).accentColor,
              fontFamily: 'Product Sans',
              fontWeight: FontWeight.w700,
              fontSize: 18
            ),
          ),
          onPressed: () => Navigator.pop(context)
        )
      ],
    );
  }
}