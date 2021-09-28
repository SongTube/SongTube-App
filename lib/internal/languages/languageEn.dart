import 'package:songtube/internal/languages.dart';

class LanguageEn extends Languages {

  // Introduction Screens
  @override
  String get labelAppWelcome => "Welcome to";
  @override
  String get labelStart => "Start";
  @override
  String get labelSkip => "Skip";
  @override
  String get labelNext => "Next";
  @override
  String get labelExternalAccessJustification =>
    "Needs Access to your External Storage to save all " +
    "your Videos and Music";
  @override
  String get labelAppCustomization => "Customization";
  @override
  String get labelSelectPreferred => "Select your Preferred";
  @override
  String get labelConfigReady => "Config Ready";
  @override
  String get labelIntroductionIsOver => "Introduction is over";
  @override
  String get labelEnjoy => "Enjoy";
  @override 
  String get labelGoHome => "Go Home";

  // Bottom Navigation Bar
  @override
  String get labelHome => "Home";
  @override
  String get labelDownloads => "Downloads";
  @override
  String get labelMedia => "Media";
  @override
  String get labelYouTube => "YouTube";
  @override
  String get labelMore => "More";

  // Home Screen
  @override
  String get labelQuickSearch => "Quick Search...";
  @override
  String get labelTagsEditor => "Tags\nEditor";
  @override
  String get labelEditArtwork => "Edit\nArtwork";
  @override
  String get labelDownloadAll => "Download All";
  @override 
  String get labelLoadingVideos => "Loading Videos...";
  @override
  String get labelHomePage => "Home Page";
  @override
  String get labelTrending => "Trending";
  @override
  String get labelFavorites => "Favorites";
  @override
  String get labelWatchLater => "Watch Later";

  // Video Options Menu
  @override
  String get labelCopyLink => "Copy Link";
  @override
  String get labelAddToFavorites => "Add to Favorites";
  @override
  String get labelAddToWatchLater => "Add to Watch Later";
  @override
  String get labelAddToPlaylist => "Add to Playlist";

  // Downloads Screen
  @override
  String get labelQueued => "Queued";
  @override
  String get labelDownloading => "Downloading";
  @override
  String get labelConverting => "Converting";
  @override
  String get labelCancelled => "Cancelled";
  @override
  String get labelCompleted => "Completed";

  // Download Status/Error Messages
  @override
  String get labelDownloadQueued => "Download Queued";
  @override
  String get labelDownloadAcesssDenied => "Access Denied";
  @override
  String get labelClearingExistingMetadata => "Clearing Existing Metadata...";
  @override
  String get labelWrittingTagsAndArtwork => "Writting Tags & Artwork...";
  @override
  String get labelSavingFile => "Saving File...";
  @override
  String get labelAndroid11FixNeeded => "Error, Android 11 Fix needed, check Settings";
  @override
  String get labelErrorSavingDownload => "Couldn't save your Download, check Permissions";
  @override
  String get labelDownloadingVideo => "Downloading Video...";
  @override
  String get labelDownloadingAudio => "Downloading Audio...";
  @override
  String get labelGettingAudioStream => "Getting Audio Stream...";
  @override
  String get labelAudioNoDataRecieved => "Couldn't get Audio Stream";
  @override
  String get labelDownloadStarting => "Download Starting...";
  @override
  String get labelDownloadCancelled => "Download Cancelled";
  @override
  String get labelAnIssueOcurredConvertingAudio => "Converted Process Failed";
  @override
  String get labelPatchingAudio => "Patching Audio...";

  // Download Menu
  @override
  String get labelEnableAudioConversion => "Enable Audio Conversion";
  @override
  String get labelGainControls => "Gain Controls";
  @override
  String get labelVolume => "Volume";
  @override
  String get labelBassGain => "Bass Gain";
  @override
  String get labelTrebleGain => "Treble Gain";
  @override
  String get labelSelectVideo => "Select Video";
  @override
  String get labelSelectAudio => "Select Audio";
  @override
  String get labelGlobalParameters => "Global parameters";

  // Media Screen
  @override
  String get labelMusic => "Music";
  @override
  String get labelVideos => "Videos";
  @override
  String get labelNoMediaYet => "No Media Yet";
  @override
  String get labelNoMediaYetJustification => "All your Media " +
    "will be shown here";
  @override
  String get labelSearchMedia => "Search Media...";
  @override
  String get labelDeleteSong => "Delete Song";
  @override
  String get labelNoPermissionJustification => "View your Media by" + "\n" +
    "Granting Storage Permission";
  @override
  String get labelGettingYourMedia => "Getting your Media...";
  @override
  String get labelEditTags => "Edit Tags";

  // Navigate Screen
  @override
  String get labelSearchYoutube => "Search YouTube...";

