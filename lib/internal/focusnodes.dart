// Flutter
import 'package:flutter/material.dart';

class FocusNodes {

  FocusNode urlFocusNode = FocusNode();
  FocusNode titleFocusNode = FocusNode();
  FocusNode albumFocusNode = FocusNode();
  FocusNode artistFocusNode = FocusNode();
  FocusNode genreFocusNode = FocusNode();
  FocusNode dateFocusNode = FocusNode();
  FocusNode diskFocusNode = FocusNode();
  FocusNode trackFocusNode = FocusNode();

  void unfocusAll() {
    urlFocusNode.unfocus();
    titleFocusNode.unfocus();
    albumFocusNode.unfocus();
    artistFocusNode.unfocus();
    genreFocusNode.unfocus();
    dateFocusNode.unfocus();
    diskFocusNode.unfocus();
    trackFocusNode.unfocus();
  }

}