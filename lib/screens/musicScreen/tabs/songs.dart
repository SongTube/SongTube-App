import 'dart:io';
import 'dart:ui';

import 'package:audio_service/audio_service.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:songtube/internal/ffmpeg/converter.dart';
import 'package:songtube/internal/languages.dart';
import 'package:songtube/internal/models/videoFile.dart';
import 'package:songtube/players/service/playerService.dart';
import 'package:songtube/players/videoPlayer.dart';
import 'package:songtube/provider/mediaProvider.dart';
import 'package:songtube/provider/preferencesProvider.dart';
import 'package:songtube/screens/musicScreen/components/songsList.dart';
import 'package:songtube/ui/animations/blurPageRoute.dart';
import 'package:songtube/ui/internal/popupMenu.dart';
import 'package:songtube/ui/components/tagsEditorPage.dart';
import 'package:songtube/ui/internal/snackbar.dart';
import 'package:transparent_image/transparent_image.dart';


class MusicScreenSongsTab extends StatelessWidget {
  final List<MediaItem> songs;
  final bool hasDownloadType;
  final String searchQuery;
  MusicScreenSongsTab({
    @required this.songs,
    this.hasDownloadType = false,
    this.searchQuery = ""
  });
  @override
  Widget build(BuildContext context) {
    return SongsListView(songs: songs, searchQuery: searchQuery);
  }
}