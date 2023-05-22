import 'package:songtube/languages/languages.dart';

class LanguageBn extends Languages {

  // Introduction Screens
  @override
  String get labelAppWelcome => "স্বাগতম";
  @override
  String get labelStart => "শুরু করুণ";
  @override
  String get labelSkip => "এড়িয়ে যান";
  @override
  String get labelNext => "পরবর্তী";
  @override
  String get labelExternalAccessJustification =>
      "আপনার ভিডিও এবং গানগুলি সেভ করার জন্য আপনার ফোনের স্টোরেজ ব্যবহারের অনুমতি দিন";
  @override
  String get labelAppCustomization => "কাস্টমাইজ করুন";
  @override
  String get labelSelectPreferred => "আপনার পছন্দ বাছাই করুন";
  @override
  String get labelConfigReady => "কনফিগ প্রস্তুত আছে";
  @override
  String get labelIntroductionIsOver => "ভুমিকা শেষ";
  @override
  String get labelEnjoy => "উপোভোগ করুন";
  @override
  String get labelGoHome => "হোমে যান";

  // Bottom Navigation Bar
  @override
  String get labelHome => "হোম";
  @override
  String get labelDownloads => "ডাউনলোড";
  @override
  String get labelMedia => "মিডিয়া";
  @override
  String get labelYouTube => "ইঊটিউব";
  @override
  String get labelMore => "আরও";

  // Home Screen
  @override
  String get labelQuickSearch => "খুজুন...";
  @override
  String get labelTagsEditor => "ট্যাগ\nএডিটর";
  @override
  String get labelEditArtwork => "আর্টওয়ার্ক\nপরিবর্তন";
  @override
  String get labelDownloadAll => "সব ডাউনলোড করুন";
  @override
  String get labelLoadingVideos => "ভিডিও লোড হচ্ছে...";
  @override
  String get labelHomePage => "হোম পাতা";
  @override
  String get labelTrending => "চলমান";
  @override
  String get labelFavorites => "পছন্দ";
  @override
  String get labelWatchLater => "পরে দেখবো";

  // Video Options Menu
  @override
  String get labelCopyLink => "কপি লিঙ্ক";
  @override
  String get labelAddToFavorites => "পছন্দের তালিকায় যোগ করুন";
  @override
  String get labelAddToWatchLater => "পরে দেখার তালিকায় যোগ করুন";
  @override
  String get labelAddToPlaylist => "প্লে লিস্টে যোগ করুন";

  // Downloads Screen
  @override
  String get labelQueued => "সারিবদ্ধ আছে";
  @override
  String get labelDownloading => "ডাউনলোড হচ্ছে";
  @override
  String get labelConverting => "কনভার্ট হচ্ছে";
  @override
  String get labelCancelled => "বাতিল হয়ে গেছে";
  @override
  String get labelCompleted => "শেষ হয়ে গেছে";

  // Download Status/Error Messages
  @override
  String get labelDownloadQueued => "সারি থেকে ডাউনলোড করুন";
  @override
  String get labelDownloadAcesssDenied => "অনুমতি দেয়নাই";
  @override
  String get labelClearingExistingMetadata => "মেটাডাটা মুছে ফেলা হচ্ছে...";
  @override
  String get labelWrittingTagsAndArtwork => "ট্যাগ এবং ছবি দেওয়া হচ্ছে...";
  @override
  String get labelSavingFile => "ফাইলটা সেভ করা হচ্ছে...";
  @override
  String get labelAndroid11FixNeeded => "ত্রুটি, Android 11 ঠিক করা প্রয়োজন, সেটিংস দেখুন";
  @override
  String get labelErrorSavingDownload => "আপনার ডাউনলোডটি সেভ করতে পারি নি, অনুমতি দেখুন";
  @override
  String get labelDownloadingVideo => "ভিডিও ডাউনলোড হচ্ছে...";
  @override
  String get labelDownloadingAudio => "অডিও ডাউনলোড হচ্ছে...";
  @override
  String get labelGettingAudioStream => "অডিও প্রবাহ নিচ্ছি...";
  @override
  String get labelAudioNoDataRecieved => "অডিও প্রবাহ নিতে পারি নি";
  @override
  String get labelDownloadStarting => "ডাউনলোড শুরু হচ্ছে...";
  @override
  String get labelDownloadCancelled => "ডাউনলোড বাতিল করা হয়েছে";
  @override
  String get labelAnIssueOcurredConvertingAudio => "কনভার্ট সম্বভ হয়নি";
  @override
  String get labelPatchingAudio => "অডিও প্যাচিং হচ্ছে...";

  // Download Menu
  @override
  String get labelEnableAudioConversion => "অডিও কনভার্শন সক্ষম করুন";
  @override
  String get labelGainControls => "গেইন নিয়ন্ত্রন";
  @override
  String get labelVolume => "শব্দের পরিমান";
  @override
  String get labelBassGain => "বেইস এর গেইন";
  @override
  String get labelTrebleGain => "ট্রেবল এর গেইন";
  @override
  String get labelSelectVideo => "ভিডিও পছন্দ করুন";
  @override
  String get labelSelectAudio => "অডিও পছন্দ করুন";
  @override
  String get labelGlobalParameters => "গ্লোবাল প্যারামিটার";

