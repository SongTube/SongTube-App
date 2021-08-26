import 'package:newpipeextractor_dart/newpipeextractor_dart.dart';
import 'package:songtube/internal/models/tagsControllers.dart';

class StreamSegmentTrack {

  StreamSegment segment;
  TagsControllers tags;
  bool? selected;

  StreamSegmentTrack(this.segment, this.tags, this.selected);

}