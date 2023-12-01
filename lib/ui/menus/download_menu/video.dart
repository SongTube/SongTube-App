import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_fade/image_fade.dart';
import 'package:line_icons/line_icons.dart';
import 'package:newpipeextractor_dart/newpipeextractor_dart.dart';
import 'package:newpipeextractor_dart/utils/httpClient.dart';
import 'package:provider/provider.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:songtube/internal/enums/download_type.dart';
import 'package:songtube/internal/models/audio_tags.dart';
import 'package:songtube/internal/models/download/download_info.dart';
import 'package:songtube/languages/languages.dart';
import 'package:songtube/providers/download_provider.dart';
import 'package:songtube/providers/media_provider.dart';
import 'package:songtube/ui/animations/animated_icon.dart';
import 'package:songtube/ui/animations/animated_text.dart';
import 'package:songtube/ui/sheets/common_sheet.dart';
import 'package:songtube/ui/text_styles.dart';

class VideoDownloadMenu extends StatefulWidget {
  final YoutubeVideo video;
  const VideoDownloadMenu({
    required this.video,
    super.key
  });

  @override
  State<VideoDownloadMenu> createState() => _VideoDownloadMenuState();
}

class _VideoDownloadMenuState extends State<VideoDownloadMenu> {

  void onDownload(VideoOnlyStream stream) {
    final downloadInfo = DownloadInfo(
      url: widget.video.videoInfo.url!,
      name: widget.video.videoInfo.name ?? 'Unknown',
      duration: widget.video.videoInfo.length!,
      downloadType: DownloadType.video,
      audioStream: widget.video.getAudioStreamWithBestMatchForVideoStream(stream) ?? widget.video.audioWithHighestQuality!,
      videoStream: stream,
      tags: tags,
    );
    final downloadProvider = Provider.of<DownloadProvider>(context, listen: false);
    downloadProvider.handleDownloadItem(info: downloadInfo);
    Navigator.pop(context);
  }

  // Selected Video Stream
  late VideoOnlyStream? selectedVideoStream = widget.video.videoOnlyWithHighestQuality;

  // Default Tags
  late AudioTags tags = AudioTags.withStreamInfoItem(widget.video.toStreamInfoItem());

