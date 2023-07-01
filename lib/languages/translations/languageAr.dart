import 'package:songtube/languages/languages.dart';

class LanguageAr extends Languages {

  // Introduction Screens
  @override
  String get labelAppWelcome => "أهلاً بك في ";
  @override
  String get labelStart => "ابدأ";
  @override
  String get labelSkip => "تخطي";
  @override
  String get labelNext => "التالي";
  @override
  String get labelExternalAccessJustification =>
    "أحتاج الوصول إلى ذاكرة التخزين الداخلية الخاصة بجهازك لحفظ كل" +
    "مقاطع الفيديو والموسيقى الخاصة بك";
  @override
  String get labelAppCustomization => "تخصيص";
  @override
  String get labelSelectPreferred => "حدد تفضيلاتك";
  @override
  String get labelConfigReady => "التكوين جاهز";
  @override
  String get labelIntroductionIsOver => "تم الإعداد ";
  @override
  String get labelEnjoy => "استمتع";
  @override 
  String get labelGoHome => "الذهاب للقائمة الرئيسية";

  // Bottom Navigation Bar
  @override
  String get labelHome => "القائمة الرئيسية";
  @override
  String get labelDownloads => "التنزيلات";
  @override
  String get labelMedia => "الوسائط";
  @override
  String get labelYouTube => "يوتيوب";
  @override
  String get labelMore => "المزيد...";

  // Home Screen
  @override
  String get labelQuickSearch => "بحث سريع...";
  @override
  String get labelTagsEditor => "إشارة\محرر";
  @override
  String get labelEditArtwork => "تعديل\الأعمال الفنية";
  @override
  String get labelDownloadAll => "تحميل الكل";
  @override 
  String get labelLoadingVideos => "يتم تحميل الفيديوهات";
  @override
  String get labelHomePage => "الصفحة الرئيسية";
  @override
  String get labelTrending => "المحتوى الشائع";
  @override
  String get labelFavorites => "المفضلة";
  @override
  String get labelWatchLater => "المشاهدة لاحقاً";

  // Video Options Menu
  @override
  String get labelCopyLink => "نسخ الرابط";
  @override
  String get labelAddToFavorites => "إضافة إلى المفضلة";
  @override
  String get labelAddToWatchLater => "إضافة إلى قائمة المشاهدة لاحقاً";
  @override
  String get labelAddToPlaylist => "إضافة إلى قائمة التشغيل";

  // Downloads Screen
  @override
  String get labelQueued => "في قائمة الانتظار";
  @override
  String get labelDownloading => "جاري التحميل";
  @override
  String get labelConverting => "التحويل";
  @override
  String get labelCancelled => "تم الإلغاء";
  @override
  String get labelCompleted => "تم التنزيل";

  // Download Status/Error Messages
  @override
  String get labelDownloadQueued => "التنزيل في قائمة الانتظار";
  @override
  String get labelDownloadAcesssDenied => "إذن الوصول للملفات غير مفعل !";
  @override
  String get labelClearingExistingMetadata => "مسح البيانات الوصفية...";
  @override
  String get labelWrittingTagsAndArtwork => "كتابة العلامات والأعمال الفنية...";
  @override
  String get labelSavingFile => "حفظ الملف...";
  @override
  String get labelAndroid11FixNeeded => 
"خطأ ،  أندرويد 11 يجب إصلاحه ، تحقق من الإعدادات";
  @override
  String get labelErrorSavingDownload => "تعذر حفظ التنزيل ، تحقق من الأذونات";
  @override
  String get labelDownloadingVideo => "تحميل الفيديو ...";
  @override
  String get labelDownloadingAudio => "تحميل الصوت ...";
  @override
  String get labelGettingAudioStream => "الحصول على دفق الصوت ...";
  @override
  String get labelAudioNoDataRecieved => "تعذر الحصول على دفق الصوت";
  @override
  String get labelDownloadStarting => "بدء التنزيل ...";
  @override
  String get labelDownloadCancelled => "تم إلغاء التنزيل!";
  @override
  String get labelAnIssueOcurredConvertingAudio => "فشلت عملية التحويل";
  @override
  String get labelPatchingAudio => "يتم تصحيح الصوت ...";

