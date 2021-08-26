// Internal
import 'package:songtube/internal/models/videoFile.dart';

class FolderItem {

  String? name;
  String? path;
  List<VideoFile>? videos;

  FolderItem({
    this.name,
    this.path,
  }) {
    videos = <VideoFile>[];
  }

}