  @override
  Widget build(BuildContext context) {
    MediaProvider mediaProvider = Provider.of(context);
    return CommonSheet(
      useMaxSize: true,
      builder: (context, scrollController) {
        return Padding(
          padding: const EdgeInsets.all(12).copyWith(top: 0),
          child: Column(
            children: [
              // Menu Title
              Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const AppAnimatedIcon(Iconsax.arrow_left, size: 22)
                    ),
                    const SizedBox(width: 12),
                    Expanded(child: Text(Languages.of(context)!.labelVideo, style: textStyle(context, bold: false))),
                  ],
                ),
              const SizedBox(height: 12),
              // Video Preview
              SizedBox(
                height: 90,
                child: Row(
                  children: [
                    AspectRatio(
                      aspectRatio: 1/1,
                      child: Stack(
                        fit: StackFit.passthrough,
                        alignment: Alignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 12,
                                  color: Colors.black.withOpacity(0.3)
                                )
                              ]
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: ImageFade(
                                fadeDuration: const Duration(milliseconds: 300),
                                placeholder: Container(color: Theme.of(context).cardColor),
                                image: NetworkImage(widget.video.videoInfo.thumbnailUrl!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      )
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8, left: 12, right: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.video.videoInfo.name ?? 'Unknown',
                              style: subtitleTextStyle(context),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              widget.video.videoInfo.uploaderName ?? 'Unknown',
                              style: smallTextStyle(context, opacity: 0.7),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              // Quality Selection
              Expanded(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height*0.5,
                  child: FutureBuilder<int?>(
                    future: ExtractorHttpClient.getContentLength(widget.video.audioWithHighestQuality!.url!),
                    builder: (context, audioStreamData) {
                      return GroupedListView<VideoOnlyStream, String>(
                        stickyHeaderBackgroundColor: Theme.of(context)
                          .cardColor,
                        elements: widget.video.videoOnlyStreams!,
                        groupBy: (element) => ("${element.resolution!.split("p").first}p"),
                        groupSeparatorBuilder: (String groupByValue) =>
                          Container(
                            padding: const EdgeInsets.only(
                              top: 8, bottom: 8,
                              left: 12, right: 12
                            ),
                            margin: const EdgeInsets.only(top: 8, bottom: 0),
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(100)
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  groupByValue,
                                  style: smallTextStyle(context).copyWith(fontWeight: FontWeight.bold)
                                ),
                              ],
                            ),
                          ),
                        useStickyGroupSeparators: true,
                        order: GroupedListOrder.DESC,
                        groupComparator: (item1, item2) =>
                          int.parse(item1.split("p").first)
                          .compareTo(int.parse(item2.split("p").first)),
                        itemBuilder: (context, VideoOnlyStream element) {
                          String framerateString = element.resolution!.split("p").last;
                          int framerate = int.parse(
                            framerateString == "" ? "30" : framerateString
                          );
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedVideoStream = element;
                              });
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 100),
                              height: 80,
                              decoration: BoxDecoration(
                                color: selectedVideoStream == element 
                                  ? mediaProvider.currentColors.vibrant?.withOpacity(0.07)
                                  : null,
                                borderRadius: BorderRadius.circular(20)
                              ),
                              margin: const EdgeInsets.only(top: 8, left: 12, right: 12),
                              padding: const EdgeInsets.only(left: 12, right: 12),
                              child: Row(
                                children: [
                                  const AppAnimatedIcon(EvaIcons.videoOutline, size: 22),
                                  const SizedBox(width: 12),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        element.formatSuffix!.toUpperCase(),
                                        overflow: TextOverflow.fade,
                                        textAlign: TextAlign.left,
                                        softWrap: false,
                                        style: subtitleTextStyle(context).copyWith(fontSize: 14)
                                      ),
                                      FutureBuilder<int?>(
                                        future: ExtractorHttpClient.getContentLength(element.url!),
                                        builder: (context, snapshot) {
                                          return Text(
                                            snapshot.hasData && audioStreamData.hasData && (snapshot.data != null && audioStreamData.data != null)
                                              ? "${((snapshot.data!/1024)/1024 + (audioStreamData.data!/1024)/1024).toStringAsFixed(2)} MB"
                                              : Languages.of(context)!.labelLoading,
                                            overflow: TextOverflow.fade,
                                            textAlign: TextAlign.left,
                                            softWrap: false,
                                            style: smallTextStyle(context, opacity: 0.6).copyWith(fontSize: 12)
                                          );
                                        }
                                      ),
                                    ],
                                  ),
                                  if (framerate > 50)
                                  Container(
                                    margin: const EdgeInsets.only(left: 12),
                                    padding: const EdgeInsets.only(left: 12, right: 12, top: 6, bottom: 6),
                                    decoration: BoxDecoration(
                                      color: mediaProvider.currentColors.vibrant?.withOpacity(0.07),
                                      borderRadius: BorderRadius.circular(100)
                                    ),
                                    child: AnimatedText(
                                      "$framerate FPS",
                                      auto: true,
                                      textAlign: TextAlign.center,
                                      style: smallTextStyle(context).copyWith(fontSize: 12)
                                    )
                                  ),
                                  const Spacer(),
                                  RoundCheckBox(
                                    checkedWidget: const Icon(LineIcons.check, size: 14, color: Colors.white),
                                    checkedColor: mediaProvider.currentColors.vibrant,
                                    borderColor: Theme.of(context).dividerColor,
                                    isChecked: selectedVideoStream == element, size: 24, onTap: (_) {
                                    setState(() {
                                      selectedVideoStream = element;
                                    });
                                  }),
                                ],
                              )
                            ),
                          );
                        }
                      );
                    }
                  ),
                ),
              ),
              Consumer<MediaProvider>(
                builder: (context, provider, _) {
                  return GestureDetector(
                    onTap: () => selectedVideoStream != null ? onDownload(selectedVideoStream!) : null,
                    child: Container(
                      decoration: BoxDecoration(
                        color: provider.currentColors.vibrant?.withOpacity(0.07),
                        borderRadius: BorderRadius.circular(15)
                      ),
                      padding: const EdgeInsets.only(top: 16, bottom: 16),
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AnimatedText(
                            Languages.of(context)!.labelDownload,
                            style: subtitleTextStyle(context).copyWith(),
                            auto: true
                          ),
                          const SizedBox(width: 4),
                          const AppAnimatedIcon(EvaIcons.downloadOutline,
                            size: 24)
                        ],
                      ),
                    ),
                  );
                }
              ),
              Container(
                height: MediaQuery.of(context).viewInsets.bottom,
              )
            ],
          ),
        );
      }
    );
  }
}