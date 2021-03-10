// Flutter
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:newpipeextractor_dart/extractors/videos.dart';
import 'package:newpipeextractor_dart/models/infoItems/video.dart';
import 'package:newpipeextractor_dart/models/video.dart';
import 'package:provider/provider.dart';
import 'package:songtube/downloadMenu/components/homeMenu.dart';
import 'package:songtube/downloadMenu/components/loadingMenu.dart';

// Internal
import 'package:songtube/downloadMenu/components/videoMenu.dart';
import 'package:songtube/downloadMenu/components/audioMenu.dart';
import 'package:songtube/internal/languages.dart';
import 'package:songtube/internal/models/metadata.dart';
import 'package:songtube/internal/models/tagsControllers.dart';
import 'package:songtube/provider/configurationProvider.dart';
import 'package:songtube/provider/downloadsProvider.dart';
import 'package:songtube/ui/internal/snackbar.dart';

enum CurrentDownloadMenu { Home, Audio, Video, Loading }

class DownloadMenu extends StatefulWidget {
  final YoutubeVideo video;
  final TagsControllers tags;
  final String videoUrl;
  final List<StreamInfoItem> relatedVideos;
  final scaffoldState;
  DownloadMenu({
    this.video,
    this.tags,
    this.videoUrl,
    this.scaffoldState,
    this.relatedVideos
  });
  @override
  _DownloadMenuState createState() => _DownloadMenuState();
}

class _DownloadMenuState extends State<DownloadMenu> with TickerProviderStateMixin {

  // Current Download Menu Sub-Menu
  CurrentDownloadMenu currentDownloadMenu;

  // Download Menu StreamManifest
  YoutubeVideo video;
  TagsControllers tags;

  @override
  void initState() {
    currentDownloadMenu =
      CurrentDownloadMenu.Loading;
    super.initState();
    if (widget.video == null) {
      getVideo();
    } else {
      video = widget.video;
      tags = widget.tags;
      setState(() => currentDownloadMenu = CurrentDownloadMenu.Home);
    }
    
  }

  void getVideo() async {
    video = await VideoExtractor.getVideoInfoAndStreams(widget.videoUrl);
    tags = TagsControllers();
    tags.updateTextControllers(video);
    setState(() => currentDownloadMenu = CurrentDownloadMenu.Home);
  }

  Widget build(BuildContext context) {
    return AnimatedSize(
      vsync: this,
      curve: Curves.easeInOut,
      duration: Duration(milliseconds: 200),
      child: _currentDownloadMenuWidget(),
    );
  }

  // Current Menu Widget
  Widget _currentDownloadMenuWidget() {
    Widget returnWidget;
    switch (currentDownloadMenu) {
      case CurrentDownloadMenu.Home:
        returnWidget = DownloadMenuHome(
          playlistVideos: widget.relatedVideos,
          onBack: () => Navigator.pop(context),
          onAudioTap: () => setState(() => 
            currentDownloadMenu = CurrentDownloadMenu.Audio),
          onVideoTap: () => setState(() => 
            currentDownloadMenu = CurrentDownloadMenu.Video),
        ); break;
      case CurrentDownloadMenu.Audio:
        returnWidget = Container(
          child: AudioDownloadMenu(
            video: video,
            onBack: () => setState(() => 
              currentDownloadMenu = CurrentDownloadMenu.Home),
            onDownload: (list) => _initializeDownload(list),
          ),
        ); break;
      case CurrentDownloadMenu.Video:
        returnWidget = Container(
          height: MediaQuery.of(context).size.height*0.6,
          child: VideoDownloadMenu(
            videoList: video.videoOnlyStreams,
            onOptionSelect: (list) => _initializeDownload(list),
            audioStream: video.audioWithBestAacQuality,
            onBack: () => setState(() => 
              currentDownloadMenu = CurrentDownloadMenu.Home),
          ),
        ); break;
      case CurrentDownloadMenu.Loading:
        returnWidget = Container(
          margin: EdgeInsets.only(top: 12, bottom: 12),
          child: LoadingDownloadMenu(),
        ); break;
    }
    return returnWidget;
  }

  void _initializeDownload(dynamic configList) async {
    DownloadsProvider downloadsProvider = Provider.of<DownloadsProvider>(context, listen: false);
    downloadsProvider.handleVideoDownload(
      language: Languages.of(context),
      config: Provider.of<ConfigurationProvider>(context, listen: false),
      metadata: DownloadMetaData(
        title: tags.titleController.text,
        album: tags.albumController.text,
        artist: tags.artistController.text
          .replaceAll("- Topic", "").trim(),
        genre: tags.genreController.text,
        coverurl: tags.artworkController,
        date: tags.dateController.text,
        disc: tags.discController.text,
        track: tags.trackController.text
      ),
      videoDetails: video,
      data: configList
    );
    Navigator.of(context).pop();
    if (widget.scaffoldState != null) {
      AppSnack.showSnackBar(
        icon: EvaIcons.cloudDownloadOutline,
        title: "Download started...",
        message: "${video.name}",
        context: context,
      );
    }
  }

}