import 'package:songtube/internal/languages.dart';

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
}
