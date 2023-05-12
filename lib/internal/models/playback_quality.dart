// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:newpipeextractor_dart/models/video.dart';

class VideoPlaybackQuality {

  VideoPlaybackQuality({
    required this.resolution,
    required this.format,
    required this.framerate,
    this.videoUrl,
    this.audioUrl
  });

  final String? videoUrl;
  final String? audioUrl;
  final String resolution;
  final String format;
  final double framerate;

  // Fetch a list of video only qualities from a YoutubeVideo
  static List<VideoPlaybackQuality> fetchAllVideoOnlyQuality(YoutubeVideo video) {
    final streams = video.videoOnlyStreams!.where((element) => element.formatSuffix!.contains('webm')).toList();
    return List.generate(streams.length, (index) {
      final stream = streams[index];
      final fullres = stream.resolution!.split('p');
      final res = fullres.first;
      final frames = fullres.last.isNotEmpty ? double.parse(stream.resolution!.split('p').last) : 30.0;
      return VideoPlaybackQuality(resolution: res, framerate: frames.toDouble(), format: stream.formatSuffix!, videoUrl: stream.url, audioUrl: video.audioWithHighestQuality!.url);
    });
  }

  // Fetch a list of video qualities from a YoutubeVideo
  static List<VideoPlaybackQuality> fetchAllVideoQuality(YoutubeVideo video) {
    final streams = video.videoStreams;
    return List.generate(streams!.length, (index) {
      final stream = streams[index];
      final fullres = stream.resolution!.split('p');
      final res = fullres.first;
      final frames = fullres.last.isNotEmpty ? double.parse(stream.resolution!.split('p').last) : 30.0;
      return VideoPlaybackQuality(resolution: res, framerate: frames.toDouble(), format: stream.formatSuffix!, videoUrl: stream.url);
    });
  }

  VideoPlaybackQuality copyWith({
    String? resolution,
    String? format,
    double? framerate,
  }) {
    return VideoPlaybackQuality(
      resolution: resolution ?? this.resolution,
      format: format ?? this.format,
      framerate: framerate ?? this.framerate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'resolution': resolution,
      'format': format,
      'framerate': framerate,
    };
  }

  factory VideoPlaybackQuality.fromMap(Map<String, dynamic> map) {
    return VideoPlaybackQuality(
      resolution: map['resolution'] as String,
      format: map['format'] as String,
      framerate: map['framerate'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory VideoPlaybackQuality.fromJson(String source) => VideoPlaybackQuality.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'VideoPlaybackQuality(resolution: $resolution, format: $format, framerate: $framerate)';

  @override
  bool operator ==(covariant VideoPlaybackQuality other) {
    if (identical(this, other)) return true;
  
    return 
      other.resolution == resolution &&
      other.format == format &&
      other.framerate == framerate;
  }

  @override
  int get hashCode => resolution.hashCode ^ format.hashCode ^ framerate.hashCode;
}
