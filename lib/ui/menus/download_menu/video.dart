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
import 'package:songtube/internal/models/stream_segment_track.dart';
import 'package:songtube/languages/languages.dart';
import 'package:songtube/providers/download_provider.dart';
import 'package:songtube/ui/sheet_phill.dart';
import 'package:songtube/ui/text_styles.dart';

class VideoDownloadMenu extends StatefulWidget {
  final YoutubeVideo video;
  final Function() onBack;
  const VideoDownloadMenu({
    required this.video,
    required this.onBack,
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
  VideoOnlyStream? selectedVideoStream;

  // Default Tags
  late AudioTags tags = AudioTags.withStreamInfoItem(widget.video.toStreamInfoItem());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20)
      ),
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.only(top: 12),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Align(
            alignment: Alignment.center,
            child: BottomSheetPhill()),
            // Menu Title
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: widget.onBack,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.arrow_back_ios_new_rounded, color: Theme.of(context).iconTheme.color),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(Languages.of(context)!.labelVideo, style: textStyle(context)),
                ],
              ),
            ),
            const SizedBox(height: 12),
            // Video Preview
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: SizedBox(
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
            ),
            const SizedBox(height: 12),
            // Quality Selection
            SizedBox(
              height: MediaQuery.of(context).size.height*0.5,
              child: FutureBuilder<int?>(
                future: ExtractorHttpClient.getContentLength(widget.video.audioWithHighestQuality!.url!),
                builder: (context, audioStreamData) {
                  return GroupedListView<VideoOnlyStream, String>(
                    physics: const BouncingScrollPhysics(),
                    stickyHeaderBackgroundColor: Theme.of(context)
                      .scaffoldBackgroundColor,
                    elements: widget.video.videoOnlyStreams!,
                    groupBy: (element) => ("${element.resolution!.split("p").first}p"),
                    groupSeparatorBuilder: (String groupByValue) =>
                      Container(
                        padding: const EdgeInsets.only(
                          top: 8, bottom: 8,
                          left: 16, right: 16
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                        ),
                        child: Row(
                          children: [
                            Text(
                              groupByValue,
                              style: smallTextStyle(context, bold: true)
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
                              ? Theme.of(context).primaryColor.withOpacity(0.2)
                              : Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(20)
                          ),
                          margin: const EdgeInsets.only(left: 12, right: 12),
                          padding: const EdgeInsets.only(left: 12, right: 12),
                          child: Row(
                            children: [
                              Icon(Iconsax.video, size: 24, color: Theme.of(context).primaryColor),
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
                                    style: subtitleTextStyle(context, bold: true)
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
                                        style: tinyTextStyle(context)
                                      );
                                    }
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 12, right: 16),
                                child: framerate > 50
                                ? Text(
                                    "$framerate FPS",
                                    textAlign: TextAlign.center,
                                    style: smallTextStyle(context, bold: true).copyWith(color: Theme.of(context).primaryColor)
                                  ) : Container(),
                              ),
                              const Spacer(),
                              RoundCheckBox(
                                checkedWidget: const Icon(LineIcons.check, size: 14, color: Colors.white),
                                checkedColor: Theme.of(context).primaryColor,
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
            GestureDetector(
              onTap: () => selectedVideoStream != null ? onDownload(selectedVideoStream!) : null,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                decoration: BoxDecoration(
                  color: selectedVideoStream != null
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(20)
                ),
                padding: const EdgeInsets.only(top: 16, bottom: 16),
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      Languages.of(context)!.labelDownload,
                      style: textStyle(context).copyWith(color: Colors.white)
                    ),
                    const SizedBox(width: 4),
                    const Icon(EvaIcons.downloadOutline,
                      size: 28,
                      color: Colors.white)
                  ],
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).viewInsets.bottom,
            )
          ],
        ),
      ),
    );
  }
}