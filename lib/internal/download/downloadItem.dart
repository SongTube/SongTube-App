import 'package:flutter/material.dart';
import 'package:newpipeextractor_dart/models/streams/audioOnlyStream.dart';
import 'package:newpipeextractor_dart/models/streams/videoOnlyStream.dart';
import 'package:newpipeextractor_dart/models/video.dart';
import 'package:songtube/internal/ffmpeg/converter.dart';
import 'package:songtube/internal/download/audioFilters.dart';
import 'package:songtube/internal/download/downloadSet.dart';
import 'package:songtube/internal/download/tags.dart';
import 'package:songtube/internal/models/tagsControllers.dart';
import 'package:songtube/provider/configurationProvider.dart';

class DownloadItem {

  // Class initializers
  String url;
  DownloadType downloadType;
  VideoOnlyStream videoStream;
  AudioOnlyStream audioStream;
  FFmpegTask ffmpegTask;
  AudioFilters filters;
  DownloadTags tags;
  String downloadPath;
  String formatSuffix;
  String downloadQuality;
  int duration;

  String get finalPath {
    String path = "$downloadPath/${tags.title}";
    switch (ffmpegTask) {
      case FFmpegTask.NONE:
        path += ".$formatSuffix";
        break;
      case FFmpegTask.AppendAudioOnVideo:
        path += ".$formatSuffix";
        break;
      case FFmpegTask.ConvertToAAC:
        path += ".m4a";
        break;
      case FFmpegTask.ConvertToMP3:
        path += ".m4a";
        break;
      case FFmpegTask.ConvertToOGG:
        path += ".ogg";
        break;
      case FFmpegTask.ConvertToOGGVorbis:
        path += ".ogg";
        break;
    }
    return path;
  }

  // Callbacks

  DownloadItem({
    @required this.url,
    @required this.downloadType,
    this.videoStream,
    this.audioStream,
    @required this.ffmpegTask,
    @required this.tags,
    @required this.downloadPath,
    this.formatSuffix,
    @required this.downloadQuality,
    this.filters,
    @required this.duration
  });

  static DownloadItem fetchData(YoutubeVideo video, dynamic configList, TagsControllers tags, ConfigurationProvider config) {
    DownloadType downloadType = configList[0] == "Audio"
      ? DownloadType.AUDIO : DownloadType.VIDEO;
    VideoOnlyStream videoStream = downloadType == DownloadType.VIDEO
      ? configList[1] : null;
    AudioOnlyStream audioStream = downloadType == DownloadType.VIDEO
      ? video.getAudioStreamWithBestMatchForVideoStream(videoStream)
      : configList[1];
    String downloadPath = downloadType == DownloadType.VIDEO
      ? config.videoDownloadPath : config.audioDownloadPath;
    DownloadTags downloadTags = DownloadTags(
      title: removeToxicSymbols(tags.titleController.text),
      album: tags.albumController.text,
      artist: tags.artistController.text
        .replaceAll("- Topic", "").trim(),
      genre: tags.genreController.text,
      coverurl: tags.artworkController,
      date: tags.dateController.text,
      disc: tags.discController.text,
      track: tags.trackController.text
    );
    String formatSuffix = downloadType == DownloadType.VIDEO
      ? videoStream.formatSuffix : audioStream.formatSuffix;
    FFmpegTask ffmpegTask;
    if (config.ffmpegActionTypeFormat == "AAC")
      ffmpegTask = FFmpegTask.ConvertToAAC;
    if (config.ffmpegActionTypeFormat == "OGG Vorbis")
      ffmpegTask = FFmpegTask.ConvertToOGGVorbis;
    if (config.ffmpegActionTypeFormat == "MP3")
      ffmpegTask = FFmpegTask.ConvertToMP3;
    if (config.enableFFmpegActionType == false)
      ffmpegTask = FFmpegTask.NONE;
    String downloadQuality = downloadType == DownloadType.VIDEO
      ? videoStream.resolution : "";
    return DownloadItem(
      url: video.url,
      downloadType: configList[0] == "Audio"
        ? DownloadType.AUDIO : DownloadType.VIDEO,
      videoStream: videoStream,
      audioStream: audioStream,
      downloadPath: downloadPath,
      tags: downloadTags,
      formatSuffix: formatSuffix,
      ffmpegTask: ffmpegTask,
      filters: AudioFilters(
        volume: double.parse(configList[2]),
        bassGain: int.parse(configList[3]),
        trebleGain: int.parse(configList[4]),
        normalizeAudio: configList[5]
      ),
      downloadQuality: downloadQuality,
      duration: video.length
    );
  }

  static String removeToxicSymbols(String string) {
    return string
      .replaceAll('Container.', '')
      .replaceAll(r'\', '')
      .replaceAll('/', '')
      .replaceAll('*', '')
      .replaceAll('?', '')
      .replaceAll('"', '')
      .replaceAll('<', '')
      .replaceAll('>', '')
      .replaceAll('|', '');
  }

}