  // Media Screen
  @override
  String get labelMusic => "সঙ্গীত";
  @override
  String get labelVideos => "ভিডিও";
  @override
  String get labelNoMediaYet => "কোনো মিডিয়া নাই";
  @override
  String get labelNoMediaYetJustification => "আপনার সকল মিডিয়া " +
      "এখানে দেখানো হবে";
  @override
  String get labelSearchMedia => "মিডিয়া খোজা হচ্ছে...";
  @override
  String get labelDeleteSong => "সঙ্গীত মুছে ফেলা হচ্ছে";
  @override
  String get labelNoPermissionJustification => "স্টোরেজের অনুমতি দিয়ে" + "\n" +
      "আপনার সকল মিডিয়া দেখুন";
  @override
  String get labelGettingYourMedia => "মিডিয়া আনা হচ্ছে...";
  @override
  String get labelEditTags => "ট্যাগ পরিবর্তন করুন";

  // Navigate Screen
  @override
  String get labelSearchYoutube => "ইউটিউবে খুজুন...";

  // More Screen
  @override
  String get labelSettings => "সেটিংস";
  @override
  String get labelDonate => "সহায়তা করুন";
  @override
  String get labelLicenses => "লাইসেন্স";
  @override
  String get labelChooseColor => "রঙ পছন্দ করুন";
  @override
  String get labelTheme => "থিম";
  @override
  String get labelUseSystemTheme => "সিস্টেমের থিম ব্যবহার করুন";
  @override
  String get labelUseSystemThemeJustification =>
      "অটোম্যাটিক থিম সক্ষম বা অক্ষম করুন";
  @override
  String get labelEnableDarkTheme => "অন্ধকার থিম সেট করুন";
  @override
  String get labelEnableDarkThemeJustification =>
      "ডিফল্টভাবে অন্ধকার থিম ব্যবহার করুন";
  @override
  String get labelEnableBlackTheme => "কালো থিম সেট করুন";
  @override
  String get labelEnableBlackThemeJustification =>
      "কুচকুচে কালো থিম সেট করুন";
  @override
  String get labelAccentColor => "আক্সেন্ট রঙ";
  @override
  String get labelAccentColorJustification => "আক্সেন্ট রঙ কাস্টমাইজ করুন";
  @override
  String get labelAudioFolder => "অডিওর ফোল্ডার";
  @override
  String get labelAudioFolderJustification => "ওডিও ডাউনলোড করার জন্য ফোল্ডার পছন্দ করুন";
  @override
  String get labelVideoFolder => "ভিডিওর ফোল্ডার";
  @override
  String get labelVideoFolderJustification => "ভিডিও ডাউনলোড করার জন্য ফোল্ডার পছন্দ করুন";
  @override
  String get labelAlbumFolder => "অ্যালবামের ফোল্ডার";
  @override
  String get labelAlbumFolderJustification => "সব অ্যালবামের জন্য আলাদা ফোল্ডার তৈরি করুন";
  @override
  String get labelDeleteCache => "ক্যাশ মুছে ফেলুন";
  @override
  String get labelDeleteCacheJustification => "SongTube এর ক্যাশ মুছে ফেলুন";
  @override
  String get labelAndroid11Fix => "Android 11 ঠিক";
  @override
  String get labelAndroid11FixJustification => "Android 10 ও 11 এর জন্য ডাউনলোডের ইস্যু গুলি ঠিক করা হয়েছে";
  @override
  String get labelBackup => "ব্যাকআপ";
  @override
  String get labelBackupJustification => "আপনার মিডিয়া লাইব্রেরি ব্যাকআপ করুন";
  @override
  String get labelRestore => "ফিরিয়ে আনুন";
  @override
  String get labelRestoreJustification => "আপনার মিডিয়া লাইব্রেরি ফিরিয়ে আনুন";
  @override
  String get labelBackupLibraryEmpty => "আপনার লাইব্রেরি ফাকা";
  @override
  String get labelBackupCompleted => "ব্যাকআপ সম্পন্ন হয়েছে";
  @override
  String get labelRestoreNotFound => "পুরোনো তথ্য পাওয়া যায়নি";
  @override
  String get labelRestoreCompleted => "ফিরিয়ে আনা সম্পন্ন হয়েছে";
  @override
  String get labelCacheIsEmpty => "ক্যাশ খালি";
  @override
  String get labelYouAreAboutToClear => "আপনি সব খালি করতে চলেছেন";

