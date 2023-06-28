import 'package:flutter/material.dart';
import 'package:newpipeextractor_dart/models/infoItems/video.dart';
import 'package:songtube/internal/media_utils.dart';
import 'package:songtube/internal/models/music_brainz_record.dart';

class AudioTags {

  AudioTags();

  // Common Controllers
  TextEditingController urlController    = TextEditingController();
  TextEditingController titleController  = TextEditingController();
  TextEditingController albumController  = TextEditingController();
  TextEditingController artistController = TextEditingController();
  TextEditingController genreController  = TextEditingController();
  TextEditingController dateController   = TextEditingController();
  TextEditingController discController   = TextEditingController();
  TextEditingController trackController  = TextEditingController();

  // Artwork Object (Uri, File or Uint8List)
  dynamic artwork;

  // Initialize an AudioTags object with a StreamInfoItem
  factory AudioTags.withStreamInfoItem(StreamInfoItem stream) {
    return AudioTags()
      ..urlController.text    = stream.url ?? ''
      ..titleController.text  = MediaUtils.removeToxicSymbols(stream.name ?? 'Unknown')
      ..albumController.text  = 'Youtube'
      ..artistController.text = stream.uploaderName?.replaceAll("- Topic", "").trim() ?? 'Unknown'
      ..genreController.text  = 'Any'
      ..dateController.text   = stream.uploadDate ?? 'Unknown'
      ..discController.text   = '1'
      ..trackController.text  = '1'
      ..artwork               = stream.thumbnails?.maxresdefault;
  }

  // Initialize an AudioTags object with a MusicBrainzRecord
  factory AudioTags.withMusicBrainzRecord(MusicBrainzRecord record) {
    return AudioTags()
      ..urlController.text    = ''
      ..titleController.text  = MediaUtils.removeToxicSymbols(record.title)
      ..albumController.text  = record.album
      ..artistController.text = record.artist
      ..genreController.text  = record.genre
      ..dateController.text   = record.date
      ..discController.text   = record.disc
      ..trackController.text  = record.track;
  } 

}