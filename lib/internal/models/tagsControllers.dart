import 'package:flutter/material.dart';
import 'package:newpipeextractor_dart/models/infoItems/video.dart';
import 'package:newpipeextractor_dart/models/playlist.dart';
import 'package:newpipeextractor_dart/models/video.dart';

class TagsControllers {

  TagsControllers() {
    // Controllers
    urlController    = new TextEditingController();
    titleController  = new TextEditingController();
    albumController  = new TextEditingController();
    artistController = new TextEditingController();
    genreController  = new TextEditingController();
    dateController   = new TextEditingController();
    discController   = new TextEditingController();
    trackController  = new TextEditingController();
  }

  TextEditingController urlController;
  TextEditingController titleController;
  TextEditingController albumController;
  TextEditingController artistController;
  TextEditingController genreController;
  TextEditingController dateController;
  TextEditingController discController;
  TextEditingController trackController;
  String artworkController;

  void updateTextControllers(YoutubeVideo stream) {
    titleController.text  = stream.videoInfo.name;
    albumController.text  = "YouTube";
    artistController.text = stream.videoInfo.uploaderName
                              .replaceAll("- Topic", "")
                              .trim();
    genreController.text  = "Any";
    dateController.text   = stream.videoInfo.uploadDate;
    discController.text   = "1";
    trackController.text  = "1";
    artworkController     = stream.videoInfo.thumbnailUrl;
  }

  void updateTextControllersFromPlaylist(YoutubePlaylist playlist) {
    titleController.text  = playlist.name;
    albumController.text  = "YouTube";
    artistController.text = playlist.uploaderName;
    genreController.text  = "Any";
    dateController.text   = "${DateTime.now().year}/"
                            + "${DateTime.now().month}"
                            + "${DateTime.now().day}";
    discController.text   = "1";
    trackController.text  = "1";
    artworkController     = playlist.thumbnailUrl;
  }

  void updateTextControllersFromStream(StreamInfoItem stream) {
    titleController.text = stream.name;
    albumController.text  = "YouTube";
    artistController.text = stream.uploaderName;
    genreController.text  = "Any";
    dateController.text   = "${DateTime.now().year}/"
                            + "${DateTime.now().month}"
                            + "${DateTime.now().day}";
    discController.text   = "1";
    trackController.text  = "1";
    artworkController     = stream.thumbnails.hqdefault;
  }

}