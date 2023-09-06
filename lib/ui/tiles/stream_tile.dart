import 'package:flutter/material.dart';
import 'package:image_fade/image_fade.dart';
import 'package:intl/intl.dart';
import 'package:newpipeextractor_dart/newpipeextractor_dart.dart';
import 'package:provider/provider.dart';
import 'package:songtube/languages/languages.dart';
import 'package:songtube/providers/content_provider.dart';
import 'package:songtube/providers/ui_provider.dart';
import 'package:songtube/screens/channel.dart';
import 'package:songtube/ui/components/channel_image.dart';
import 'package:songtube/ui/components/custom_inkwell.dart';
import 'package:songtube/ui/components/shimmer_container.dart';
import 'package:songtube/ui/text_styles.dart';
import 'package:songtube/ui/ui_utils.dart';
import 'package:timeago/timeago.dart' as timeago;

class StreamTileCollapsed extends StatelessWidget {
  const StreamTileCollapsed({
    required this.stream,
    this.onTap,
    this.isEditable = true,
    this.showChannelName = true,
    this.onDelete,
    super.key});
  final StreamInfoItem stream;
  /// By default, onTap loads this video on the content provider, but
  /// if onTap is set, you can run override that default behavior
  final Function()? onTap;
  final bool isEditable;
  final bool showChannelName;
  final Function()? onDelete;
  @override
  Widget build(BuildContext context) {
    ContentProvider contentProvider = Provider.of(context);
    UiProvider uiProvider = Provider.of(context);
    return CustomInkWell(
      onTap: isEditable
          ? onTap ??
              () {
                uiProvider.currentPlayer = CurrentPlayer.video;
                contentProvider.loadVideoPlayer(stream);
                uiProvider.fwController.open();
              }
          : () {},
      onLongPress: () {
      UiUtils.showInfoItemOptions(stream, onDelete: onDelete);
    },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: ImageFade(
                      fadeDuration: const Duration(milliseconds: 300),
                      placeholder:
                          const ShimmerContainer(height: null, width: null),
                      image: NetworkImage(stream.thumbnails!.hqdefault),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 6, right: 6),
                    padding:
                        const EdgeInsets.all(3).copyWith(left: 8, right: 8),
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(100)),
                    child: Text(UiUtils.timeFormatter(stream.duration!),
                        style: tinyTextStyle(context, bold: false)
                            .copyWith(color: Colors.white, letterSpacing: 0.4, fontSize: 10)),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      left: 8, right: 8, top: 4, bottom: 0),
                  child: Text(
                    stream.name ?? '',
                    style: smallTextStyle(context).copyWith(fontWeight: FontWeight.normal),
                    overflow: TextOverflow.clip,
                    maxLines: 2,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(
                    "${showChannelName ? '${stream.uploaderName}  •  ' : ''}${NumberFormat.compact().format(stream.viewCount) != '-1' ? '${NumberFormat.compact().format(stream.viewCount)} ${Languages.of(context)!.labelViews}' : ''}",
                    style: tinyTextStyle(context, opacity: 0.8).copyWith(fontWeight: FontWeight.w500),
                    overflow: TextOverflow.clip,
                    maxLines: 1,
                  ),
                ),
              Builder(
                builder: (context) {
                  final DateTime? date = stream.date != null ? DateTime.parse(stream.date!) : null;
                  return Container(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      date != null ? timeago.format(date, locale: 'en') : '',
                      style: tinyTextStyle(context, opacity: 0.8).copyWith(fontWeight: FontWeight.w500),
                      overflow: TextOverflow.clip,
                      maxLines: 1,
                    ),
                  );
                }
              ),
             ],
            ),
          ),
          if (isEditable)
          Semantics(
            label: Languages.of(context)!.labelMore,
            child: IconButton(
              onPressed: () {
                UiUtils.showInfoItemOptions(stream, onDelete: onDelete);
              },
              icon: Icon(Icons.more_vert, size: 20, color: Theme.of(context).iconTheme.color!.withOpacity(0.8))
            ),
          )
        ],
      ),
    );
  }
}

class StreamTileExpanded extends StatelessWidget {
  const StreamTileExpanded({required this.stream,this.onDelete, super.key, this.isEditable = true});
  final StreamInfoItem stream;
  final Function()? onDelete;
  final bool isEditable;
  @override
  Widget build(BuildContext context) {
    ContentProvider contentProvider = Provider.of(context);
    UiProvider uiProvider = Provider.of(context);
    return CustomInkWell(
      onTap: () {
        uiProvider.currentPlayer = CurrentPlayer.video;
        contentProvider.loadVideoPlayer(stream);
        uiProvider.fwController.open();
      },
      onLongPress: isEditable ? () {
        UiUtils.showInfoItemOptions(stream, onDelete: onDelete);
      } : null,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 8, left: 12, right: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: _thumbnail(context),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 4),
            child: _details(context),
          )
        ],
      ),
    );
  }

  Widget _thumbnail(context) {
    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.bottomCenter,
      children: [
        ImageFade(
          fadeDuration: const Duration(milliseconds: 300),
          placeholder: Container(
                color: Theme.of(context).cardColor.withOpacity(0.6)),
          image: NetworkImage(stream.thumbnails?.maxresdefault ?? ''),
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) =>
              Image.network(stream.thumbnails!.hqdefault, fit: BoxFit.cover),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Container(
              margin: const EdgeInsets.only(right: 6, bottom: 6),
              padding: const EdgeInsets.all(3).copyWith(left: 8, right: 8),
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(100)),
              child: Text(UiUtils.timeFormatter(stream.duration!),
                  style: tinyTextStyle(context, bold: false).copyWith(color: Colors.white, letterSpacing: 0.4, fontSize: 10)
              )
          ),
        ),
      ],
    );
  }

  Widget _details(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ChannelImage(channelUrl: stream.uploaderUrl, heroId: stream.id!, channelName: stream.uploaderName ?? '', highQuality: true, onTap: () {
          UiUtils.pushRouteAsync(context, ChannelPage(infoItem: ChannelInfoItem(
              stream.uploaderUrl,
              stream.uploaderName,
              '', '', null, -1
          )));
        }),
        const SizedBox(width: 12),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${stream.name}",
                  maxLines: 2,
                  style: smallTextStyle(context).copyWith(fontWeight: FontWeight.w500),
                ),
                Text(
                  "${stream.uploaderName}  •  ${stream.viewCount != -1 ? "${NumberFormat.compact().format(stream.viewCount)} ${Languages.of(context)!.labelViews}" : ""}"
                      " ${stream.uploadDate == null ? "" : " ${stream.uploadDate!}"}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: tinyTextStyle(context, opacity: 0.8).copyWith(fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
        ),
        Semantics(
          label: Languages.of(context)!.labelMore,
          child: IconButton(
              onPressed: isEditable ? () {
                UiUtils.showInfoItemOptions(stream, onDelete: onDelete);
              } : null,
              icon: Icon(Icons.more_vert,
                  size: 20, color: Theme.of(context).iconTheme.color!.withOpacity(0.8))),
        )
      ],
    );
  }
}