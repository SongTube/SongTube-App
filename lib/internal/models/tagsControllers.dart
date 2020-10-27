import 'package:flutter/material.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

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

  void updateTextControllers(Video videoDetails) {
    titleController.text  = videoDetails.title;
    albumController.text  = "YouTube";
    artistController.text = videoDetails.author
                              .replaceAll("- Topic", "")
                              .trim();
    genreController.text  = "Any";
    dateController.text   = "${videoDetails.uploadDate.year}/"
                            + "${videoDetails.uploadDate.month}/"
                            + "${videoDetails.uploadDate.day}";
    discController.text   = "1";
    trackController.text  = "1";
    artworkController     = videoDetails.thumbnails.mediumResUrl;
  }

}