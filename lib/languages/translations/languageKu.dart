import 'package:songtube/languages/languages.dart';

class LanguageKu extends Languages {

  // Introduction Screens
  @override
  String get labelAppWelcome => "بەخێربیت بۆ";
  @override
  String get labelStart => "دەستپێکردن";
  @override
  String get labelSkip => "بازدان";
  @override
  String get labelNext => "دواتر";
  @override
  String get labelExternalAccessJustification =>
    "پێویستی بە چوونە ژورەوە هەیە بۆ کۆگای دەرەکی بۆ پاراستنی هەموو " +
    "ڤیدیۆکان و مۆسیقاکەت";
  @override
  String get labelAppCustomization => "تایبەتمەندکردن";
  @override
  String get labelSelectPreferred => "هەڵبژێرە پەسەندکراوەکەت";
  @override
  String get labelConfigReady => "شێوەپێدان ئامادەیە";
  @override
  String get labelIntroductionIsOver => "پێشەکی تەواو بوو";
  @override
  String get labelEnjoy => "چێژ وەرگرە";
  @override 
  String get labelGoHome => "بڕۆرەوە بۆ ماڵێ";

  // Bottom Navigation Bar
  @override
  String get labelHome => "ماڵەوە";
  @override
  String get labelDownloads => "داگرتنەکان";
  @override
  String get labelMedia => "میدیا";
  @override
  String get labelYouTube => "یوتوب";
  @override
  String get labelMore => "زیاتر";

  // Home Screen
  @override
  String get labelQuickSearch => "گەڕانی خێرا...";
  @override
  String get labelTagsEditor => "تاگەکان\nسەرنووسەر";
  @override
  String get labelEditArtwork => "بژارکردن\nکاری هونەری";
  @override
  String get labelDownloadAll => "داگرتنی هەموو";
  @override 
  String get labelLoadingVideos => "بارکردنی ڤیدیۆکان...";
  @override
  String get labelHomePage => "پەڕەی سەرەکی";
  @override
  String get labelTrending => "ئاڕاستەکردن";
  @override
  String get labelFavorites => "دڵخوازەکان";
  @override
  String get labelWatchLater => "دواتر سەیری بکە";

  // Video Options Menu
  @override
  String get labelCopyLink => "کۆپیکردنی لینک";
  @override
  String get labelAddToFavorites => "زیادکردن بۆ دڵخوازەکان";
  @override
  String get labelAddToWatchLater => "زیادکردن بۆ چاودێری دواتر";
  @override
  String get labelAddToPlaylist => "زیادکردن بۆ لیستی پەخشکردن";

  // Downloads Screen
  @override
  String get labelQueued => "ڕێز";
  @override
  String get labelDownloading => "داگرتن";
  @override
  String get labelConverting => "گۆڕین";
  @override
  String get labelCancelled => "هەڵەوەشاندنەوە";
  @override
  String get labelCompleted => "تەواوبوو";

  // Download Status/Error Messages
  @override
  String get labelDownloadQueued => "دابەزاندنی ڕیزکراو";
  @override
  String get labelDownloadAcesssDenied => "چوونەژوورەوە ڕەتکرایەوە";
  @override
  String get labelClearingExistingMetadata => "سڕینەوەی میتاداتای بەردەست...";
  @override
  String get labelWrittingTagsAndArtwork => "نوسینی تاگەکان & کاری هونەری...";
  @override
  String get labelSavingFile => "هەڵگرتنی فایل...";
  @override
  String get labelAndroid11FixNeeded => "هەڵە، چارەسەری ئەندرۆید 11 پێویستە، ڕێکبەندەکان بپشکنە";
  @override
  String get labelErrorSavingDownload => "نەیتوانی دابەزاندنەکەت پاشەکەوت بکات، مۆڵەتەکان بپشکنە";
  @override
  String get labelDownloadingVideo => "داگرتنی ڤیدیۆ...";
  @override
  String get labelDownloadingAudio => "داگرتنی گۆرانی...";
  @override
  String get labelGettingAudioStream => "دەستکەوتنی شەپۆلی دەنگ...";
  @override
  String get labelAudioNoDataRecieved => "ناتوانێت ئاودیۆ ستریم بەدەست بهێنێت";
  @override
  String get labelDownloadStarting => "دەستیکرد بە داگرتن...";
  @override
  String get labelDownloadCancelled => "داگرتن هەڵەوەشایەوە";
  @override
  String get labelAnIssueOcurredConvertingAudio => "پرۆسەی گۆڕاو سەرکەوتوو نەبوو";
  @override
  String get labelPatchingAudio => "پیچکردنی دەنگ...";

