import 'package:songtube/internal/languages.dart';

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
}