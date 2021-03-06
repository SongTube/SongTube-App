import 'package:flutter/material.dart';
import 'package:newpipeextractor_dart/models/infoItems/video.dart';
import 'package:newpipeextractor_dart/models/streams/audioOnlyStream.dart';
import 'package:newpipeextractor_dart/models/streams/videoOnlyStream.dart';
import 'package:newpipeextractor_dart/models/video.dart';
import 'package:songtube/internal/ffmpeg/converter.dart';
import 'package:songtube/internal/languages.dart';
import 'package:songtube/internal/models/audioModifiers.dart';
import 'package:songtube/internal/models/infoSets/downloadinfoset.dart';
import 'package:songtube/internal/models/metadata.dart';
import 'package:songtube/internal/randomString.dart';
import 'package:songtube/provider/configurationProvider.dart';

class DownloadsProvider extends ChangeNotifier {

  DownloadsProvider() {
    queueList = new List<DownloadInfoSet>();
    downloadingList = new List<DownloadInfoSet>();
    convertingList = new List<DownloadInfoSet>();
    completedList = new List<DownloadInfoSet>();
    cancelledList = new List<DownloadInfoSet>();
    
  }

  // Queue List
  List<DownloadInfoSet> queueList;

  // Downloading List
  List<DownloadInfoSet> downloadingList;

  // Converting List
  List<DownloadInfoSet> convertingList;

  // Completed List
  List<DownloadInfoSet> completedList;

  // Cancelled List
  List<DownloadInfoSet> cancelledList;

  // Handle Single Video Download
  void handleVideoDownload({
    @required Languages language,
    ConfigurationProvider config,
    DownloadMetaData metadata,
    YoutubeVideo videoDetails,
    List data,
  }) {
    DownloadType downloadType;
    FFmpegActionType convertFormat;
    if (config.ffmpegActionTypeFormat == "AAC")
      convertFormat = FFmpegActionType.ConvertToAAC;
    if (config.ffmpegActionTypeFormat == "OGG Vorbis")
      convertFormat = FFmpegActionType.ConvertToOGGVorbis;
    if (config.ffmpegActionTypeFormat == "MP3")
      convertFormat = FFmpegActionType.ConvertToMP3;
    if (config.enableFFmpegActionType == false)
      convertFormat = FFmpegActionType.NONE;
    String downloadPath;
    AudioOnlyStream audioStreamInfo;
    VideoOnlyStream videoStreamInfo;
    switch (data[0]) {
      case "Audio":
        downloadType = DownloadType.AUDIO;
        downloadPath = config.audioDownloadPath;
        audioStreamInfo = data[1];
        break;
      case "Video":
        downloadType = DownloadType.VIDEO;
        videoStreamInfo = data[1];
        audioStreamInfo = videoDetails
          .getAudioStreamWithBestMatchForVideoStream(videoStreamInfo);
        downloadPath = config.videoDownloadPath;
        convertFormat = FFmpegActionType.AppendAudioOnVideo;
        break;
    }
    metadata.title = removeToxicSymbols(metadata.title);
    DownloadInfoSet download = new DownloadInfoSet(
      language: language,
      audioStreamInfo: audioStreamInfo,
      videoStreamInfo: videoStreamInfo,
      videoDetails: videoDetails.toStreamInfoItem(),
      metadata: metadata,
      downloadType: downloadType,
      downloadPath: config.enableAlbumFolder
        ? downloadPath + "/${metadata.album}"
        : downloadPath,
      convertFormat: convertFormat,
      audioModifiers: AudioModifiers(
        volume: double.parse(data[2]),
        bassGain: int.parse(data[3]),
        trebleGain: int.parse(data[4])
      ),
      normalizeAudio: data[5],
      downloadId: RandomString.getRandomString(6),
      convertingCallback: (String downloadId) {
        moveToConverting(downloadId);
      },
      completedCallback: (String downloadId, bool converted) {
        moveToCompleted(downloadId, converted);
        checkQueue();
      },
      cancelledCallback: (String downloadId) {
        moveToCancelled(downloadId);
      },
      saveErrorCallback: (String downloadId) {
        moveToCancelled(downloadId);
      }
    );
    queueList.add(download);
    checkQueue();
  }