  // Download Menu
  @override
  String get labelEnableAudioConversion => "چالاککردنی گۆڕینی دەنگ";
  @override
  String get labelGainControls => "دەستکەوتنی کۆنترۆڵەکان";
  @override
  String get labelVolume => "قەبارە";
  @override
  String get labelBassGain => "بەیس گەینس";
  @override
  String get labelTrebleGain => "ترێبڵ گەینس";
  @override
  String get labelSelectVideo => "ڤیدیۆ هەڵبژێرە";
  @override
  String get labelSelectAudio => "گۆرانی هەڵبژێرە";
  @override
  String get labelGlobalParameters => "پارامیتەرە جیهانیەکان";

  // Media Screen
  @override
  String get labelMusic => "مۆسیقا";
  @override
  String get labelVideos => "ڤیدیۆکان";
  @override
  String get labelNoMediaYet => "میدیا نیە";
  @override
  String get labelNoMediaYetJustification => "هەموو میدیاکەت " +
    "لێرە پیشان دەدرێت";
  @override
  String get labelSearchMedia => "گەڕان بۆ میدیاکان...";
  @override
  String get labelDeleteSong => "سرینەوەی گۆرانی";
  @override
  String get labelNoPermissionJustification => "پیشاندانی میدیاکەت بەپێی" + "\n" +
    "پێدانی مۆڵەتی کۆگا";
  @override
  String get labelGettingYourMedia => "دەستخستنی میدیاکەت...";
  @override
  String get labelEditTags => "دەستکاری تاگەکان بکە";

  // Navigate Screen
  @override
  String get labelSearchYoutube => "گەران لە یوتوز...";

  // More Screen
  @override
  String get labelSettings => "ڕێبەندەکان";
  @override
  String get labelDonate => "بەخشین";
  @override
  String get labelLicenses => "مۆڵەتەکان";
  @override
  String get labelChooseColor => "ڕەنگ هەڵبژێرە";
  @override
  String get labelTheme => "ڕووگار";
  @override
  String get labelUseSystemTheme => "بەکارهێنانی ڕووکاری سیستەم";
  @override
  String get labelUseSystemThemeJustification =>
    "چالاککردن/لەکارخستنی ڕووکاری ئۆتۆماتیکی";
  @override
  String get labelEnableDarkTheme => "چالاککردنی دۆخی دارک مۆد";
  @override
  String get labelEnableDarkThemeJustification =>
    "بەکارهێنانی ثیمێکی تۆخ بە شێوەی گریمانەیی";
  @override
  String get labelEnableBlackTheme => "چالاککردنی ثیمێکی ڕەش";
  @override
  String get labelEnableBlackThemeJustification =>
    "چالاککردنی ثیمێکی ڕەشی بێگەرد";
  @override
  String get labelAccentColor => "ڕەنگی شێوە";
  @override
  String get labelAccentColorJustification => "تایبەتمەندکردنی ڕەنگی شێوە";
  @override
  String get labelAudioFolder => "فۆڵدەری دەنگ";
  @override
  String get labelAudioFolderJustification => "فۆڵدەرێک هەڵبژێرە بۆ " +
    "داگرتنەکانی دەنگ";
  @override
  String get labelVideoFolder => "فۆلدەری ڤیدیۆ";
  @override
  String get labelVideoFolderJustification => "فۆڵدەرێک هەڵبژێرە بۆ " +
    "داگرتنەکانی ڤیدیۆ";
  @override
  String get labelAlbumFolder => "فۆڵدەری ئەلبوم";
  @override
  String get labelAlbumFolderJustification => "دروستکردنی فۆڵدەرێک بۆ هەر ئەلبومێکی گۆرانی";
  @override
  String get labelDeleteCache => "سڕینەوەی حەشارگە";
  @override
  String get labelDeleteCacheJustification => "سڕینەوەی حەشارگەی  SongTube";
  @override
  String get labelAndroid11Fix => "Android 11 چاسەرکرا";
  @override
  String get labelAndroid11FixJustification => "چارەسەرکردنی کێشەکانی داگرتن لەسەر " +
    "Android 10 & 11";
  @override
  String get labelBackup => "پاشەکەوتکردن";
  @override
  String get labelBackupJustification => "پاشەکەوتکردنی کتێبخانەی میدیا";
  @override
  String get labelRestore => "گەراندنەوە";
  @override
  String get labelRestoreJustification => "گەڕاندنەوەی کتێبخانەی میدیا";
  @override
  String get labelBackupLibraryEmpty => "کتێبخانەکەت بەتاڵە";
  @override
  String get labelBackupCompleted => "پاشەکەوت تەواو بوو";
  @override
  String get labelRestoreNotFound => "گەڕاندنەوە نەدۆزرایەوە";
  @override
  String get labelRestoreCompleted => "گەڕاندنەوەی تەواوکراو";
  @override
  String get labelCacheIsEmpty => "خەزن بەتاڵە";
  @override
  String get labelYouAreAboutToClear => "تۆ خەریکە خاوێنی دەکەیتەوە";

  // Tags Editor TextFields
  @override
  String get labelEditorTitle => "ناونیشان";
  @override
  String get labelEditorArtist => "هونەرمەند";
  @override
  String get labelEditorGenre => "ڕەگەز";
  @override
  String get labelEditorDisc => "دیسک";
  @override
  String get labelEditorTrack => "تراک";
  @override
  String get labelEditorDate => "بەروار";
  @override
  String get labelEditorAlbum => "ئەلبوم";

