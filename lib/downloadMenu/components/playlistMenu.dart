import 'dart:io';
import 'dart:ui';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:newpipeextractor_dart/models/infoItems/video.dart';
import 'package:provider/provider.dart';
import 'package:songtube/internal/download/audioFilters.dart';
import 'package:songtube/internal/download/downloadItem.dart';
import 'package:songtube/internal/download/downloadSet.dart';
import 'package:songtube/internal/download/tags.dart';
import 'package:songtube/internal/ffmpeg/converter.dart';
import 'package:songtube/internal/languages.dart';
import 'package:songtube/internal/models/streamSegmentTrack.dart';
import 'package:songtube/internal/models/tagsControllers.dart';
import 'package:songtube/provider/configurationProvider.dart';
import 'package:string_validator/string_validator.dart';
import 'package:transparent_image/transparent_image.dart';

enum _PlaylistMenuDownloadType { Video, Audio }

class PlaylistDownloadMenu extends StatefulWidget {
  final List<StreamInfoItem> playlistStreams;
  final Function(List<DownloadItem>) onDownload;
  final Function onBack;
  PlaylistDownloadMenu({
    @required this.playlistStreams,
    @required this.onDownload,
    @required this.onBack
  });
  @override
  _PlaylistDownloadMenuState createState() => _PlaylistDownloadMenuState();
}

class _PlaylistDownloadMenuState extends State<PlaylistDownloadMenu> {

  // Current list of DownloadItems
  List<DownloadItem> downloadItems = [];

  // Enabled/Disabled videos for Download
  List<bool> enabledVideos = [];

  // Default quality for downloading videos
  String videosQuality = "720";