  // Tags Editor TextFields
  @override
  String get labelEditorTitle => "শিরোনাম";
  @override
  String get labelEditorArtist => "শিল্পী";
  @override
  String get labelEditorGenre => "ধারা";
  @override
  String get labelEditorDisc => "ডিস্ক";
  @override
  String get labelEditorTrack => "ট্র্যাক";
  @override
  String get labelEditorDate => "তারিখ";
  @override
  String get labelEditorAlbum => "এ্যালবাম";

  // Android 10 or 11 Detected Dialog
  @override
  String get labelAndroid11Detected => "Android 10 অথবা 11 সনাক্ত হয়েছে";
  @override
  String get labelAndroid11DetectedJustification => "Android 10 এবং 11 এ এই অ্যাপ ডাউনলোডের সঠিক কার্যকারিতা নিশ্চিত করার জন্য, সমস্ত ফাইলের অনুমতি গ্রহনের প্রয়োজন হতে পারে, এটি সাময়িক হবে এবং ভবিষ্যতের আপডেটে প্রয়োজন হবে না। আপনি সেটিংসেও এই ফিক্স প্রয়োগ করতে পারেন।";

  // Music Player
  @override
  String get labelPlayerSettings => "প্লেয়ারের সেটিংস";
  @override
  String get labelExpandArtwork => "অঙ্কন বড় করুন";
  @override
  String get labelArtworkRoundedCorners => "অঙ্কনের গোলাকার কর্ণার";
  @override
  String get labelPlayingFrom => "প্লে করা হচ্ছে";
  @override
  String get labelBlurBackground => "ঘোলা বাকগ্রাউন্ড";

  // Video Page
  @override
  String get labelTags => "ট্যাগগুলি";
  @override
  String get labelRelated => "সম্পর্কিত";
  @override
  String get labelAutoPlay => "অটো প্লে";

  // Tags Pages
  @override
  String get labelAudioFormatNotCompatible =>
      "অডিও ফরমাট সামঞ্জস্যপুর্ণ নয়";
  @override
  String get labelNotSpecified => "নির্দিষ্ট করা নাই";
  @override
  String get labelPerformAutomaticTagging =>
      "অটোমেটিক ট্যাগিং করা হচ্ছে";
  @override
  String get labelSelectTagsfromMusicBrainz =>
      "MusicBrainz থেকে ট্যাগ পছন্দ করুন";
  @override
  String get labelSelectArtworkFromDevice =>
      "ডিভাইস থেকে অঙ্কন পছন্দ করুন";

  // Telegram Join Channel Dialog
  @override
  String get labelJoinTelegramChannel => "টেলিগ্রাম চ্যানেলে যোগ দিন!";
  @override
  String get labelJoinTelegramJustification =>
      "আপনি কি SongTube পছন্দ করছেন? দয়া করে টেলিগ্রাম চ্যানেলে যোগ দিন! আপনি আপডেট, তথ্য, উন্নয়ন, গ্রুপ লিঙ্ক এবং অন্যান্য সামাজিক লিঙ্ক পাবেন।" +
          "\n\n" +
          "যদি আপনার কোন সমস্যা বা আপনার সুপারিশ থাকে তবে দয়া করে চ্যানেল থেকে গ্রুপে যোগ দিন এবং এটি লিখুন! কিন্তু মনে রাখবেন আপনি শুধুমাত্র ইংরেজিতে কথা বলতে পারেন, ধন্যবাদ!";
  @override
  String get labelRemindLater => "পরে মনে করিয়ে দিন";

  // Common Words (One word labels)
  @override
  String get labelExit => "বের হন";
  @override
  String get labelSystem => "সিস্টেম";
  @override
  String get labelChannel => "চ্যানেল";
  @override
  String get labelShare => "শেয়ার";
  @override
  String get labelAudio => "অডিও";
  @override
  String get labelVideo => "ভিডিও";
  @override
  String get labelDownload => "ডাউনলোড";
  @override
  String get labelBest => "সর্বোত্তম";
  @override
  String get labelPlaylist => "প্লে লিস্ট";
  @override
  String get labelVersion => "সংস্করণ";
  @override
  String get labelLanguage => "ভাষা";
  @override
  String get labelGrant => "প্রদান";
  @override
  String get labelAllow => "অনুমতি দিন";
  @override
  String get labelAccess => "প্রবেশাধিকার";
  @override
  String get labelEmpty => "খালি";
  @override
  String get labelCalculating => "হিসাব করা হচ্ছে";
  @override
  String get labelCleaning => "পরিস্কার করা হচ্ছে";
  @override
  String get labelCancel => "বাতিল";
  @override
  String get labelGeneral => "সাধারণ";
  @override
  String get labelRemove => "অপসারণ";
  @override
  String get labelJoin => "যোগদান";
  @override
  String get labelNo => "না";
  @override
  String get labelLibrary => "লাইব্রেরি";
  @override
  String get labelCreate => "তৈরি করুন";
  @override
  String get labelPlaylists => "প্লে লিস্টের তালিকা";
  @override
  String get labelQuality => "মান";
  @override
  String get labelSubscribe => "সাবস্ক্রাইব";

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