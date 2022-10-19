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
    "Erlaube den Zugriff auf den Externen-Speicher um" +
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
  String get labelEnjoy => "Viel Spaß";
  @override 
  String get labelGoHome => "Gehe zur Startseite";

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
  String get labelTagsEditor => "Tags bearbeiten";
  @override
  String get labelEditArtwork => "Artwork bearbeiten";
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
  String get labelWatchLater => "Später anschauen";

  // Video Options Menu
  @override
  String get labelCopyLink => "Link kopieren";
  @override
  String get labelAddToFavorites => "zu Favoriten hinzufügen";
  @override
  String get labelAddToWatchLater => "zu \"Später anschauen\" hinzufügen";
  @override
  String get labelAddToPlaylist => "zur Playlist hinzufügen";

  // Downloads Screen
  @override
  String get labelQueued => "zur Warteschlange hinzugefügt";
  @override
  String get labelDownloading => "wird heruntergeladen";
  @override
  String get labelConverting => "Konvertierung läuft";
  @override
  String get labelCancelled => "wird Abgebrochen";
  @override
  String get labelCompleted => "Abgeschloßen";

  // Download Status/Error Messages
  @override
  String get labelDownloadQueued => "Download zur Warteschlange hinzugefügt";
  @override
  String get labelDownloadAcesssDenied => "Zugriff verweigert";
  @override
  String get labelClearingExistingMetadata => "Bereinigung von Metadaten...";
  @override
  String get labelWrittingTagsAndArtwork => "Tags & Artworks werden hinzugefügt...";
  @override
  String get labelSavingFile => "Datei wird gespeichert...";
  @override
  String get labelAndroid11FixNeeded => "Patch für Android 11 nötig, überprüfe die Einstellungen";
  @override
  String get labelErrorSavingDownload => "Download konnte nicht gespeichert werden, überprüfe die Erlaubnis";
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
  String get labelAnIssueOcurredConvertingAudio => "Fehler bei der Konvertierung";
  @override
  String get labelPatchingAudio => "Audio wird gepatcht...";

  // Download Menu
  @override
  String get labelEnableAudioConversion => "Audio Konvertierung aktivieren";
  @override
  String get labelGainControls => "Verstärkungsregler";
  @override
  String get labelVolume => "Lautstärke";
  @override
  String get labelBassGain => "Bass";
  @override
  String get labelTrebleGain => "Höhen";
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
  String get labelNoMediaYetJustification => "Deine Mediathek" +
    "wird hier angezeigt";
  @override
  String get labelSearchMedia => "Mediathek durchsuchen...";
  @override
  String get labelDeleteSong => "Lied löschen";
  @override
  String get labelNoPermissionJustification => "Erlaube den Zugriff auf den Externen-Speicher " + "\n" +
    "um auf die persönliche Sammlung zuzugreifen";
  @override
  String get labelGettingYourMedia => "Mediathek wird geladen...";
  @override
  String get labelEditTags => "Tags bearbeiten";

  // Navigate Screen
  @override
  String get labelSearchYoutube => "YouTube durchsuchen...";

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
  String get labelUseSystemTheme => "System-Theme benutzen";
  @override
  String get labelUseSystemThemeJustification =>
    "Aktiviere/Deaktiviere automatisches Theme";
  @override
  String get labelEnableDarkTheme => "Dunkler-Modus aktivieren";
  @override
  String get labelEnableDarkThemeJustification =>
    "Dunklen-Modus als Standard verwenden ";
  @override
  String get labelEnableBlackTheme => "OLED-Theme aktivieren";
  @override
  String get labelEnableBlackThemeJustification =>
    "OLED-Theme aktivieren";
  @override
  String get labelAccentColor => "Akzentfarbe";
  @override
  String get labelAccentColorJustification => "Akzentfarbe personalisieren";
  @override
  String get labelAudioFolder => "Musikordner";
  @override
  String get labelAudioFolderJustification => "Ordner für Musikdownloads auswählen";
  @override
  String get labelVideoFolder => "Videoordner";
  @override
  String get labelVideoFolderJustification => "Ordner für Videodownloads auswählen";
  @override
  String get labelAlbumFolder => "Albumordner";
  @override
  String get labelAlbumFolderJustification => "Einen eigenen Ordner für jedes Album erstellen";
  @override
  String get labelDeleteCache => "Cache leeren";
  @override
  String get labelDeleteCacheJustification => "SongTube Chache leeren";
  @override
  String get labelAndroid11Fix => "Android 11 Patch";
  @override
  String get labelAndroid11FixJustification => "Löste die Downloadprobleme unter Android 10 & 11";
  @override
  String get labelBackup => "Backup";
  @override
  String get labelBackupJustification => "Sichere deine Mediathek";
  @override
  String get labelRestore => "Wiederherstellen";
  @override
  String get labelRestoreJustification => "Wiederherstellen deiner Mediathek";
  @override
  String get labelBackupLibraryEmpty => "Deine Mediathek ist leer";
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
  String get labelAndroid11DetectedJustification => "Um das ordnungsgemäße Funktionieren der Downloads zu gewährleisten, ist unter Android 10 und 11 möglicherweise " +
  "die Berechtigung für alle Dateien auf dem Gerät erforderlich. " +
  "Diese Berechtigung ist vorübergehend und wird in zukünftigen Updates nicht mehr benötigt. " +
  "Diese Erlaubnis kann auch später in den Einstellung erteilt werden.";

  // Music Player
  @override
  String get labelPlayerSettings => "PLayereinstellungen";
  @override
  String get labelExpandArtwork => "Artwork erweitern";
  @override
  String get labelArtworkRoundedCorners => "Artwork mit abgerundeten Kanten";
  @override
  String get labelPlayingFrom => "Wiedergeben von";
  @override
  String get labelBlurBackground => "Unscharfer Hintergrund";

  // Video Page
  @override
  String get labelTags => "Tags";
  @override
  String get labelRelated => "Ähnlich";
  @override
  String get labelAutoPlay => "Automatische Widergabe";

  // Tags Pages
  @override
  String get labelAudioFormatNotCompatible =>
    "Audioformat inkompatibel";
  @override
  String get labelNotSpecified => "Nicht spezifiziert";
  @override
  String get labelPerformAutomaticTagging => 
    "Autotagging";
  @override
  String get labelSelectTagsfromMusicBrainz => 
    "Tags von MusicBrainz auswählen";
  @override
  String get labelSelectArtworkFromDevice =>
    "Locales Artwork auswählen";

  // Telegram Join Channel Dialog
  @override
  String get labelJoinTelegramChannel => "Telegramm-Kanal beitreten";
  @override
  String get labelJoinTelegramJustification =>
"Gefällt dir SongTube? Trete unserem Telegram-Kanal bei! Du findest dort: " +
     "Updates, Informationen, Entwicklung, Gruppenlinks " +
     "und andere soziale Netzwerke. " +
     "\ n \ n" +
     "Falls due ein Problem oder eine tolle Empfehlung hast," +
     "kannst du gerne der Gruppe beitreten und es uns sagen!" +
     "Der Kanal ist aber nur auf Englisch!";
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
  String get labelPlaylists => "Playlists";
  @override
  String get labelQuality => "Qualität";
  @override
  String get labelSubscribe => "Abonnieren";
}
