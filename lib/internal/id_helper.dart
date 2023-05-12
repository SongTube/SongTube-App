import 'package:newpipeextractor_dart/exceptions/badUrlException.dart';
import 'package:newpipeextractor_dart/newpipeextractor_dart.dart';
import 'package:newpipeextractor_dart/utils/stringChecker.dart';

class IdHelper {

  /// Get ID from any Stream URL, return [null] on failure
  static Future<String?> getIdFromStreamUrl(String url) async {
    if (StringChecker.hasWhiteSpace(url)) {
      throw const BadUrlException("Url is null or contains white space");
    }
    var id = await NewPipeExtractorDart.extractorChannel.invokeMethod(
      'getIdFromStreamUrl', { "streamUrl": url }
    );
    return id['id'] == "" ? null : id['id'];
  }

  /// Get ID from any Playlist URL, return [null] on failure
  static Future<String?> getIdFromPlaylistUrl(String url) async {
    if (StringChecker.hasWhiteSpace(url)) {
      throw const BadUrlException("Url is null or contains white space");
    }
    var id = await NewPipeExtractorDart.extractorChannel.invokeMethod(
      'getIdFromPlaylistUrl', { "playlistUrl": url }
    );
    return id['id'] == "" ? null : id['id'];
  }

  /// Get ID from any Channel URL, return [null] on failure
  static Future<String?> getIdFromChannelUrl(String url) async {
    if (StringChecker.hasWhiteSpace(url)) {
      throw const BadUrlException("Url is null or contains white space");
    }
    var id = await NewPipeExtractorDart.extractorChannel.invokeMethod(
      'getIdFromChannelUrl', { "channelUrl": url }
    );
    return id['id'] == "" ? null : id['id'];
  }

}