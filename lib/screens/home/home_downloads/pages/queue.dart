import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:songtube/providers/download_provider.dart';
import 'package:songtube/ui/text_styles.dart';
import 'package:songtube/ui/tiles/download_tile.dart';

class DownloadsQueuePage extends StatefulWidget {
  const DownloadsQueuePage({super.key});

  @override
  State<DownloadsQueuePage> createState() => _DownloadsQueuePageState();
}

class _DownloadsQueuePageState extends State<DownloadsQueuePage> {

  @override
  Widget build(BuildContext context) {
    DownloadProvider downloadProvider = Provider.of(context);
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: downloadProvider.queue.isEmpty
        ? Center(child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Ionicons.list, size: 64),
              const SizedBox(height: 8),
              Text('Your queue is empty', style: textStyle(context)),
              Padding(
                padding: const EdgeInsets.only(left: 32, right: 32),
                child: Text('Go home and search for something to download!', style: subtitleTextStyle(context, opacity: 0.6), textAlign: TextAlign.center,),
              ),
            ],
          ))
        : _body(),
    );
  }

  Widget _body() {
    DownloadProvider downloadProvider = Provider.of(context);
    return ListView.builder(
      padding: const EdgeInsets.only(top: 12).copyWith(bottom: (kToolbarHeight*1.5)+16),
      itemCount: downloadProvider.queue.length,
      itemBuilder: (context, index) {
        final item = downloadProvider.queue[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: DownloadQueueTile(item: item),
        );
      },
    );
  }
}