  // Download Menu
  @override
  String get labelEnableAudioConversion => "تم تفعيل تحويل الصوت";
  @override
  String get labelGainControls => "أدوات الزيادة";
  @override
  String get labelVolume => "الصوت";
  @override
  String get labelBassGain => "مضاعفة الصوت";
  @override
  String get labelTrebleGain => "مضاعفة لثلاث اضعاف";
  @override
  String get labelSelectVideo => "اختر الفيديو";
  @override
  String get labelSelectAudio => "اختر الصوت";
  @override
  String get labelGlobalParameters => "المعايير العالمية";

  // Media Screen
  @override
  String get labelMusic => "الموسيقى";
  @override
  String get labelVideos => "الفيديوهات ";
  @override
  String get labelNoMediaYet => "لا توجد وسائط حتى الآن";
  @override
  String get labelNoMediaYetJustification => "كل الوسائط " +
    "ستظهر هنا";
  @override
  String get labelSearchMedia => "بحث في الوسائط ...";
  @override
  String get labelDeleteSong => "حذف الأغنية";
  @override
  String get labelNoPermissionJustification => "عرض الوسائط الخاصة بك عن طريق" + "\n" +
    "منح إذن التخزين";
  @override
  String get labelGettingYourMedia => "عرض الوسائط الخاصة بك هنا ...";
  @override
  String get labelEditTags => "تعديل العلامات";

  // Navigate Screen
  @override
  String get labelSearchYoutube => "بحث في يوتيوب ...";

  // More Screen
  @override
  String get labelSettings => "الإعدادات";
  @override
  String get labelDonate => "تبرع";
  @override
  String get labelLicenses => "التراخيص";
  @override
  String get labelChooseColor => "اختر اللون";
  @override
  String get labelTheme => "الثيمات";
  @override
  String get labelUseSystemTheme => "استخدم سمة النظام";
  @override
  String get labelUseSystemThemeJustification =>
    "تفعيل / تعطيل المظهر التلقائي";
  @override
  String get labelEnableDarkTheme => "تفعيل المظهر الداكن";
  @override
  String get labelEnableDarkThemeJustification =>
    "تفعيل المظهر الداكن إفتراضياً";
  @override
  String get labelEnableBlackTheme => "تفعيل المظهر الداكن";
  @override
  String get labelEnableBlackThemeJustification =>
    "تفعيل تصحيح مظهر الاسود الداكن";
  @override
  String get labelAccentColor => "لون التمييز";
  @override
  String get labelAccentColorJustification => "لون التمييز المخصص";
  @override
  String get labelAudioFolder => "مجلد الصوت";
  @override
  String get labelAudioFolderJustification => "اختر مجلداً لـ " +
    "تنزيلات الصوت";
  @override
  String get labelVideoFolder => "مجلد الفيديو";
  @override
  String get labelVideoFolderJustification => "اختر مجلدًا لـ " +
    "تنزيلات الفيديو";
  @override
  String get labelAlbumFolder => "مجلد الألبوم";
  @override
  String get labelAlbumFolderJustification => "قم بإنشاء مجلد لكل ألبوم أغنية";
  @override
  String get labelDeleteCache => "حذف ذاكرة التخزين المؤقت";
  @override
  String get labelDeleteCacheJustification => "امسح ذاكرة التخزين المؤقت بالضبط";
  @override
  String get labelAndroid11Fix => "إصلاح أندرويد 11";
  @override
  String get labelAndroid11FixJustification => "يعمل على إصلاح مشكلات التنزيل " +
    "Android 10 & 11";
  @override
  String get labelBackup => "نسخ احتياطي";
  @override
  String get labelBackupJustification => "قم بعمل نسخة احتياطية من مكتبة الوسائط الخاصة بك";
  @override
  String get labelRestore => "استعادة";
  @override
  String get labelRestoreJustification => "قم باستعادة مكتبة الوسائط الخاصة بك";
  @override
  String get labelBackupLibraryEmpty => "مكتبتك فارغة";
  @override
  String get labelBackupCompleted => "اكتمل النسخ الاحتياطي";
  @override
  String get labelRestoreNotFound => "لم يتم العثور على نسخة احتياطية للاستعادة";
  @override
  String get labelRestoreCompleted => "اكتملت الاستعادة";
  @override
  String get labelCacheIsEmpty => "ذاكرة التخزين المؤقت فارغة";
  @override
  String get labelYouAreAboutToClear => "أنك على وشك التنظيف";

