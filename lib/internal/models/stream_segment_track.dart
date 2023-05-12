import 'package:newpipeextractor_dart/models/streamSegment.dart';
import 'package:songtube/internal/models/audio_tags.dart';

class StreamSegmentTrack {

  StreamSegmentTrack({
    required this.segment,
    required this.audioTags,
    this.enabled = true
  });

  final StreamSegment segment;
  AudioTags audioTags;
  bool enabled;

}