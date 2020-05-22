// Flutter
import 'package:flutter/material.dart';

class TextControllers {

  TextEditingController urlController = new TextEditingController();
  TextEditingController titleController = new TextEditingController();
  TextEditingController albumController = new TextEditingController();
  TextEditingController artistController = new TextEditingController();
  TextEditingController genreController = new TextEditingController();
  TextEditingController dateController = new TextEditingController();
  TextEditingController diskController = new TextEditingController();
  TextEditingController trackController = new TextEditingController();

  void cleanTextEditing() {
    titleController.clear();
    albumController.clear();
    artistController.clear();
    genreController.clear();
    dateController.clear();
    diskController.clear();
    trackController.clear();
  }

}