import 'dart:io';

import 'package:flutter/material.dart';
import 'package:songtube/internal/models/download/download_item.dart';
import 'package:songtube/ui/text_styles.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:validators/validators.dart';

class DownloadQueueTile extends StatefulWidget {
  const DownloadQueueTile({
    required this.item,
    super.key});
  final DownloadItem item;

  @override
  State<DownloadQueueTile> createState() => _DownloadQueueTileState();
}

class _DownloadQueueTileState extends State<DownloadQueueTile> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(left: 12, right: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(30)
      ),
      height: kToolbarHeight*2.4,
      child: Row(
        children: [
          _leading(),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(6).copyWith(left: 0, right: 0, bottom: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _title(),
                  _subtitle(),
                  const Spacer(),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      padding: const EdgeInsets.all(8).copyWith(left: 16, right: 16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(30)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          StreamBuilder<String?>(
                            stream: widget.item.downloadStatus.stream,
                            builder: (context, snapshot) {
                              final status = snapshot.data;
                              return Text(status ?? '', style: tinyTextStyle(context, opacity: 0.8).copyWith(letterSpacing: 0.4));
                            },
                          ),
                          const SizedBox(width: 4),
                          StreamBuilder<double?>(
                            stream: widget.item.downloadProgress.stream,
                            builder: (context, snapshot) {
                              final progress = snapshot.data;
                              return SizedBox(
                                width: progress != null ? 30 : 0,
                                child: Text(progress != null ? '${(progress*100).round()}%' : '', style: tinyTextStyle(context, opacity: 0.8).copyWith(letterSpacing: 0.4, color: Theme.of(context).primaryColor), textAlign: TextAlign.end));
                            },
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _title() {
    return Text(
      widget.item.downloadInfo.tags.titleController.text,
      style: smallTextStyle(context).copyWith(fontWeight: FontWeight.bold),
      maxLines: 1,
    );
  }

  Widget _subtitle() {
    return Text(
      widget.item.downloadInfo.tags.artistController.text,
      style: smallTextStyle(context, opacity: 0.6).copyWith(letterSpacing: 0.4, fontWeight: FontWeight.w500),
      maxLines: 1,
    );
  }

  Widget _leading() {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              blurRadius: 12,
              offset: const Offset(0,0),
              color: Theme.of(context).shadowColor.withOpacity(0.1)
            )
          ],
        ), 
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: FadeInImage(
            fadeInDuration: const Duration(milliseconds: 200),
            image: widget.item.downloadInfo.tags.artwork is String
              ? (isURL(widget.item.downloadInfo.tags.artwork)
                ? NetworkImage(widget.item.downloadInfo.tags.artwork)
                : FileImage(File(widget.item.downloadInfo.tags.artwork))) as ImageProvider
              : widget.item.downloadInfo.tags.artwork is File
                ? FileImage(widget.item.downloadInfo.tags.artwork) as ImageProvider
                : MemoryImage(widget.item.downloadInfo.tags.artwork),
            placeholder: MemoryImage(kTransparentImage),
            fit: BoxFit.fitHeight,
          ),
        ),
      ),
    );
  }

  Widget _trailing() {
    return const SizedBox();
  }
}