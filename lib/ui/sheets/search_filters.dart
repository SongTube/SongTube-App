import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:newpipeextractor_dart/models/filters.dart';
import 'package:provider/provider.dart';
import 'package:songtube/internal/global.dart';
import 'package:songtube/languages/languages.dart';
import 'package:songtube/providers/content_provider.dart';
import 'package:songtube/providers/media_provider.dart';
import 'package:songtube/ui/animations/animated_icon.dart';
import 'package:songtube/ui/sheets/common_sheet.dart';
import 'package:songtube/ui/text_styles.dart';

class SearchFiltersSheet extends StatefulWidget {
  @override
  State<SearchFiltersSheet> createState() => _SearchFiltersSheetState();
}

class _SearchFiltersSheetState extends State<SearchFiltersSheet> {
  @override
  Widget build(BuildContext context) {
    ContentProvider contentProvider = Provider.of(context);
    MediaProvider mediaProvider = Provider.of(context);
    return CommonSheet(
      useCustomScroll: false,
      builder: (context, _) {
        return Padding(
          padding: const EdgeInsets.all(12).copyWith(top: 0),
          child: Flex(
            direction: Axis.vertical,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const AppAnimatedIcon(Iconsax.arrow_left, size: 22)
                  ),
                  const SizedBox(width: 12),
                  Expanded(child: Text(Languages.of(context)!.labelSearchFilters, style: textStyle(context, bold: false))),
                ],
              ),
              const SizedBox(height: 8),
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: YoutubeSearchFilter.searchFilters.length,
                  itemBuilder: (context, index) {
                    String filter = YoutubeSearchFilter.searchFilters[index];
                    return CheckboxListTile(
                      contentPadding: const EdgeInsets.only(left: 8, right: 0),
                      visualDensity: const VisualDensity(horizontal: -2, vertical: -2),
                      activeColor: Colors.transparent,
                      checkColor: mediaProvider.currentColors.vibrant,
                      checkboxShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
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
                        contentProvider.saveSearchFilters();
                      }
                    );
                  },
                ),
              ),
              const SizedBox(height: 6),
              Flex(
                mainAxisAlignment: MainAxisAlignment.center,
                direction: Axis.horizontal,
                children: [
                  Flexible(
                    flex: 3,
                    child: Divider(endIndent: 12, color: Theme.of(context).dividerColor)),
                  Flexible(
                    flex: 2,
                    child: Text('OPTIONS', style: tinyTextStyle(context, opacity: 0.2).copyWith(letterSpacing: 1, fontWeight: FontWeight.bold, fontSize: 10))),
                  Flexible(
                    flex: 3,
                    child: Divider(indent: 12, color: Theme.of(context).dividerColor)),
                ],
              ),
              const SizedBox(height: 6),
              CheckboxListTile(
                contentPadding: const EdgeInsets.only(left: 8, right: 0),
                activeColor: Colors.transparent,
                checkColor: mediaProvider.currentColors.vibrant,
                checkboxShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                title: Text(
                  'Persistent Filters',
                  style: subtitleTextStyle(context, bold: false)
                ),
                subtitle: Text('Search filters will be saved even on app restart', style: smallTextStyle(context, opacity: 0.6)),
                value: sharedPreferences.getBool('enablePersistentVideoSearchFilters') ?? false,
                onChanged: (value) {
                  sharedPreferences.setBool('enablePersistentVideoSearchFilters', value!);
                  contentProvider.setState();
                }
              ),
            ],
          ),
        );
      }
    );
  }
}