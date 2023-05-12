import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:newpipeextractor_dart/models/filters.dart';
import 'package:provider/provider.dart';
import 'package:songtube/providers/content_provider.dart';
import 'package:songtube/ui/sheet_phill.dart';
import 'package:songtube/ui/text_styles.dart';

class SearchFiltersSheet extends StatefulWidget {
  @override
  State<SearchFiltersSheet> createState() => _SearchFiltersSheetState();
}

class _SearchFiltersSheetState extends State<SearchFiltersSheet> {
  @override
  Widget build(BuildContext context) {
    ContentProvider contentProvider = Provider.of(context);
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20)
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Align(
            alignment: Alignment.center,
            child: BottomSheetPhill()),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: Icon(Ionicons.arrow_back_outline),
                  )
                ),
                Expanded(child: Text('Search Filters', style: textStyle(context))),
              ],
            ),
          ),
          const SizedBox(height: 8),
          ListView.builder(
            shrinkWrap: true,
            itemCount: YoutubeSearchFilter.searchFilters.length,
            itemBuilder: (context, index) {
              String filter = YoutubeSearchFilter.searchFilters[index];
              return CheckboxListTile(
                contentPadding: const EdgeInsets.only(left: 24, right: 12),
                activeColor: Theme.of(context).iconTheme.color,
                checkColor: Theme.of(context).primaryColor,
                title: Text(
                  (filter[0].toUpperCase() + filter.substring(1))
                    .replaceAll("_", " "),
                  style: subtitleTextStyle(context, bold: false)
                ),
                value: contentProvider.searchFilters.contains(filter),
                onChanged: (_) {
                  if (contentProvider.searchFilters.contains(filter)) {
                    contentProvider.searchFilters.removeWhere((element) => element == filter);
                  } else {
                    contentProvider.searchFilters.add(filter);
                  }
                  contentProvider.setState();
                }
              );
            },
          ),
        ],
      ),
    );
  }
}