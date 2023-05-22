import 'package:songtube/languages/languages.dart';

class LanguageDe extends Languages {

  // Introduction Screens
  @override
  String get labelAppWelcome => "Willkomen";
  @override
  String get labelStart => "Anfangen";
  @override
  String get labelSkip => "Überspringen";
  @override
  String get labelNext => "Nächste";
  @override
  String get labelExternalAccessJustification =>
    "Erlaubnis um zugriff auf Externe SD Karte um" +
    "Videos und Musik zu speichern";
  @override
  String get labelAppCustomization => "Design";
  @override
  String get labelSelectPreferred => "Favorit auswählen";
  @override
  String get labelConfigReady => "Konfiguration abgeschloßen";
  @override
  String get labelIntroductionIsOver => "Intro abgeschloßen";
  @override
  String get labelEnjoy => "Viel spaß";
  @override 
  String get labelGoHome => "Gehe zum Startseite";

  // Bottom Navigation Bar
  @override
  String get labelHome => "Start";
  @override
  String get labelDownloads => "Downloads";
  @override
  String get labelMedia => "Mediathek";
  @override
  String get labelYouTube => "YouTube";
  @override
  String get labelMore => "Mehr";

  // Home Screen
  @override
  String get labelQuickSearch => "Schnelle suche...";
  @override
  String get labelTagsEditor => "Tags editieren";
  @override
  String get labelEditArtwork => "Poster editieren";
  @override
  String get labelDownloadAll => "Alles herunterladen";
  @override 
  String get labelLoadingVideos => "Videos werden geladen...";
  @override
  String get labelHomePage => "Start Seite";
  @override
  String get labelTrending => "Trending";
  @override
  String get labelFavorites => "Favoriten";
  @override
  String get labelWatchLater => "Später schauen";

  // Video Options Menu
  @override
  String get labelCopyLink => "Link copieren";
  @override
  String get labelAddToFavorites => "zu Favoriten hinzufügen";
  @override
  String get labelAddToWatchLater => "zum \"Später schauen\" hinzufügen";
  @override
  String get labelAddToPlaylist => "zum Playlist hinzufügen";

  // Downloads Screen
  @override
  String get labelQueued => "Im Warteschlange";
  @override
  String get labelDownloading => "Wird heruntergeladen";
  @override
  String get labelConverting => "Konvertierung läuft";
  @override
  String get labelCancelled => "wird Abebrochen";
  @override
  String get labelCompleted => "Abgeschloßen";

  // Download Status/Error Messages
  @override
  String get labelDownloadQueued => "Download Warteschlange";
  @override
  String get labelDownloadAcesssDenied => "Zugriff verweigert";
  @override
  String get labelClearingExistingMetadata => "Bereinigung von Metadaten...";
  @override
  String get labelWrittingTagsAndArtwork => "Tags & Posters werden hinzugefügt...";
  @override
  String get labelSavingFile => "Datei wird gespeichert...";
  @override
  String get labelAndroid11FixNeeded => "Patch für Android 11 nötig, Einstellungen prüfen";
  @override
  String get labelErrorSavingDownload => "Download konnte nicht gespeichert werden, Erlaubnise prüfen";
  @override
  String get labelDownloadingVideo => "Video wird heruntergeladen...";
  @override
  String get labelDownloadingAudio => "Audio wird heruntergeladen...";
  @override
  String get labelGettingAudioStream => "Audiostream wird extrahiert...";
  @override
  String get labelAudioNoDataRecieved => "Audiostream konnte nicht extrahiert werden";
  @override
  String get labelDownloadStarting => "Download beginnt...";
  @override
  String get labelDownloadCancelled => "Download abgeschloßen";
  @override
  String get labelAnIssueOcurredConvertingAudio => "Konverter error";
  @override
  String get labelPatchingAudio => "Audio wird gepätcht...";

  // Download Menu
  @override
  String get labelEnableAudioConversion => "Audio konvertierung aktivieren";
  @override
  String get labelGainControls => "Verstärkungsregler kontrolle";
  @override
  String get labelVolume => "Lautstärke";
  @override
  String get labelBassGain => "Bass";
  @override
  String get labelTrebleGain => "Sobreagudo";
  @override
  String get labelSelectVideo => "Video auswählen";
  @override
  String get labelSelectAudio => "Audio auswählen";
  @override
  String get labelGlobalParameters => "globale Parameter";