  // More Screen
  @override
  String get labelSettings => "Settings";
  @override
  String get labelDonate => "Donate";
  @override
  String get labelLicenses => "Licenses";
  @override
  String get labelChooseColor => "Choose Color";
  @override
  String get labelTheme => "Theme";
  @override
  String get labelUseSystemTheme => "Use System Theme";
  @override
  String get labelUseSystemThemeJustification =>
    "Enable/Disable automatic Theme";
  @override
  String get labelEnableDarkTheme => "Enable Dark Theme";
  @override
  String get labelEnableDarkThemeJustification =>
    "Use Dark Theme by default";
  @override
  String get labelEnableBlackTheme => "Enable Black Theme";
  @override
  String get labelEnableBlackThemeJustification =>
    "Enable Pure Black Theme";
  @override
  String get labelAccentColor => "Accent Color";
  @override
  String get labelAccentColorJustification => "Customize accent color";
  @override
  String get labelAudioFolder => "Audio Folder";
  @override
  String get labelAudioFolderJustification => "Choose a Folder for " +
    "Audio downloads";
  @override
  String get labelVideoFolder => "Video Folder";
  @override
  String get labelVideoFolderJustification => "Choose a folder for " +
    "Video downloads";
  @override
  String get labelAlbumFolder => "Album Folder";
  @override
  String get labelAlbumFolderJustification => "Create a Folder for each Song Album";
  @override
  String get labelDeleteCache => "Delete Cache";
  @override
  String get labelDeleteCacheJustification => "Clear SongTube Cache";
  @override
  String get labelAndroid11Fix => "Android 11 Fix";
  @override
  String get labelAndroid11FixJustification => "Fixes Download issues on " +
    "Android 10 & 11";
  @override
  String get labelBackup => "Backup";
  @override
  String get labelBackupJustification => "Backup your media library";
  @override
  String get labelRestore => "Restore";
  @override
  String get labelRestoreJustification => "Restore your media library";
  @override
  String get labelBackupLibraryEmpty => "Your Library is empty";
  @override
  String get labelBackupCompleted => "Backup Completed";
  @override
  String get labelRestoreNotFound => "Restore Not Found";
  @override
  String get labelRestoreCompleted => "Restore Completed";
  @override
  String get labelCacheIsEmpty => "Cache is Empty";
  @override
  String get labelYouAreAboutToClear => "You're about to clear";

  // Tags Editor TextFields
  @override
  String get labelEditorTitle => "Title";
  @override
  String get labelEditorArtist => "Artist";
  @override
  String get labelEditorGenre => "Genre";
  @override
  String get labelEditorDisc => "Disc";
  @override
  String get labelEditorTrack => "Track";
  @override
  String get labelEditorDate => "Date";
  @override
  String get labelEditorAlbum => "Album";

  // Android 10 or 11 Detected Dialog
  @override
  String get labelAndroid11Detected => "Android 10 or 11 Detected";
  @override
  String get labelAndroid11DetectedJustification => "To ensure the correct " +
    "functioning of this app Downloads, on Android 10 and 11, access to all " +
    "Files permission might be needed, this will be temporal and not required " +
    "on future updates. You can also apply this fix in Settings.";

  // Music Player
  @override
  String get labelPlayerSettings => "Player Settings";
  @override
  String get labelExpandArtwork => "Expand Artwork";
  @override
  String get labelArtworkRoundedCorners => "Artwork Rounded Corners";
  @override
  String get labelPlayingFrom => "Playing From";
  @override
  String get labelBlurBackground => "Blur Background";

  // Video Page
  @override
  String get labelTags => "Tags";
  @override
  String get labelRelated => "Related";
  @override
  String get labelAutoPlay => "AutoPlay";

  // Tags Pages
  @override
  String get labelAudioFormatNotCompatible =>
    "Audio format not Compatible";
  @override
  String get labelNotSpecified => "Not Specified";
  @override
  String get labelPerformAutomaticTagging => 
    "Perform Automatic Tagging";
  @override
  String get labelSelectTagsfromMusicBrainz => 
    "Select Tags from MusicBrainz";
  @override
  String get labelSelectArtworkFromDevice =>
    "Select Artwork from Device";

  // Telegram Join Channel Dialog
  @override
  String get labelJoinTelegramChannel => "Join Telegram Channel!";
  @override
  String get labelJoinTelegramJustification =>
    "Do you like SongTube? Please join the Telegram Channel! You will find " +
    "Updates, Information, Development, Group Link and other Social links." +
    "\n\n" +
    "In case you have an issue or a great recommentation in your mind, " +
    "please join the Group from the Channel and write it down! But take in mind " +
    "you can only speak in English, thanks!";
  @override
  String get labelRemindLater => "Remind Later";

  // Common Words (One word labels)
  @override
  String get labelExit => "Exit";
  @override
  String get labelSystem => "System";
  @override
  String get labelChannel => "Channel";
  @override
  String get labelShare => "Share";
  @override
  String get labelAudio => "Audio";
  @override
  String get labelVideo => "Video";
  @override
  String get labelDownload => "Download";
  @override
  String get labelBest => "Best";
  @override
  String get labelPlaylist => "Playlist";
  @override
  String get labelVersion => "Version";
  @override
  String get labelLanguage => "Language";
  @override
  String get labelGrant => "Grant";
  @override
  String get labelAllow => "Allow";
  @override
  String get labelAccess => "Access";
  @override
  String get labelEmpty => "Empty";
  @override
  String get labelCalculating => "Calculating";
  @override
  String get labelCleaning => "Cleaning";
  @override
  String get labelCancel => "Cancel";
  @override
  String get labelGeneral => "General";
  @override
  String get labelRemove => "Remove";
  @override
  String get labelJoin => "Join";
  @override
  String get labelNo => "No";
  @override
  String get labelLibrary => "Library";
  @override
  String get labelCreate => "Create";
  @override
  String get labelPlaylists => "Playlists";
  @override
  String get labelQuality => "Quality";
  @override
  String get labelSubscribe => "Subscribe";
}