  // Tags Editor TextFields
  @override
  String get labelEditorTitle => "عنوان";
  @override
  String get labelEditorArtist => "الفنان";
  @override
  String get labelEditorGenre => "النوع";
  @override
  String get labelEditorDisc => "قرص";
  @override
  String get labelEditorTrack => "المسار";
  @override
  String get labelEditorDate => "التاريخ";
  @override
  String get labelEditorAlbum => "الالبوم";

  // Android 10 or 11 Detected Dialog
  @override
  String get labelAndroid11Detected =>
 " تم اكتشاف أن جهازك أندرويد 10 أو 11";
  @override
  String get labelAndroid11DetectedJustification => "للتأكد من صحة ملف " +
    "أداء هذا التطبيق التنزيلات ، على أندرويد 10 و 11 ، والوصول إلى الجميع " +
    "قد تكون هناك حاجة إلى إذن الملفات ، سيكون هذا مؤقتًا وغير مطلوب " +
    "في التحديثات المستقبلية ، يمكنك أيضًا تطبيق هذا الإصلاح في الإعدادات.";

  // Music Player
  @override
  String get labelPlayerSettings => "إعدادات المشغل";
  @override
  String get labelExpandArtwork => "قم بتوسيع صورة الألبوم";
  @override
  String get labelArtworkRoundedCorners => "زوايا دائرية لصورة الاغنية";
  @override
  String get labelPlayingFrom => "تشغيل من";
  @override
  String get labelBlurBackground => "خلفيه ضبابية";

  // Video Page
  @override
  String get labelTags => "العلامات";
  @override
  String get labelRelated => "ذات صلة";
  @override
  String get labelAutoPlay => "تشغيل تلقائي";

  // Tags Pages
  @override
  String get labelAudioFormatNotCompatible =>
    "تنسيق الصوت غير متوافق";
  @override
  String get labelNotSpecified => "غير محدد";
  @override
  String get labelPerformAutomaticTagging => 
    "قم بإجراء وضع العلامات التلقائي";
  @override
  String get labelSelectTagsfromMusicBrainz => 
    "حدد العلامات من Music Brainz";
  @override
  String get labelSelectArtworkFromDevice =>
    "اختر صورة للألبوم من الجهاز";

  // Telegram Join Channel Dialog
  @override
  String get labelJoinTelegramChannel => "انضم إلى قناتنا على تليگرام!";
  @override
  String get labelJoinTelegramJustification =>
    "هل تحب SongTube؟  يرجى الانضمام إلى قناة قناتنا سوف تجد " +
    "تحديثات, معلومات, مطورين, روابط مجموعتنا عبر مواقع التواصل الإجتماعي ." +
    "\n\n" +
    "في حال كان لديك مشكلة أو توصية رائعة تدور في ذهنك, " +
    "يرجى الانضمام إلى المجموعة من القناة وتدوينها!  لكن ضع في اعتبارك " +
    "يمكنك التحدث باللغة الإنجليزية فقط ، وشكراً!";
  @override
  String get labelRemindLater => "تذكير في وقت لاحق";

  // Common Words (One word labels)
  @override
  String get labelExit => "خروج";
  @override
  String get labelSystem => "النظام";
  @override
  String get labelChannel => "القناة";
  @override
  String get labelShare => "مشاركة";
  @override
  String get labelAudio => "صوت";
  @override
  String get labelVideo => "فيديو";
  @override
  String get labelDownload => "التنزيلات";
  @override
  String get labelBest => "الافضل";
  @override
  String get labelPlaylist => "قوائم التشغيل";
  @override
  String get labelVersion => "الاصدار";
  @override
  String get labelLanguage => "اللغة";
  @override
  String get labelGrant => "منحة";
  @override
  String get labelAllow => "سماح";
  @override
  String get labelAccess => "إذن";
  @override
  String get labelEmpty => "فارغة";
  @override
  String get labelCalculating => "حساب";
  @override
  String get labelCleaning => "تنظيف";
  @override
  String get labelCancel => "إلغاء";
  @override
  String get labelGeneral => "عام";
  @override
  String get labelRemove => "إزالة";
  @override
  String get labelJoin => "انضم";
  @override
  String get labelNo => "لا";
  @override
  String get labelLibrary => "المكتبة";
  @override
  String get labelCreate => "خلق";
  @override
  String get labelPlaylists => "قوائم التشغيل";
  @override
  String get labelQuality => "جودة";
  @override
  String get labelSubscribe => "الإشتراك";

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
  @override
  String get labelPlaybackSpeed => 'Playback speed';
}