  // Media Screen
  @override
  String get labelMusic => "Musik";
  @override
  String get labelVideos => "Videos";
  @override
  String get labelNoMediaYet => "Leere Mediathek";
  @override
  String get labelNoMediaYetJustification => "Mediathek" +
    "wird hier angezeigt";
  @override
  String get labelSearchMedia => "In Mediathek suchen...";
  @override
  String get labelDeleteSong => "Lied löschen";
  @override
  String get labelNoPermissionJustification => "Externen Speicher zugreif erlauben " + "\n" +
    "um an persönlichen Sammlung zu zugreifen";
  @override
  String get labelGettingYourMedia => "Sammlung wird geholt...";
  @override
  String get labelEditTags => "Tag editieren";

  // Navigate Screen
  @override
  String get labelSearchYoutube => "Auf Youtube suchen...";

  // More Screen
  @override
  String get labelSettings => "Einstelungen";
  @override
  String get labelDonate => "Spenden";
  @override
  String get labelLicenses => "Lizenzen";
  @override
  String get labelChooseColor => "Farbe auswählen";
  @override
  String get labelTheme => "Design";
  @override
  String get labelUseSystemTheme => "Systemeintellung Design benutzen";
  @override
  String get labelUseSystemThemeJustification =>
    "Aktivieren/Deaktivieren automatisches Systemeinstellung Design";
  @override
  String get labelEnableDarkTheme => "Dunkelmodus aktivieren";
  @override
  String get labelEnableDarkThemeJustification =>
    "Dunkles Design als Standard verwenden ";
  @override
  String get labelEnableBlackTheme => "Schwarzes Design aktivieren";
  @override
  String get labelEnableBlackThemeJustification =>
    "Schwarzes AMOLED Design aktivieren";
  @override
  String get labelAccentColor => "Akzentfarbe";
  @override
  String get labelAccentColorJustification => "Akzentfarbe personalisieren";
  @override
  String get labelAudioFolder => "Musikordner";
  @override
  String get labelAudioFolderJustification => "Musikordner download aswählen";
  @override
  String get labelVideoFolder => "Videoordner";
  @override
  String get labelVideoFolderJustification => "Musikordner download aswählen";
  @override
  String get labelAlbumFolder => "Albumordner";
  @override
  String get labelAlbumFolderJustification => "Albumordner pro Musikalbum erstellen";
  @override
  String get labelDeleteCache => "Cachee leeren";
  @override
  String get labelDeleteCacheJustification => "Cache von SongTube leeren";
  @override
  String get labelAndroid11Fix => "Android 11 Patch";
  @override
  String get labelAndroid11FixJustification => "Löst Android 11 Download Probleme";
  @override
  String get labelBackup => "Backup";
  @override
  String get labelBackupJustification => "Downloadssammlung Backup";
  @override
  String get labelRestore => "Wiederherstellen";
  @override
  String get labelRestoreJustification => "Downloadssammlung wiederherstellen";
  @override
  String get labelBackupLibraryEmpty => "Deine Bibliothek ist leer";
  @override
  String get labelBackupCompleted => "Backup abgeschlossen";
  @override
  String get labelRestoreNotFound => "Backup nicht gefunden";
  @override
  String get labelRestoreCompleted => "Backup wiederhergestellt";
  @override
  String get labelCacheIsEmpty => "Cache ist leer";
  @override
  String get labelYouAreAboutToClear => "Es werden " + "bereinigt";

  // Tags Editor TextFields
  @override
  String get labelEditorTitle => "Titel";
  @override
  String get labelEditorArtist => "Künstler";
  @override
  String get labelEditorGenre => "Genre";
  @override
  String get labelEditorDisc => "Album";
  @override
  String get labelEditorTrack => "Lied";
  @override
  String get labelEditorDate => "Datum";
  @override
  String get labelEditorAlbum => "Album";

  // Android 10 or 11 Detected Dialog
  @override
  String get labelAndroid11Detected => "Android 11 gefunden";
  @override
  String get labelAndroid11DetectedJustification => "Um das ordnungsgemäße Funktionieren der Downloads zu gewährleisten, ist in Android 10 und 11 möglicherweise " +
  "die Berechtigung für alle Dateien auf dem Gerät erforderlich, " +
  "diese Berechtigung ist vorübergehend und wird in zukünftigen Updates nicht mehr benötigt. " +
  "Sie können die Erlaubnis auch später in den Einstellungen dieser Anwendung erteilen.";