  // Android 10 or 11 Detected Dialog
  @override
  String get labelAndroid11Detected => "ئەندرۆید 10 یان 11 دۆزرایەوە";
  @override
  String get labelAndroid11DetectedJustification => "بۆ دڵنیابوون لە دروستی " +
    "کارپێکردنی داگرتنی ئەم کاربەرنامەیە، لە ئەندرۆید 10 و 11، دەستگەیشتن بە هەموو " +
    "لەوانەیە مۆڵەتی فایلەکان پێویست بێت، ئەمە کاتی دەبێت و پێویست ناکات " +
    "لەسەر نوێکردنەوەکانی داهاتوو. هەروەها دەتوانیت ئەم چاککردنە لە ڕێکبەندەکاندا جێبەجێ بکەیت.";

  // Music Player
  @override
  String get labelPlayerSettings => "ڕێکبەندەکانی پەخشکراو";
  @override
  String get labelExpandArtwork => "فراوانکردنی کاری هونەری";
  @override
  String get labelArtworkRoundedCorners => "کاری هونەری گۆشە خڕکراوەکان";
  @override
  String get labelPlayingFrom => "پەخشکراوە لە";
  @override
  String get labelBlurBackground => "باکگراوندی تاریک";

  // Video Page
  @override
  String get labelTags => "تاگەکان";
  @override
  String get labelRelated => "پەیوەندیدار";
  @override
  String get labelAutoPlay => "پەخشکردنی خۆکار";

  // Tags Pages
  @override
  String get labelAudioFormatNotCompatible =>
    "فۆرماتی دەنگ گونجاو نیە";
  @override
  String get labelNotSpecified => "دیاری نەکراوە";
  @override
  String get labelPerformAutomaticTagging => 
    "نمایشکردنی تاگی ئۆتۆماتیکی";
  @override
  String get labelSelectTagsfromMusicBrainz => 
    "تاگەکان دیاریبکە لە MusicBrainz";
  @override
  String get labelSelectArtworkFromDevice =>
    "کاری هونەری دیاریبکە لە ئامێرەوە";

  // Telegram Join Channel Dialog
  @override
  String get labelJoinTelegramChannel => "پەیوەندی بکە بە کەناڵی تلگرام!";
  @override
  String get labelJoinTelegramJustification =>
    "ئایا حەزت لە سۆنگ بۆیوبە؟ تکایە پەیوەندی بکە بە کەناڵی تەلگرامەوە! تۆ دەدۆزیتەوە " +
    "نوێکردنەوەکان، زانیاری، گەشەپێدان، لینکی گروپ و لینکە کۆمەڵایەتیەکانی تر." +
    "\n\n" +
    "لەحاڵێکدا کە تۆ کێشەیەکت هەیە یان دووبارە کردنەوەیەکی گەورە لە مێشکتدا, " +
    "تکایە لە کەناڵەکەوە بەشداری گروپەکە بکە و بینووسە! بەڵام لەبیری بکە " +
    "تەنها دەتوانیت بە ئینگلیزی قسە بکەیت، سوپاس!";
  @override
  String get labelRemindLater => "دواتر بیرخەرەوە";

  // Common Words (One word labels)
  @override
  String get labelExit => "دەرچوون";
  @override
  String get labelSystem => "سیستەم";
  @override
  String get labelChannel => "کەناڵ";
  @override
  String get labelShare => "هاوبەشکردن";
  @override
  String get labelAudio => "گۆرانی";
  @override
  String get labelVideo => "ڤیدیۆ";
  @override
  String get labelDownload => "داگرتن";
  @override
  String get labelBest => "باشترین";
  @override
  String get labelPlaylist => "لیستی پەخشکردن";
  @override
  String get labelVersion => "وەشان";
  @override
  String get labelLanguage => "زمان";
  @override
  String get labelGrant => "بەخشین";
  @override
  String get labelAllow => "ڕێپێدان";
  @override
  String get labelAccess => "چوونەژوورەوە";
  @override
  String get labelEmpty => "بەتاڵ";
  @override
  String get labelCalculating => "ژماردن";
  @override
  String get labelCleaning => "پاککردنەوە";
  @override
  String get labelCancel => "هەڵوەشاندنەوه";
  @override
  String get labelGeneral => "گشتی";
  @override
  String get labelRemove => "سرینەوە";
  @override
  String get labelJoin => "بچۆ ناوەوە";
  @override
  String get labelNo => "نەخێر";
  @override
  String get labelLibrary => "کتێبخانە";
  @override
  String get labelCreate => "درووستکردن";
  @override
  String get labelPlaylists => "لیستەکانی پەخشکردن";
  @override
  String get labelQuality => "کوالێتی";
  @override
  String get labelSubscribe => "بەشداریکردن";

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