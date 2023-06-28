import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:songtube/internal/cache_utils.dart';
import 'package:songtube/internal/global.dart';
import 'package:songtube/languages/languages.dart';
import 'package:songtube/main.dart';
import 'package:songtube/providers/content_provider.dart';
import 'package:songtube/ui/info_item_renderer.dart';
import 'package:songtube/ui/sheets/common_sheet.dart';
import 'package:songtube/ui/text_styles.dart';

class WatchHistoryPage extends StatefulWidget {
  const WatchHistoryPage({
    super.key});

  @override
  State<WatchHistoryPage> createState() => _WatchHistoryPageState();
}

class _WatchHistoryPageState extends State<WatchHistoryPage> {

  GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  // Remove Item
  void removeItem(dynamic infoItem) async {
    final index = CacheUtils.watchHistory.indexWhere((element) => element.id == infoItem.id);
    listKey.currentState!.removeItem(index, (context, animation) {
      return _animation(context, infoItem, animation);
    }, duration: const Duration(milliseconds: 300));
    ContentProvider.removeFromHistory(CacheUtils.watchHistory[index]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top),
          SizedBox(
            height: kToolbarHeight,
            child: Row(
              children: [
                const SizedBox(width: 4),
                IconButton(
                  icon: Icon(Iconsax.arrow_left, color: Theme.of(context).iconTheme.color),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    Languages.of(context)!.labelWatchHistory,
                    style: textStyle(context)
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showModalBottomSheet(context: internalNavigatorKey.currentContext!, backgroundColor: Colors.transparent, isScrollControlled: true, builder: (context) {
                      return CommonSheet(
                        title: Languages.of(context)!.labelClearWatchHistory,
                        body: Text(Languages.of(context)!.labelClearWatchHistoryDescription, style: subtitleTextStyle(context, opacity: 0.8)),
                        actions: [
                          // Cancel Button
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 12, right: 12),
                              child: Text(Languages.of(context)!.labelCancel, style: smallTextStyle(context)),
                            )
                          ),
                          // Delete button
                          Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(100)
                            ),
                            child: TextButton(
                              onPressed: () {
                                sharedPreferences.remove('watchHistory');
                                setState(() {
                                  listKey = GlobalKey<AnimatedListState>();
                                });
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(left: 12, right: 12),
                                child: Text(Languages.of(context)!.labelDelete, style: smallTextStyle(context).copyWith(color: Colors.white)),
                              )
                            ),
                          ),
                        ],
                      );
                    });
                  },
                  icon: const Icon(Iconsax.video_remove),
                )
              ],
            ),
          ),
          Divider(height: 1, color: Theme.of(context).dividerColor),
          Expanded(
            child: AnimatedList(
              key: listKey,
              padding: const EdgeInsets.only(top: 12),
              physics: const BouncingScrollPhysics(),
              initialItemCount: CacheUtils.watchHistory.length,
              itemBuilder: (context, index, animation) {
                final item = CacheUtils.watchHistory[index];
                return _animation(context, item, animation);
              },
            )
          )
        ],
      ),
    );
  }

  Widget _animation(BuildContext context, dynamic item, Animation<double> animation) {
    return SizeTransition(
      axis: Axis.vertical,
      sizeFactor: Tween<double>(
        begin: 0,
        end: 1,
      ).animate(CurvedAnimation(
        parent: animation,
        curve: Curves.ease,
        reverseCurve: Curves.ease)
      ),
      child: FadeTransition(
        opacity: Tween<double>(
          begin: 0,
          end: 1,
        ).animate(CurvedAnimation(
          parent: animation,
          curve: Curves.fastLinearToSlowEaseIn,
          reverseCurve: Curves.fastLinearToSlowEaseIn)
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: InfoItemRenderer(
            key: ValueKey(item.id),
            infoItem: item, expandItem: true, onDelete: () => removeItem(item)),
        ),
      ),
    );
  }

}