  void changeDownloadTypeAllStreams(_PlaylistMenuDownloadType type) {
    if (type == _PlaylistMenuDownloadType.Video) {
      for (int i = 0; i < downloadItems.length; i++) {
        downloadItems[i].downloadPath = Provider.of<ConfigurationProvider>
          (context, listen: false).videoDownloadPath;
        downloadItems[i].downloadType = DownloadType.VIDEO;
        downloadItems[i].ffmpegTask = FFmpegTask.AppendAudioOnVideo;
      }
    } else {
      for (int i = 0; i < downloadItems.length; i++) {
        downloadItems[i].downloadPath = Provider.of<ConfigurationProvider>
          (context, listen: false).audioDownloadPath;
        downloadItems[i].downloadType = DownloadType.AUDIO;
        downloadItems[i].ffmpegTask = FFmpegTask.NONE;
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    widget.playlistStreams.forEach((element) {
      TagsControllers tags = TagsControllers();
      tags.updateTextControllersFromStream(element);
      downloadItems.add(DownloadItem(
        url: element.url,
        tags: DownloadTags(
          title: tags.titleController.text,
          album: tags.albumController.text,
          artist: tags.artistController.text,
          genre: tags.genreController.text,
          coverurl: tags.artworkController,
          date: tags.dateController.text,
          track: tags.trackController.text,
          disc: tags.discController.text
        ),
        downloadQuality: videosQuality,
        ffmpegTask: FFmpegTask.NONE,
        downloadPath: Provider.of<ConfigurationProvider>(context, listen: false)
          .audioDownloadPath,
        downloadType: DownloadType.AUDIO,
        duration: element.duration,
        filters: AudioFilters(),
        isDownloadSegmented: false,
        segmentTracks: <StreamSegmentTrack>[]
      ));
      enabledVideos.add(true);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Menu Title
        Container(
          margin: EdgeInsets.only(
            top: 16,
            left: 8,
            right: 8,
            bottom: 16
          ),
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back_ios_new_rounded),
                onPressed: widget.onBack
              ),
              SizedBox(width: 4),
              Text(Languages.of(context).labelPlaylist, style: TextStyle(
                fontSize: 24,
                fontFamily: "Product Sans",
                fontWeight: FontWeight.w600
              )),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: downloadItems.length,
            itemBuilder: (context, index) {
              DownloadItem item = downloadItems[index];
              bool isEnabled = enabledVideos[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: GestureDetector(
                  onTap: () {
                    setState(() =>
                      enabledVideos[index] = !enabledVideos[index]);
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(width: 16),
                        SizedBox(
                          height: 110,
                          width: 110,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              AspectRatio(
                                aspectRatio: 1,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: ColorFiltered(
                                    colorFilter: isEnabled
                                      ? ColorFilter.mode(
                                          Colors.transparent,
                                          BlendMode.multiply
                                        )
                                      : ColorFilter.mode(
                                          Colors.grey,
                                          BlendMode.saturation
                                        ),
                                    child: Transform.scale(
                                      scale: 1.4,
                                      child: FadeInImage(
                                        fadeInDuration: Duration(milliseconds: 300),
                                        placeholder: MemoryImage(kTransparentImage),
                                        image: isURL(item.tags.coverurl)
                                          ? NetworkImage(item.tags.coverurl)
                                          : FileImage(File(item.tags.coverurl)),
                                          fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Container(
                                  padding: EdgeInsets.all(4),
                                  margin: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(50)
                                  ),
                                  child: Icon(
                                    isEnabled
                                      ? MdiIcons.downloadOutline
                                      : MdiIcons.downloadOffOutline,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(height: 8),
                              Text(
                                item.tags.title,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  color: Theme.of(context).textTheme
                                    .bodyText1.color
                                ),
                                overflow: TextOverflow.clip,
                                maxLines: 2,
                              ),
                              SizedBox(height: 4),
                              Text(
                                item.tags.artist,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context).textTheme
                                    .bodyText1.color.withOpacity(0.8),
                                  fontWeight: FontWeight.w600
                                ),
                                overflow: TextOverflow.clip,
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(50)
                          ),
                          child: IconButton(
                            icon: Icon(
                              item.downloadType == DownloadType.VIDEO
                                ? EvaIcons.videoOutline
                                : EvaIcons.musicOutline,
                              color: Theme.of(context).iconTheme.color
                            ),
                            onPressed: () {
                              if (downloadItems[index].downloadType == DownloadType.VIDEO) {
                                downloadItems[index].downloadPath = Provider.of<ConfigurationProvider>
                                  (context, listen: false).audioDownloadPath;
                                downloadItems[index].downloadType = DownloadType.AUDIO;
                                downloadItems[index].ffmpegTask = FFmpegTask.NONE;
                              } else {
                                downloadItems[index].downloadPath = Provider.of<ConfigurationProvider>
                                  (context, listen: false).videoDownloadPath;
                                downloadItems[index].downloadType = DownloadType.VIDEO;
                                downloadItems[index].ffmpegTask = FFmpegTask.AppendAudioOnVideo;
                              }
                              setState(() {
                                
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Divider(
          height: 1,
          thickness: 1,
          color: Colors.grey[600].withOpacity(0.1),
          indent: 12,
          endIndent: 12
        ),
        Container(
          padding: EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  Languages.of(context).labelGlobalParameters,
                  style: TextStyle(
                    fontFamily: 'Product Sans',
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).textTheme.bodyText1.color
                      .withOpacity(0.8)
                  ),
                )
              ),
              Container(
                margin: EdgeInsets.only(top: 8),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(50)
                      ),
                      child: IconButton(
                        icon: Icon(EvaIcons.musicOutline),
                        onPressed: () => changeDownloadTypeAllStreams(
                          _PlaylistMenuDownloadType.Audio
                        )
                      ),
                    ),
                    SizedBox(width: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(50)
                      ),
                      child: IconButton(
                        icon: Icon(EvaIcons.videoOutline),
                        onPressed: () => changeDownloadTypeAllStreams(
                          _PlaylistMenuDownloadType.Video
                        )
                      ),
                    ),
                    SizedBox(width: 12),
                    DropdownButton(
                      value: videosQuality,
                      items: List.generate(_qualityList.length, (index) =>
                        DropdownMenuItem(
                          child: Text(_qualityList[index]+"p",
                            style: TextStyle(color: Theme.of(context)
                              .textTheme.bodyText1.color,
                            fontFamily: 'Product Sans',
                            fontWeight: FontWeight.w600
                          )),
                        value: _qualityList[index],
                      )),
                      onChanged: (String quality) {
                        for (int i = 0; i < downloadItems.length; i++) {
                          downloadItems[i].downloadQuality = quality;
                        }
                        setState(() => videosQuality = quality);
                      },
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        List<DownloadItem> items = [];
                        for (int i = 0; i < downloadItems.length; i++) {
                          if (enabledVideos[i])
                            items.add(downloadItems[i]);
                        }
                        widget.onDownload(items);
                      },
                      borderRadius: BorderRadius.circular(15),
                      child: Ink(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(100)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              Languages.of(context).labelDownloadAll,
                              style: TextStyle(
                                fontFamily: 'Product Sans',
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: Theme.of(context).textTheme.bodyText1.color
                                  .withOpacity(0.8)
                              ),
                            ),
                            SizedBox(width: 4),
                            Icon(EvaIcons.cloudDownloadOutline,
                              color: Theme.of(context).accentColor)
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  List<String> get _qualityList {
    return [
      "2560",
      "1440",
      "1080",
      "720",
      "480",
      "360",
      "240",
      "144"
    ];
  }

}