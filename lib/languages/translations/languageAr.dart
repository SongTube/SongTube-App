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
      "أحتاج الوصول إلى ذاكرة التخزين الداخلية الخاصة بجهازك لحفظ كل"
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
  String get labelTagsEditor => "إشارةمحرر";
  @override
  String get labelEditArtwork => "تعديلالأعمال الفنية";
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
  String get labelNoMediaYetJustification => "كل الوسائط " "ستظهر هنا";
  @override
  String get labelSearchMedia => "بحث في الوسائط ...";
  @override
  String get labelDeleteSong => "حذف الأغنية";
  @override
  String get labelNoPermissionJustification =>
      "عرض الوسائط الخاصة بك عن طريق\nمنح إذن التخزين";
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
  String get labelAudioFolderJustification => "اختر مجلداً لـ " "تنزيلات الصوت";
  @override
  String get labelVideoFolder => "مجلد الفيديو";
  @override
  String get labelVideoFolderJustification =>
      "اختر مجلدًا لـ " "تنزيلات الفيديو";
  @override
  String get labelAlbumFolder => "مجلد الألبوم";
  @override
  String get labelAlbumFolderJustification => "قم بإنشاء مجلد لكل ألبوم أغنية";
  @override
  String get labelDeleteCache => "حذف ذاكرة التخزين المؤقت";
  @override
  String get labelDeleteCacheJustification =>
      "امسح ذاكرة التخزين المؤقت بالضبط";
  @override
  String get labelAndroid11Fix => "إصلاح أندرويد 11";
  @override
  String get labelAndroid11FixJustification =>
      "يعمل على إصلاح مشكلات التنزيل " "Android 10 & 11";
  @override
  String get labelBackup => "نسخ احتياطي";
  @override
  String get labelBackupJustification =>
      "قم بعمل نسخة احتياطية من مكتبة الوسائط الخاصة بك";
  @override
  String get labelRestore => "استعادة";
  @override
  String get labelRestoreJustification => "قم باستعادة مكتبة الوسائط الخاصة بك";
  @override
  String get labelBackupLibraryEmpty => "مكتبتك فارغة";
  @override
  String get labelBackupCompleted => "اكتمل النسخ الاحتياطي";
  @override
  String get labelRestoreNotFound =>
      "لم يتم العثور على نسخة احتياطية للاستعادة";
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
  String get labelAndroid11Detected => " تم اكتشاف أن جهازك أندرويد 10 أو 11";
  @override
  String get labelAndroid11DetectedJustification =>
      "للتأكد من صحة ملف أداء هذا التطبيق التنزيلات ، على أندرويد 10 و 11 ، والوصول إلى الجميع قد تكون هناك حاجة إلى إذن الملفات ، سيكون هذا مؤقتًا وغير مطلوب في التحديثات المستقبلية ، يمكنك أيضًا تطبيق هذا الإصلاح في الإعدادات.";

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
  String get labelAudioFormatNotCompatible => "تنسيق الصوت غير متوافق";
  @override
  String get labelNotSpecified => "غير محدد";
  @override
  String get labelPerformAutomaticTagging => "قم بإجراء وضع العلامات التلقائي";
  @override
  String get labelSelectTagsfromMusicBrainz => "حدد العلامات من Music Brainz";
  @override
  String get labelSelectArtworkFromDevice => "اختر صورة للألبوم من الجهاز";

  // Telegram Join Channel Dialog
  @override
  String get labelJoinTelegramChannel => "انضم إلى قناتنا على تليگرام!";
  @override
  String get labelJoinTelegramJustification =>
      "هل تحب SongTube؟  يرجى الانضمام إلى قناة قناتنا سوف تجد تحديثات, معلومات, مطورين, روابط مجموعتنا عبر مواقع التواصل الإجتماعي .\n\nفي حال كان لديك مشكلة أو توصية رائعة تدور في ذهنك, يرجى الانضمام إلى المجموعة من القناة وتدوينها!  لكن ضع في اعتبارك يمكنك التحدث باللغة الإنجليزية فقط ، وشكراً!";
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
  String get labelNoFavoriteVideos => 'لا توجد مقاطع فيديو مفضلة';
  @override
  String get labelNoFavoriteVideosDescription =>
      'ابحث عن مقاطع الفيديو واحفظها كمفضلة. ستظهر هنا';
  @override
  String get labelNoSubscriptions => 'لا يوجد إشتراكات';
  @override
  String get labelNoSubscriptionsDescription =>
      'اضغط على الزر أعلاه لإظهار القنوات المقترحة!';
  @override
  String get labelNoPlaylists => 'لا توجد قوائم تشغيل متاحة';
  @override
  String get labelNoPlaylistsDescription =>
      'ابحث عن مقاطع الفيديو أو قوائم التشغيل واحفظها. ستظهر هنا';
  @override
  String get labelSearch => 'بحث';
  @override
  String get labelSubscriptions => 'الإشتراكات';
  @override
  String get labelNoDownloadsCanceled => 'لا توجد تنزيلات تم إلغاؤها';
  @override
  String get labelNoDownloadsCanceledDescription =>
      'أخبار جيدة! إذا قمت بالإلغاء أو حدث خطأ ما في التنزيل ، فيمكنك التحقق من هنا';
  @override
  String get labelNoDownloadsYet => 'لا توجد تنزيلات حتى الآن';
  @override
  String get labelNoDownloadsYetDescription =>
      'اذهب إلى الرئيسية ، ابحث عن شيء لتنزيله ، أو انتظر قائمة الانتظار!';
  @override
  String get labelYourQueueIsEmpty => 'قائمة الانتظار الخاصة بك فارغة';
  @override
  String get labelYourQueueIsEmptyDescription =>
      'اذهب إلى الرئيسية وابحث عن شيء لتنزيله!';
  @override
  String get labelQueue => 'قائمة الانتظار';
  @override
  String get labelSearchDownloads => 'البحث في التنزيلات';
  @override
  String get labelWatchHistory => 'مشاهدة التاريخ';
  @override
  String get labelWatchHistoryDescription =>
      'انظر إلى مقاطع الفيديو التي شاهدتها';
  @override
  String get labelBackupAndRestore => 'استرجاع البيانات';
  @override
  String get labelBackupAndRestoreDescription =>
      'احفظ أو استعد جميع بياناتك المحلية';
  @override
  String get labelSongtubeLink => 'رابط SongTube';
  @override
  String get labelSongtubeLinkDescription =>
      'Allow SongTube browser extension to detect this device, long press to learn more';
  @override
  String get labelSupportDevelopment => 'Support Development';
  @override
  String get labelSocialLinks => 'روابط اجتماعية';
  @override
  String get labelSeeMore => 'شاهد المزيد';
  @override
  String get labelMostPlayed => 'الأكثر مشاهدة';
  @override
  String get labelNoPlaylistsYet => 'لا توجد قوائم تشغيل حتى الآن';
  @override
  String get labelNoPlaylistsYetDescription =>
      'يمكنك إنشاء قائمة تشغيل من أحدث الموسيقى أو الألبومات أو الفنانين';
  @override
  String get labelNoSearchResults => 'لا توجد نتائج للبحث';
  @override
  String get labelSongResults => 'نتائج الأغنية';
  @override
  String get labelAlbumResults => 'نتائج الألبوم';
  @override
  String get labelArtistResults => 'نتائج الفنانين';
  @override
  String get labelSearchAnything => 'ابحث عن أي شيء';
  @override
  String get labelRecents => 'الأحدث';
  @override
  String get labelFetchingSongs => 'جلب الأغاني';
  @override
  String get labelPleaseWaitAMoment => 'فضلا انتظر لحظة';
  @override
  String get labelWeAreDone => 'لقد إنتهينا';
  @override
  String get labelEnjoyTheApp => 'إستمتع بالتطبيق !';
  @override
  String get labelSongtubeIsBackDescription =>
      'عاد SongTube بمظهر أنظف ومجموعة من الميزات ، استمتع بموسيقاك!';
  @override
  String get labelLetsGo => 'لنبدأ';
  @override
  String get labelPleaseWait => 'انتظر من فضلك';
  @override
  String get labelPoweredBy => 'مدعوم من ';
  @override
  String get labelGetStarted => 'البدء';
  @override
  String get labelAllowUsToHave => 'اسمح لنا بالحصول على';
  @override
  String get labelStorageRead => 'قراءة التخزين';
  @override
  String get labelStorageReadDescription =>
      'سيؤدي هذا إلى فحص موسيقاك  واستخراج عمل فني عالي الجودة ويسمح لك بتخصيص موسيقاك';
  @override
  String get labelContinue => 'إستمر';
  @override
  String get labelAllowStorageRead => 'السماح بقراءة التخزين';
  @override
  String get labelSelectYourPreferred => 'حدد المفضل لديك';
  @override
  String get labelLight => 'Light';
  @override
  String get labelDark => 'Dark';
  @override
  String get labelSimultaneousDownloads => 'التنزيلات في وقت واحد';
  @override
  String get labelSimultaneousDownloadsDescription =>
      'حدد عدد التنزيلات التي يمكن أن تحدث في نفس الوقت';
  @override
  String get labelItems => 'Items';
  @override
  String get labelInstantDownloadFormat => 'تنزيل فوري';
  @override
  String get labelInstantDownloadFormatDescription =>
      'قم بتغيير تنسيق الصوت للتنزيل الفوري';
  @override
  String get labelCurrent => 'حالي';
  @override
  String get labelPauseWatchHistory => 'Pause Watch History';
  @override
  String get labelPauseWatchHistoryDescription =>
      'أثناء الإيقاف المؤقت ، لا يتم حفظ مقاطع الفيديو في قائمة محفوظات المشاهدة';
  @override
  String get labelLockNavigationBar => 'Lock Navigation Bar';
  @override
  String get labelLockNavigationBarDescription =>
      'Locks the navigation bar from hiding and showing automatically on scroll';
  @override
  String get labelPictureInPicture => 'Picture in Picture';
  @override
  String get labelPictureInPictureDescription =>
      'يدخل تلقائيًا في وضع PiP عند النقر على زر الصفحة الرئيسية أثناء مشاهدة مقطع فيديو';
  @override
  String get labelBackgroundPlaybackAlpha => 'تشغيل الخلفية (ألفا)';
  @override
  String get labelBackgroundPlaybackAlphaDescription =>
      'تبديل ميزة تشغيل الخلفية. نظرًا لقيود البرنامج المساعد ، يمكن تشغيل الفيديو الحالي فقط في الخلفية';
  @override
  String get labelBlurBackgroundDescription => 'Add blurred artwork background';
  @override
  String get labelBlurIntensity => 'Blur Intensity';
  @override
  String get labelBlurIntensityDescription =>
      'Change the blur intensity of the artwork background';
  @override
  String get labelBackdropOpacity => 'Backdrop Opacity';
  @override
  String get labelBackdropOpacityDescription =>
      'Change the colored backdrop opacity';
  @override
  String get labelArtworkShadowOpacity => 'Artwork Shadow Opacity';
  @override
  String get labelArtworkShadowOpacityDescription =>
      'Change the artwork shadow intensity of the music player';
  @override
  String get labelArtworkShadowRadius => 'Artwork Shadow Radius';
  @override
  String get labelArtworkShadowRadiusDescription =>
      'Change the artwork shadow radius of the music player';
  @override
  String get labelArtworkScaling => 'Artwork Scaling';
  @override
  String get labelArtworkScalingDescription =>
      'Scale out the music player artwork & background images';
  @override
  String get labelBackgroundParallax => 'Background Parallax';
  @override
  String get labelBackgroundParallaxDescription =>
      'Enable/Disable background image parallax effect';
  @override
  String get labelRestoreThumbnails => 'Restore Thumbnails';
  @override
  String get labelRestoreThumbnailsDescription =>
      'Force thumbnails and artwork generation process';
  @override
  String get labelRestoringArtworks => 'Restoring artworks';
  @override
  String get labelRestoringArtworksDone => 'Restoring artworks done';
  @override
  String get labelHomeScreen => 'Home Screen';
  @override
  String get labelHomeScreenDescription =>
      'Change the default landing screen when you open the app';
  @override
  String get labelDefaultMusicPage => 'Default Music Page';
  @override
  String get labelDefaultMusicPageDescription =>
      'Change the default page for the Music Page';
  @override
  String get labelAbout => 'About';
  @override
  String get labelConversionRequired => 'Conversion Required';
  @override
  String get labelConversionRequiredDescription =>
      'This song format is incompatible with the ID3 Tags editor. The app will automatically convert this song to AAC (m4a) to sort out this issue.';
  @override
  String get labelPermissionRequired => 'Permission Required';
  @override
  String get labelPermissionRequiredDescription =>
      'All file access permission is required for SongTube to edit any song on your device';
  @override
  String get labelApplying => 'Applying';
  @override
  String get labelConvertingDescription =>
      'Re-encoding this song into AAC (m4a) format';
  @override
  String get labelWrittingTagsAndArtworkDescription =>
      'Applying new tags to this song';
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
  String get labelClearWatchHistoryDescription =>
      'You\'re about to delete all your watch history videos, this action cannot be undone, proceed?';
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
  String get labelEnableSegmentedDownloadDescription =>
      'This will download the whole audio file and then split it into the various enabled segments (or audio tracks) from the list below';
  @override
  String get labelCreateMusicPlaylist => 'Create Music Playlist';
  @override
  String get labelCreateMusicPlaylistDescription =>
      'Create music playlist from all downloaded and saved audio segments';
  @override
  String get labelApplyTags => 'Apply Tags';
  @override
  String get labelApplyTagsDescription =>
      'Extract tags from MusicBrainz for all segments';
  @override
  String get labelLoading => 'Loading';
  @override
  String get labelMusicDownloadDescription =>
      'Select quality, convert and download audio only';
  @override
  String get labelVideoDownloadDescription =>
      'Choose a video quality from the list and download it';
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
  String get labelBackupDescription =>
      'Backup all of your local data into a single file that can be used to restore later';
  @override
  String get labelBackupCreated => 'Backup Created';
  @override
  String get labelBackupRestored => 'Backup Restored';
  @override
  String get labelRestoreDescription =>
      'استعادة جميع البيانات الخاصة بك من ملف النسخ الاحتياطي';
  @override
  String get labelChannelSuggestions => 'اقتراحات القنوات';
  @override
  String get labelFetchingChannels => 'جلب القنوات';
  @override
  String get labelShareVideo => 'فيديو مشترك';
  @override
  String get labelShareDescription => 'شارك مع الأصدقاء أو منصات أخرى';
  @override
  String get labelRemoveFromPlaylists => 'إزالة من قائمة التشغيل';
  @override
  String get labelThisActionCannotBeUndone => 'لا يمكن التراجع عن هذا الإجراء';
  @override
  String get labelAddVideoToPlaylistDescription =>
      'أضف إلى قائمة تشغيل الفيديو الحالية أو الجديدة';
  @override
  String get labelAddToPlaylists => 'أضف إلى قوائم التشغيل';
  @override
  String get labelEditableOnceSaved => 'قابل للتحرير حفظ مرة واحدة';
  @override
  String get labelPlaylistRemoved => 'قائمة التشغيل إزالتها';
  @override
  String get labelPlaylistSaved => 'تم حفظ قائمة التشغيل';
  @override
  String get labelRemoveFromFavorites => 'إزالة من المفضلة';
  @override
  String get labelRemoveFromFavoritesDescription =>
      'إزالة هذا الفيديو من المفضلة لديك';
  @override
  String get labelSaveToFavorites => 'حفظ في المفضلة';
  @override
  String get labelSaveToFavoritesDescription =>
      'إضافة الفيديو إلى قائمة المفضلة الخاصة بك';
  @override
  String get labelSharePlaylist => 'مشاركة قائمة التشغيل';
  @override
  String get labelRemoveThisVideoFromThisList =>
      'إزالة هذا الفيديو من هذه القائمة';
  @override
  String get labelEqualizer => 'Equalizer';
  @override
  String get labelLoudnessEqualizationGain => 'Loudness Equalization Gain';
  @override
  String get labelSliders => 'Sliders';
  @override
  String get labelSave => 'حفظ';
  @override
  String get labelPlaylistName => 'اسم قائمة التشغيل';
  @override
  String get labelCreateVideoPlaylist => 'إنشاء قائمة تشغيل الفيديو';
  @override
  String get labelSearchFilters => 'مرشحات البحث';
  @override
  String get labelAddToPlaylistDescription =>
      'أضف إلى قائمة التشغيل الحالية أو الجديدة';
  @override
  String get labelShareSong => 'مشاركة الأغنية';
  @override
  String get labelShareSongDescription => 'شارك مع الأصدقاء أو منصات أخرى';
  @override
  String get labelEditTagsDescription => 'Open ID3 tags and artwork editor';
  @override
  String get labelContains => 'يتضمن';
  @override
  String get labelPlaybackSpeed => 'سرعة التشغيل';
}
