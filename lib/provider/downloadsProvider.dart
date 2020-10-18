import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:songtube/internal/ffmpeg/converter.dart';
import 'package:songtube/internal/models/audioModifiers.dart';
import 'package:songtube/internal/models/downloadinfoset.dart';
import 'package:songtube/internal/models/metadata.dart';
import 'package:songtube/internal/models/songFile.dart';
import 'package:songtube/internal/randomString.dart';
import 'package:songtube/internal/services/databaseService.dart';
import 'package:songtube/provider/app_provider.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class DownloadsProvider extends ChangeNotifier {

  DownloadsProvider() {
    listDownloads = new List<DownloadInfoSet>();
    databaseSongs = new List<MediaItem>();
    getDatabase();
  }

  // List Songs on Database
  List<MediaItem> databaseSongs;

  // List Current Downloads
  List<DownloadInfoSet> listDownloads;

  // --------
  // Database
  // --------
  final dbHelper = DatabaseService.instance;
  Future<void> getDatabase() async {
    List<SongFile> tmp = await dbHelper.getDownloadList();
    databaseSongs = convertToMediaItem(tmp);
    notifyListeners();
  }

  // Add new Download to List and Start Downloading
  void addNewDownload(DownloadInfoSet download) {
    listDownloads.add(download);
    listDownloads.last.downloadMedia();
    notifyListeners();
  }

  // Handle Single Video Download
  void handleVideoDownload({
    AppDataProvider currentAppData,
    DownloadMetaData metadata,
    StreamManifest manifest,
    Video videoDetails,
    List data,
  }) {
    DownloadType downloadType;
    AudioConvert convertFormat;
    if (currentAppData.audioConvertFormat == "AAC") convertFormat = AudioConvert.ToAAC;
    if (currentAppData.audioConvertFormat == "OGG Vorbis") convertFormat = AudioConvert.ToOGGVorbis;
    if (currentAppData.audioConvertFormat == "MP3") convertFormat = AudioConvert.ToMP3;
    if (currentAppData.enableAudioConvertion == false) convertFormat = AudioConvert.NONE;
    String downloadPath;
    StreamInfo audioStreamInfo;
    StreamInfo videoStreamInfo;
    switch (data[0]) {
      case "Audio":
        downloadType = DownloadType.AUDIO;
        downloadPath = currentAppData.audioDownloadPath;
        audioStreamInfo = manifest.audioOnly.withHighestBitrate();
        break;
      case "Video":
        downloadType = DownloadType.VIDEO;
        videoStreamInfo = data[1];
        audioStreamInfo = manifest.audioOnly.withHighestBitrate();
        downloadPath = currentAppData.videoDownloadPath;
        convertFormat = AudioConvert.WriteAudio;
        break;
    }
    metadata.title = removeToxicSymbols(metadata.title);
    DownloadInfoSet download = new DownloadInfoSet(
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
      downloadGroup: RandomString.getRandomString(6)
    );
    addNewDownload(download);
  }

  // Handle Playlist Downloads
  void handlePlaylistDownload({
    AppDataProvider currentAppData,
    List<Video> listVideos,
    String album, String artist
  }) {
    int track = 1;
    AudioConvert convertFormat;
    if (currentAppData.audioConvertFormat == "AAC") convertFormat = AudioConvert.ToAAC;
    if (currentAppData.audioConvertFormat == "OGG Vorbis") convertFormat = AudioConvert.ToOGGVorbis;
    if (currentAppData.audioConvertFormat == "MP3") convertFormat = AudioConvert.ToMP3;
    if (currentAppData.enableAudioConvertion == false) convertFormat = AudioConvert.NONE;
    String downloadGroup = RandomString.getRandomString(10);
    listVideos.forEach((video) {
      addNewDownload(
        new DownloadInfoSet(
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
          downloadGroup: downloadGroup
        )
      );
      track++;
    });
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
            "downloadType": element.downloadType
          }
        )
      );
    });
    return list;
  }

}