  // Handle Playlist Downloads
  void handlePlaylistDownload({
    @required Languages language,
    ConfigurationProvider config,
    List<StreamInfoItem> listVideos,
    String album, String artist
  }) {
    int track = 1;
    FFmpegActionType convertFormat;
    if (config.ffmpegActionTypeFormat == "AAC")
      convertFormat = FFmpegActionType.ConvertToAAC;
    if (config.ffmpegActionTypeFormat == "OGG Vorbis")
      convertFormat = FFmpegActionType.ConvertToOGGVorbis;
    if (config.ffmpegActionTypeFormat == "MP3")
      convertFormat = FFmpegActionType.ConvertToMP3;
    if (config.enableFFmpegActionType == false)
      convertFormat = FFmpegActionType.NONE;
    listVideos.forEach((infoItem) {
      queueList.add(
        new DownloadInfoSet(
          language: language,
          audioStreamInfo: null,
          videoDetails: infoItem,
          metadata: DownloadMetaData(
            title: removeToxicSymbols(infoItem.name),
            album: album, artist: artist,
            genre: "Any", coverurl: infoItem.thumbnails.hqdefault,
            date: infoItem.uploadDate,
            disc: "1", track: "$track"
          ),
          downloadType: DownloadType.AUDIO,
          downloadPath: config.enableAlbumFolder
            ? config.audioDownloadPath + "/$album"
            : config.audioDownloadPath,
          convertFormat: convertFormat,
          audioModifiers: AudioModifiers(),
          downloadId: RandomString.getRandomString(6),
          convertingCallback: (String downloadId) {
            moveToConverting(downloadId);
          },
          completedCallback: (String downloadId, bool converted) {
            moveToCompleted(downloadId, converted);
            checkQueue();
          },
          cancelledCallback: (String downloadId) {
            moveToCancelled(downloadId);
          },
          saveErrorCallback: (String downloadId) {
            moveToCancelled(downloadId);
          }
        ),
      );
      track++;
    });
    checkQueue();
  }

  void checkQueue() {
    if (queueList.isNotEmpty && downloadingList.length < 2) {
      DownloadInfoSet download = queueList[0];
      downloadingList.add(download);
      int index = downloadingList.indexWhere((element)
        => element.downloadId == download.downloadId);
      downloadingList[index].downloadMedia();
      queueList.remove(queueList[0]);
      checkQueue();
    }
    notifyListeners();
  }

  void moveToConverting(String id) {
    int index = downloadingList.indexWhere((element)
      => element.downloadId == id);
    convertingList.add(downloadingList[index]);
    downloadingList.removeAt(index);
    checkQueue();
  }

  void moveToCompleted(String id, bool converted) {
    if (converted) {
      int index = convertingList.indexWhere((element)
        => element.downloadId == id);
      completedList.add(convertingList[index]);
      convertingList.removeAt(index);
    } else {
      int index = downloadingList.indexWhere((element)
        => element.downloadId == id);
      completedList.add(downloadingList[index]);
      downloadingList.removeAt(index);
    }
    checkQueue();
  }

  void moveToCancelled(String id) {
    int index = downloadingList.indexWhere((element)
      => element.downloadId == id);
    cancelledList.add(downloadingList[index]);
    downloadingList.removeAt(index);
    checkQueue();
  }

  void retryDownload(String id) {
    int index = cancelledList.indexWhere((element)
      => element.downloadId == id);
    queueList.add(cancelledList[index]);
    cancelledList.removeAt(index);
    checkQueue();
  }

  void cancelDownload(String id) async {
    int index = downloadingList.indexWhere((element)
      => element.downloadId == id);
    downloadingList[index].cancelDownload = true;
    await Future.delayed(Duration(seconds: 2));
    cancelledList.add(downloadingList[index]);
    downloadingList.removeAt(index);
    checkQueue();
  }

  String removeToxicSymbols(String string) {
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