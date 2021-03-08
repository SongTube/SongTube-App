import 'package:newpipeextractor_dart/extractors/channels.dart';
import 'package:newpipeextractor_dart/models/channel.dart';
import 'package:newpipeextractor_dart/models/infoItems/video.dart';
import 'package:newpipeextractor_dart/models/video.dart';
import 'package:songtube/internal/models/tagsControllers.dart';

enum MediaInfoSetType { Video, Playlist }

class MediaInfoSet {

  MediaInfoSetType mediaType;
  dynamic infoItem;
  dynamic youtubeInfoItem;
  YoutubeChannel channel;
  TagsControllers mediaTags;
  List<StreamInfoItem> relatedVideos;
  int autoPlayIndex;

  MediaInfoSet({
    this.mediaType,
    this.infoItem,
    this.relatedVideos
  }) {
    mediaTags = TagsControllers();
    relatedVideos = this.relatedVideos ?? <StreamInfoItem>[];
    autoPlayIndex = 0;
  }

  void updateTagsDetails() {
    if (youtubeInfoItem is YoutubeVideo) {
      mediaTags.updateTextControllers(youtubeInfoItem);
    } else {
      mediaTags.updateTextControllersFromPlaylist(youtubeInfoItem);
    }
  }

  Future<void> getChannel() async {
    channel = await ChannelExtractor.channelInfo(infoItem.uploaderUrl);
  }

}