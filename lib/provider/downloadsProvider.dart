import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:songtube/internal/ffmpeg/converter.dart';
import 'package:songtube/internal/languages.dart';
import 'package:songtube/internal/models/audioModifiers.dart';
import 'package:songtube/internal/models/downloadinfoset.dart';
import 'package:songtube/internal/models/metadata.dart';
import 'package:songtube/internal/models/songFile.dart';
import 'package:songtube/internal/randomString.dart';
import 'package:songtube/internal/database/databaseService.dart';
import 'package:songtube/provider/configurationProvider.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class DownloadsProvider extends ChangeNotifier {

  DownloadsProvider() {
    queueList = new List<DownloadInfoSet>();
    downloadingList = new List<DownloadInfoSet>();
    convertingList = new List<DownloadInfoSet>();
    completedList = new List<DownloadInfoSet>();
    cancelledList = new List<DownloadInfoSet>();
    databaseSongs = new List<MediaItem>();
    getDatabase();
  }

  // List Songs on Database
  List<MediaItem> databaseSongs;

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

  // --------
  // Database
  // --------
  final dbHelper = DatabaseService.instance;
  Future<void> getDatabase() async {
    List<SongFile> tmp = await dbHelper.getDownloadList();
    databaseSongs = convertToMediaItem(tmp);
    notifyListeners();
  }

  // Handle Single Video Download
  void handleVideoDownload({
    @required Languages language,
    ConfigurationProvider currentAppData,
    DownloadMetaData metadata,
    StreamManifest manifest,
    Video videoDetails,
    List data,
  }) {
    DownloadType downloadType;
    FFmpegActionType convertFormat;
    if (currentAppData.ffmpegActionTypeFormat == "AAC")
      convertFormat = FFmpegActionType.ConvertToAAC;
    if (currentAppData.ffmpegActionTypeFormat == "OGG Vorbis")
      convertFormat = FFmpegActionType.ConvertToOGGVorbis;
    if (currentAppData.ffmpegActionTypeFormat == "MP3")
      convertFormat = FFmpegActionType.ConvertToMP3;
    if (currentAppData.enableFFmpegActionType == false)
      convertFormat = FFmpegActionType.NONE;
    String downloadPath;
    StreamInfo audioStreamInfo;
    StreamInfo videoStreamInfo;
    switch (data[0]) {
      case "Audio":
        downloadType = DownloadType.AUDIO;
        downloadPath = currentAppData.audioDownloadPath;
        audioStreamInfo = data[1];
        break;
      case "Video":
        downloadType = DownloadType.VIDEO;
        videoStreamInfo = data[1];
        audioStreamInfo = manifest.audioOnly.withHighestBitrate();
        downloadPath = currentAppData.videoDownloadPath;
        convertFormat = FFmpegActionType.AppendAudioOnVideo;
        break;
    }
    metadata.title = removeToxicSymbols(metadata.title);
    DownloadInfoSet download = new DownloadInfoSet(
      language: language,
      audioStreamInfo: audioStreamInfo,
      videoStreamInfo: videoStreamInfo,
      videoDetails: videoDetails,
      metadata: metadata,
      downloadType: downloadType,
      downloadPath: currentAppData.enableAlbumFolder
        ? downloadPath + "/${metadata.album}"
        : downloadPath,
      convertFormat: convertFormat,
      audioModifiers: AudioModifiers(
        volume: double.parse(data[2]),
        bassGain: int.parse(data[3]),
        trebleGain: int.parse(data[4])
      ),
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
    ConfigurationProvider currentAppData,
    List<Video> listVideos,
    String album, String artist
  }) {
    int track = 1;
    FFmpegActionType convertFormat;
    if (currentAppData.ffmpegActionTypeFormat == "AAC")
      convertFormat = FFmpegActionType.ConvertToAAC;
    if (currentAppData.ffmpegActionTypeFormat == "OGG Vorbis")
      convertFormat = FFmpegActionType.ConvertToOGGVorbis;
    if (currentAppData.ffmpegActionTypeFormat == "MP3")
      convertFormat = FFmpegActionType.ConvertToMP3;
    if (currentAppData.enableFFmpegActionType == false)
      convertFormat = FFmpegActionType.NONE;
    listVideos.forEach((video) {
      queueList.add(
        new DownloadInfoSet(
          language: language,
          audioStreamInfo: null,
          videoDetails: video,
          metadata: DownloadMetaData(
            title: removeToxicSymbols(video.title),
            album: album, artist: artist,
            genre: "Any", coverurl: video.thumbnails.mediumResUrl,
            date: "${video.uploadDate.year}/"
            + "${video.uploadDate.month}/"
            + "${video.uploadDate.day}",
            disc: "1", track: "$track"
          ),
          downloadType: DownloadType.AUDIO,
          downloadPath: currentAppData.enableAlbumFolder
            ? currentAppData.audioDownloadPath + "/$album"
            : currentAppData.audioDownloadPath,
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

  // Convert any List<SongFile> to a List<MediaItem>
  List<MediaItem> convertToMediaItem(List<SongFile> songList) {
    List<MediaItem> list = [];
    songList.forEach((SongFile element) {
      int hours = 0;
      int minutes = 0;
      int micros;
      List<String> parts = element.duration.split(':');
      if (parts.length > 2) {
        hours = int.parse(parts[parts.length - 3]);
      }
      if (parts.length > 1) {
        minutes = int.parse(parts[parts.length - 2]);
      }
      micros = (double.parse(parts[parts.length - 1]) * 1000000).round();
      Duration duration = Duration(
        milliseconds: Duration(
          hours: hours,
          minutes: minutes,
          microseconds: micros
        ).inMilliseconds
      );
      list.add(
        new MediaItem(
          id: element.path,
          title: element.title,
          album: element.album,
          artist: element.author,
          artUri: "file://${element.coverPath}",
          duration: duration,
          extras: {
            "downloadType": element.downloadType,
            "artwork": element.coverPath
          }
        )
      );
    });
    return list;
  }

}