  // Music Player
  @override
  String get labelPlayerSettings => "PLayereinstellungen";
  @override
  String get labelExpandArtwork => "Cover erweitern";
  @override
  String get labelArtworkRoundedCorners => "Cover mit Abgerundete Kanten";
  @override
  String get labelPlayingFrom => "Wiedergeben von";
  @override
  String get labelBlurBackground => "Hintergrund verwischen";

  // Video Page
  @override
  String get labelTags => "Tags";
  @override
  String get labelRelated => "Ähnlich";
  @override
  String get labelAutoPlay => "Automatische wiedergabe";

  // Tags Pages
  @override
  String get labelAudioFormatNotCompatible =>
    "Audioformat unkompatibel";
  @override
  String get labelNotSpecified => "Nicht spezifiziert";
  @override
  String get labelPerformAutomaticTagging => 
    "Autotaggs";
  @override
  String get labelSelectTagsfromMusicBrainz => 
    "Tags von MusicBrainz auswählen";
  @override
  String get labelSelectArtworkFromDevice =>
    "Locales Cover auswählen";

  // Telegram Join Channel Dialog
  @override
  String get labelJoinTelegramChannel => "¡Treten Sie dem Telegram-Kanal bei!";
  @override
  String get labelJoinTelegramJustification =>
"Gefällt dir SongTube? Betritt unseren Kanal! Da wirst du finden " +
     "Updates, Informationen, Entwicklung, Gruppenlink " +
     "und soziale Netzwerke. " +
     "\ n \ n" +
     "Falls Sie ein Problem oder eine tolle Empfehlung haben," +
     "kannst du gerne der Gruppe aus dem Kanal beitreten und uns wissen lassen!" +
     "Aber bedenken dran, es ist nur Englisch erlaubt, danke!";
  @override
  String get labelRemindLater => "Später erinnern";

  // Common Words (One word labels)
  @override
  String get labelExit => "Schließen";
  @override
  String get labelSystem => "System";
  @override
  String get labelChannel => "Kanal";
  @override
  String get labelShare => "Freigeben";
  @override
  String get labelAudio => "Audio";
  @override
  String get labelVideo => "Video";
  @override
  String get labelDownload => "Herunterladen";
  @override
  String get labelBest => "Beste";
  @override
  String get labelPlaylist => "Playlist";
  @override
  String get labelVersion => "Version";
  @override
  String get labelLanguage => "Sprache";
  @override
  String get labelGrant => "Erlauben";
  @override
  String get labelAllow => "Zulassen";
  @override
  String get labelAccess => "Zugriff";
  @override
  String get labelEmpty => "Leer";
  @override
  String get labelCalculating => "Wird berechnet";
  @override
  String get labelCleaning => "Bereinigen";
  @override
  String get labelCancel => "Abbrechen";
  @override
  String get labelGeneral => "Allgemeines";
  @override
  String get labelRemove => "Entfernen";
  @override
  String get labelJoin => "Betreten";
  @override
  String get labelNo => "Nein";
  @override
  String get labelLibrary => "Bibliothek";
  @override
  String get labelCreate => "Erstellen";
  @override
  String get labelPlaylists => "Wiedergabelisten";
  @override
  String get labelQuality => "Qualität";
  @override
  String get labelSubscribe => "Abonnieren";

