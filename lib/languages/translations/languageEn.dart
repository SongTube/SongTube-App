import 'package:songtube/languages/languages.dart';

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