  // Other Translations
  @override
  String get labelNoFavoriteVideos => 'No Favorite Videos';
  @override
  String get labelNoFavoriteVideosDescription => 'Search for videos and save them as favorites. They will appear here';
  @override
  String get labelNoSubscriptions => 'No Subscriptions';
  @override
  String get labelNoSubscriptionsDescription => 'Tap the button above to show suggested Channels!';
  @override
  String get labelNoPlaylists => 'No Playlists';
  @override
  String get labelNoPlaylistsDescription => 'Search for videos or playlists and save them. They will appear here';
  @override
  String get labelSearch => 'Search';
  @override
  String get labelSubscriptions => 'Subscriptions';
  @override
  String get labelNoDownloadsCanceled => 'No Downloads Canceled';
  @override
  String get labelNoDownloadsCanceledDescription => 'Good news! But if you cancel or something goes wrong with the download, you can check from here';
  @override
  String get labelNoDownloadsYet => 'No Downloads Yet';
  @override
  String get labelNoDownloadsYetDescription => 'Go home, search for something to download or wait for the queue!';
  @override
  String get labelYourQueueIsEmpty => 'Your queue is empty';
  @override
  String get labelYourQueueIsEmptyDescription => 'Go home and search for something to download!';
  @override
  String get labelQueue => 'Queue';
  @override
  String get labelSearchDownloads => 'Search Downloads';
  @override
  String get labelWatchHistory => 'Watch History';
  @override
  String get labelWatchHistoryDescription => 'Look at which videos you have seen';
  @override
  String get labelBackupAndRestore => 'Backup & Restore';
  @override
  String get labelBackupAndRestoreDescription => 'Save or resture all of your local data';
  @override
  String get labelSongtubeLink => 'SongTube Link';
  @override
  String get labelSongtubeLinkDescription => 'Allow SongTube browser extension to detect this device, long press to learn more';
  @override
  String get labelSupportDevelopment => 'Support Development';
  @override
  String get labelSocialLinks => 'Social Links';
  @override
  String get labelSeeMore => 'See more';
  @override
  String get labelMostPlayed => 'Most played';
  @override
  String get labelNoPlaylistsYet => 'No Playlists Yet';
  @override
  String get labelNoPlaylistsYetDescription => 'You can create a playlist from your recents, music, albums or artists';
  @override
  String get labelNoSearchResults => 'No search results';
  @override
  String get labelSongResults => 'Song results';
  @override
  String get labelAlbumResults => 'Album results';
  @override
  String get labelArtistResults => 'Artist results';
  @override
  String get labelSearchAnything => 'Search anything';
  @override
  String get labelRecents => 'Recents';
  @override
  String get labelFetchingSongs => 'Fetching Songs';
  @override
  String get labelPleaseWaitAMoment => 'Please wait a moment';
  @override
  String get labelWeAreDone => 'We are done';
  @override
  String get labelEnjoyTheApp => 'Enjoy the\nApp';
  @override
  String get labelSongtubeIsBackDescription => 'SongTube is back with a cleaner look and set of features, have fun with your music!';
  @override
  String get labelLetsGo => 'Let\'s go';
  @override
  String get labelPleaseWait => 'Please wait';
  @override
  String get labelPoweredBy => 'Powered by';
  @override
  String get labelGetStarted => 'Get Started';
  @override
  String get labelAllowUsToHave => 'Allow us to have';
  @override
  String get labelStorageRead => 'Storage\nRead';
  @override
  String get labelStorageReadDescription => 'This will scan your music, extract high quality artworks and allow you to personalize your music';
  @override
  String get labelContinue => 'Continue';
  @override
  String get labelAllowStorageRead => 'Allow Storage Read';
  @override
  String get labelSelectYourPreferred => 'Select your preferred';
  @override
  String get labelLight => 'Light';
  @override
  String get labelDark => 'Dark';
  @override
  String get labelSimultaneousDownloads => 'Simultaneous Downloads';
  @override
  String get labelSimultaneousDownloadsDescription => 'Define how many downloads can happen at the same time';
  @override
  String get labelItems => 'Items';
  @override
  String get labelInstantDownloadFormat => 'Instant Download';
  @override
  String get labelInstantDownloadFormatDescription => 'Change the audio format for instant downloads';
  @override
  String get labelCurrent => 'Current';
  @override
  String get labelPauseWatchHistory => 'Pause Watch History';
  @override
  String get labelPauseWatchHistoryDescription => 'While paused, videos are not saved into the watch history list';
  @override
  String get labelLockNavigationBar => 'Lock Navigation Bar';
  @override
  String get labelLockNavigationBarDescription => 'Locks the navigation bar from hiding and showing automatically on scroll';
  @override
  String get labelPictureInPicture => 'Picture in Picture';
  @override
  String get labelPictureInPictureDescription => 'Automatically enters PiP mode upon tapping home button while watching a video';
  @override
  String get labelBackgroundPlaybackAlpha => 'Background Playback (Alpha)';
  @override
  String get labelBackgroundPlaybackAlphaDescription => 'Toggle background playback feature. Due to plugin limitations, only current video can be played in the background';
  @override
  String get labelBlurBackgroundDescription => 'Add blurred artwork background';
  @override
  String get labelBlurIntensity => 'Blur Intensity';
  @override
  String get labelBlurIntensityDescription => 'Change the blur intensity of the artwork background';
  @override
  String get labelBackdropOpacity => 'Backdrop Opacity';
  @override
  String get labelBackdropOpacityDescription => 'Change the colored backdrop opacity';
  @override
  String get labelArtworkShadowOpacity => 'Artwork Shadow Opacity';
  @override
  String get labelArtworkShadowOpacityDescription => 'Change the artwork shadow intensity of the music player';
  @override
  String get labelArtworkShadowRadius => 'Artwork Shadow Radius';
  @override
  String get labelArtworkShadowRadiusDescription => 'Change the artwork shadow radius of the music player';
  @override
  String get labelArtworkScaling => 'Artwork Scaling';
  @override
  String get labelArtworkScalingDescription => 'Scale out the music player artwork & background images';
  @override
  String get labelBackgroundParallax => 'Background Parallax';
  @override
  String get labelBackgroundParallaxDescription =>  'Enable/Disable background image parallax effect';
  @override
  String get labelRestoreThumbnails => 'Restore Thumbnails';
  @override
  String get labelRestoreThumbnailsDescription => 'Force thumbnails and artwork generation process';
  @override
  String get labelRestoringArtworks => 'Restoring artworks';
  @override
  String get labelRestoringArtworksDone => 'Restoring artworks done';
  @override
  String get labelHomeScreen => 'Home Screen';
  @override
  String get labelHomeScreenDescription => 'Change the default landing screen when you open the app';
  @override
  String get labelDefaultMusicPage => 'Default Music Page';
  @override
  String get labelDefaultMusicPageDescription => 'Change the default page for the Music Page';
  @override
  String get labelAbout => 'About';
  @override
  String get labelConversionRequired => 'Conversion Required';
  @override
  String get labelConversionRequiredDescription =>  'This song format is incompatible with the ID3 Tags editor. The app will automatically convert this song to AAC (m4a) to sort out this issue.';
  @override
  String get labelPermissionRequired => 'Permission Required';
  @override
  String get labelPermissionRequiredDescription => 'All file access permission is required for SongTube to edit any song on your device';
  @override
  String get labelApplying => 'Applying';
  @override
  String get labelConvertingDescription => 'Re-encoding this song into AAC (m4a) format';
  @override
  String get labelWrittingTagsAndArtworkDescription => 'Applying new tags to this song';
  @override
  String get labelApply => 'Apply';
  @override
  String get labelSongs => 'Songs';
  @override
  String get labelPlayAll => 'Play All';
  @override
  String get labelPlaying => 'Playing';
  @override
  String get labelPages => 'Pages';
  @override
  String get labelMusicPlayer => 'Music Player';
  @override
  String get labelClearWatchHistory => 'Clear Watch History';
  @override
  String get labelClearWatchHistoryDescription =>  'You\'re about to delete all your watch history videos, this action cannot be undone, proceed?';
  @override
  String get labelDelete => 'Delete';
  @override
  String get labelAppUpdate => 'App Update';
  @override
  String get labelWhatsNew => 'What\'s New';
  @override
  String get labelLater => 'Later';
  @override
  String get labelUpdate => 'Update';
  @override
  String get labelUnsubscribe => 'Unsubscribe';
  @override
  String get labelAudioFeatures => 'Audio Features';
  @override
  String get labelVolumeBoost => 'Volume Boost';
  @override
  String get labelNormalizeAudio => 'Normalize Audio';
  @override
  String get labelSegmentedDownload => 'Segmented Download';
  @override
  String get labelEnableSegmentedDownload => 'Enable Segmented Download';
  @override
  String get labelEnableSegmentedDownloadDescription => 'This will download the whole audio file and then split it into the various enabled segments (or audio tracks) from the list below';
  @override
  String get labelCreateMusicPlaylist => 'Create Music Playlist';
  @override
  String get labelCreateMusicPlaylistDescription => 'Create music playlist from all downloaded and saved audio segments';
  @override
  String get labelApplyTags => 'Apply Tags';
  @override
  String get labelApplyTagsDescription => 'Extract tags from MusicBrainz for all segments';
  @override
  String get labelLoading => 'Loading';
  @override
  String get labelMusicDownloadDescription => 'Select quality, convert and download audio only';
  @override
  String get labelVideoDownloadDescription =>  'Choose a video quality from the list and download it';
  @override
  String get labelInstantDescription => 'Instantly start downloading as music';
  @override
  String get labelInstant => 'Instant';
  @override
  String get labelCurrentQuality => 'Current Quality';
  @override
  String get labelFastStreamingOptions => 'Fast Streaming Options';
  @override
  String get labelStreamingOptions => 'Streaming Options';
  @override
  String get labelComments => 'Comments';
  @override
  String get labelPinned => 'Pinned';
  @override
  String get labelLikedByAuthor => 'Liked by Author';
  @override
  String get labelDescription => 'Description';
  @override
  String get labelViews => 'Views';
  @override
  String get labelPlayingNextIn => 'Playing next in';
  @override
  String get labelPlayNow => 'Play Now';
  @override
  String get labelLoadingPlaylist => 'Loading Playlist';
  @override
  String get labelPlaylistReachedTheEnd => 'Playlist reached the end';
  @override
  String get labelLiked => 'Liked';
  @override
  String get labelLike => 'Like';
  @override
  String get labelVideoRemovedFromFavorites => 'Video removed from favorites';
  @override
  String get labelVideoAddedToFavorites => 'Video added to favorites';
  @override
  String get labelPopupMode => 'Popup Mode';
  @override
  String get labelDownloaded => 'Downloaded';
  @override
  String get labelShowPlaylist => 'Show Playlist';
  @override
  String get labelCreatePlaylist => 'Create Playlist';
  @override
  String get labelAddVideoToPlaylist => 'Add video to playlist';
  @override
  String get labelBackupDescription => 'Backup all of your local data into a single file that can be used to restore later';
  @override
  String get labelBackupCreated => 'Backup Created';
  @override
  String get labelBackupRestored => 'Backup Restored';
  @override
  String get labelRestoreDescription => 'Restore all your data from a backup file';
  @override
  String get labelChannelSuggestions => 'Channel Suggestions';
  @override
  String get labelFetchingChannels => 'Fetching Channels';
  @override
  String get labelShareVideo => 'Shared Video';
  @override
  String get labelShareDescription => 'Share with friends or other platforms';
  @override
  String get labelRemoveFromPlaylists => 'Remove from playlist';
  @override
  String get labelThisActionCannotBeUndone => 'This action cannot be undone';
  @override
  String get labelAddVideoToPlaylistDescription => 'Add to existing or new video playlist';
  @override
  String get labelAddToPlaylists => 'Add to playlists';
  @override
  String get labelEditableOnceSaved => 'Editable once saved';
  @override
  String get labelPlaylistRemoved => 'Playlist Removed';
  @override
  String get labelPlaylistSaved => 'Playlist Saved';
  @override
  String get labelRemoveFromFavorites => 'Remove from favorites';
  @override
  String get labelRemoveFromFavoritesDescription => 'Remove this video from your favorites';
  @override
  String get labelSaveToFavorites => 'Save to favorites';
  @override
  String get labelSaveToFavoritesDescription => 'Add video to your list of favorites';
  @override
  String get labelSharePlaylist => 'Share Playlist';
  @override
  String get labelRemoveThisVideoFromThisList => 'Remove this video from this list';
  @override
  String get labelEqualizer => 'Equalizer';
  @override
  String get labelLoudnessEqualizationGain => 'Loudness Equalization Gain';
  @override
  String get labelSliders => 'Sliders';
  @override
  String get labelSave => 'Save';
  @override
  String get labelPlaylistName => 'PlaylistName';
  @override
  String get labelCreateVideoPlaylist => 'Create Video Playlist';
  @override
  String get labelSearchFilters => 'Search Filters';
  @override
  String get labelAddToPlaylistDescription => 'Add to existing or new playlist';
  @override
  String get labelShareSong => 'Share Song';
  @override
  String get labelShareSongDescription => 'Share with friends or other platforms';
  @override
  String get labelEditTagsDescription => 'Open ID3 tags and artwork editor';
  @override
  String get labelContains => 'Contains';
}
