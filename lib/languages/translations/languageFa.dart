import 'package:songtube/languages/languages.dart';

class LanguageFa extends Languages {
  // Introduction Screens
  @override
  String get labelAppWelcome => "خوش آمدید به";
  @override
  String get labelStart => "شروع";
  @override
  String get labelSkip => "رد کردن";
  @override
  String get labelNext => "بعدی";
  @override
  String get labelExternalAccessJustification =>
      "نیاز به دسترسی به حافظه خارجی شما برای ذخیره تمام " +
      "ویدیوها و موسیقی های شما دارد";
  @override
  String get labelAppCustomization => "شخصی‌سازی";
  @override
  String get labelSelectPreferred => "ترجیح داده شده خود را انتخاب کنید";
  @override
  String get labelConfigReady => "پیکربندی آماده است";
  @override
  String get labelIntroductionIsOver => "معرفی به پایان رسید";
  @override
  String get labelEnjoy => "لذت ببرید";
  @override
  String get labelGoHome => "برو به خانه";

  // Bottom Navigation Bar
  @override
  String get labelHome => "خانه";
  @override
  String get labelDownloads => "دانلودها";
  @override
  String get labelMedia => "رسانه";
  @override
  String get labelYouTube => "یوتیوب";
  @override
  String get labelMore => "بیشتر";

  // Home Screen
  @override
  String get labelQuickSearch => "جستجوی سریع...";
  @override
  String get labelTagsEditor => "ویرایشگر برچسب‌ها";
  @override
  String get labelEditArtwork => "ویرایش\nاثر هنری";
  @override
  String get labelDownloadAll => "دانلود همه";
  @override
  String get labelLoadingVideos => "در حال بارگذاری ویدیوها...";
  @override
  String get labelHomePage => "صفحه اصلی";
  @override
  String get labelTrending => "محبوب";
  @override
  String get labelFavorites => "موارد دلخواه";
  @override
  String get labelWatchLater => "تماشا در آینده";

  // Video Options Menu
  @override
  String get labelCopyLink => "کپی لینک";
  @override
  String get labelAddToFavorites => "افزودن به علاقه‌مندی‌ها";
  @override
  String get labelAddToWatchLater => "افزودن به تماشا در آینده";
  @override
  String get labelAddToPlaylist => "افزودن به فهرست پخش";

  // Downloads Screen
  @override
  String get labelQueued => "در صف";
  @override
  String get labelDownloading => "در حال دانلود";
  @override
  String get labelConverting => "در حال تبدیل";
  @override
  String get labelCancelled => "لغو شده";
  @override
  String get labelCompleted => "تکمیل شده";

  // Download Status/Error Messages
  @override
  String get labelDownloadQueued => "دانلود در صف قرار گرفت";
  @override
  String get labelDownloadAcesssDenied => "دسترسی ممنوع";
  @override
  String get labelClearingExistingMetadata =>
      "در حال پاک کردن متادیتای موجود...";
  @override
  String get labelWrittingTagsAndArtwork =>
      "در حال نوشتن برچسب‌ها و آثار هنری...";
  @override
  String get labelSavingFile => "در حال ذخیره فایل...";
  @override
  String get labelAndroid11FixNeeded =>
      "خطا، نیاز به اصلاح برای اندروید 11، تنظیمات را بررسی کنید";
  @override
  String get labelErrorSavingDownload =>
      "ذخیره دانلود شما ممکن نیست، مجوزها را بررسی کنید";
  @override
  String get labelDownloadingVideo => "در حال دانلود ویدیو...";
  @override
  String get labelDownloadingAudio => "در حال دانلود صدا...";
  @override
  String get labelGettingAudioStream => "در حال دریافت استریم صدا...";
  @override
  String get labelAudioNoDataRecieved => "استریم صدا قابل دریافت نیست";
  @override
  String get labelDownloadStarting => "دانلود در حال شروع...";
  @override
  String get labelDownloadCancelled => "دانلود لغو شد";
  @override
  String get labelAnIssueOcurredConvertingAudio => "فرایند تبدیل شکست خورد";
  @override
  String get labelPatchingAudio => "در حال اصلاح صدا...";

  // Download Menu
  @override
  String get labelEnableAudioConversion => "فعال‌سازی تبدیل صدا";
  @override
  String get labelGainControls => "کنترل‌های تقویت";
  @override
  String get labelVolume => "حجم صدا";
  @override
  String get labelBassGain => "تقویت بیس";
  @override
  String get labelTrebleGain => "تقویت تربل";
  @override
  String get labelSelectVideo => "انتخاب ویدیو";
  @override
  String get labelSelectAudio => "انتخاب صدا";
  @override
  String get labelGlobalParameters => "پارامترهای جهانی";

  // Media Screen
  @override
  String get labelMusic => "موسیقی";
  @override
  String get labelVideos => "ویدیوها";
  @override
  String get labelNoMediaYet => "هنوز رسانه‌ای موجود نیست";
  @override
  String get labelNoMediaYetJustification =>
      "تمام رسانه‌های شما " + "اینجا نمایش داده می‌شود";
  @override
  String get labelSearchMedia => "جستجوی رسانه...";
  @override
  String get labelDeleteSong => "حذف آهنگ";
  @override
  String get labelNoPermissionJustification =>
      "رسانه‌های خود را مشاهده کنید" + "\n" + "با ارائه مجوز ذخیره‌سازی";
  @override
  String get labelGettingYourMedia => "در حال دریافت رسانه شما...";
  @override
  String get labelEditTags => "ویرایش برچسب‌ها";

  // Navigate Screen
  @override
  String get labelSearchYoutube => "جستجو در یوتیوب...";

  // More Screen
  @override
  String get labelSettings => "تنظیمات";
  @override
  String get labelDonate => "اهداء";
  @override
  String get labelLicenses => "مجوزها";
  @override
  String get labelChooseColor => "انتخاب رنگ";
  @override
  String get labelTheme => "تم";
  @override
  String get labelUseSystemTheme => "استفاده از تم سیستم";
  @override
  String get labelUseSystemThemeJustification =>
      "فعال‌سازی/غیرفعال‌سازی تم خودکار";
  @override
  String get labelEnableDarkTheme => "فعال‌سازی تم تیره";
  @override
  String get labelEnableDarkThemeJustification =>
      "استفاده از تم تیره به‌طور پیش‌فرض";
  @override
  String get labelEnableBlackTheme => "فعال‌سازی تم مشکی";
  @override
  String get labelEnableBlackThemeJustification => "فعال‌سازی تم مشکی خالص";
  @override
  String get labelAccentColor => "رنگ تأکید";
  @override
  String get labelAccentColorJustification => "شخصی‌سازی رنگ تأکید";
  @override
  String get labelAudioFolder => "پوشه صدا";
  @override
  String get labelAudioFolderJustification =>
      "انتخاب یک پوشه برای " + "دانلودهای صوتی";
  @override
  String get labelVideoFolder => "پوشه ویدیو";
  @override
  String get labelVideoFolderJustification =>
      "انتخاب یک پوشه برای " + "دانلودهای ویدیویی";
  @override
  String get labelAlbumFolder => "پوشه آلبوم";
  @override
  String get labelAlbumFolderJustification =>
      "ایجاد یک پوشه برای هر آلبوم آهنگ";
  @override
  String get labelDeleteCache => "حذف حافظه کش";
  @override
  String get labelDeleteCacheJustification => "پاک‌سازی حافظه کش SongTube";
  @override
  String get labelAndroid11Fix => "اصلاح برای اندروید 11";
  @override
  String get labelAndroid11FixJustification =>
      "رفع مشکلات دانلود در " + "اندروید 10 و 11";
  @override
  String get labelBackup => "پشتیبان‌گیری";
  @override
  String get labelBackupJustification => "پشتیبان‌گیری از کتابخانه رسانه شما";
  @override
  String get labelRestore => "بازیابی";
  @override
  String get labelRestoreJustification => "بازیابی کتابخانه رسانه شما";
  @override
  String get labelBackupLibraryEmpty => "کتابخانه شما خالی است";
  @override
  String get labelBackupCompleted => "پشتیبان‌گیری تکمیل شد";
  @override
  String get labelRestoreNotFound => "بازیابی یافت نشد";
  @override
  String get labelRestoreCompleted => "بازیابی تکمیل شد";
  @override
  String get labelCacheIsEmpty => "حافظه کش خالی است";
  @override
  String get labelYouAreAboutToClear => "در حال پاک کردن هستید";

  // Tags Editor TextFields
  @override
  String get labelEditorTitle => "عنوان";
  @override
  String get labelEditorArtist => "هنرمند";
  @override
  String get labelEditorGenre => "ژانر";
  @override
  String get labelEditorDisc => "دیسک";
  @override
  String get labelEditorTrack => "ترک";
  @override
  String get labelEditorDate => "تاریخ";
  @override
  String get labelEditorAlbum => "آلبوم";

  // Android 10 or 11 Detected Dialog
  @override
  String get labelAndroid11Detected => "اندروید 10 یا 11 شناسایی شد";
  @override
  String get labelAndroid11DetectedJustification =>
      "برای اطمینان از عملکرد صحیح " +
      "دانلودهای این برنامه در اندروید 10 و 11، ممکن است نیاز به دسترسی به همه " +
      "فایل‌ها باشد، این دسترسی موقتی خواهد بود و در بروزرسانی‌های آینده نیاز نخواهد بود. همچنین می‌توانید این اصلاح را در تنظیمات اعمال کنید.";

  // Music Player
  @override
  String get labelPlayerSettings => "تنظیمات پخش‌کننده";
  @override
  String get labelExpandArtwork => "بزرگ‌نمایی اثر هنری";
  @override
  String get labelArtworkRoundedCorners => "گوشه‌های گرد اثر هنری";
  @override
  String get labelPlayingFrom => "پخش از";
  @override
  String get labelBlurBackground => "تاری پس‌زمینه";

  // Video Page
  @override
  String get labelTags => "برچسب‌ها";
  @override
  String get labelRelated => "مرتبط";
  @override
  String get labelAutoPlay => "پخش خودکار";

  // Tags Pages
  @override
  String get labelAudioFormatNotCompatible => "فرمت صدا سازگار نیست";
  @override
  String get labelNotSpecified => "مشخص نشده";
  @override
  String get labelPerformAutomaticTagging => "انجام برچسب‌گذاری خودکار";
  @override
  String get labelSelectTagsfromMusicBrainz => "انتخاب برچسب‌ها از MusicBrainz";
  @override
  String get labelSelectArtworkFromDevice => "انتخاب اثر هنری از دستگاه";

  // Telegram Join Channel Dialog
  @override
  String get labelJoinTelegramChannel => "به کانال تلگرام بپیوندید!";
  @override
  String get labelJoinTelegramJustification =>
      "آیا SongTube را دوست دارید؟ لطفاً به کانال تلگرام بپیوندید! در اینجا " +
      "به‌روزرسانی‌ها، اطلاعات، توسعه، لینک گروه و لینک‌های اجتماعی دیگر را پیدا خواهید کرد." +
      "\n\n" +
      "در صورتی که مشکلی دارید یا پیشنهادی عالی در ذهن دارید، " +
      "لطفاً از طریق کانال به گروه بپیوندید و آن را بنویسید! اما در نظر داشته باشید که " +
      "فقط به انگلیسی می‌توانید صحبت کنید، با تشکر!";
  @override
  String get labelRemindLater => "یادآوری بعداً";

  // Common Words (One word labels)
  @override
  String get labelExit => "خروج";
  @override
  String get labelSystem => "سیستم";
  @override
  String get labelChannel => "کانال";
  @override
  String get labelShare => "اشتراک‌گذاری";
  @override
  String get labelAudio => "صدا";
  @override
  String get labelVideo => "ویدیو";
  @override
  String get labelDownload => "دانلود";
  @override
  String get labelBest => "بهترین";
  @override
  String get labelPlaylist => "فهرست پخش";
  @override
  String get labelVersion => "نسخه";
  @override
  String get labelLanguage => "زبان";
  @override
  String get labelGrant => "ارائه";
  @override
  String get labelAllow => "اجازه";
  @override
  String get labelAccess => "دسترسی";
  @override
  String get labelEmpty => "خالی";
  @override
  String get labelCalculating => "در حال محاسبه";
  @override
  String get labelCleaning => "در حال پاکسازی";
  @override
  String get labelCancel => "لغو";
  @override
  String get labelGeneral => "عمومی";
  @override
  String get labelRemove => "حذف";
  @override
  String get labelJoin => "پیوستن";
  @override
  String get labelNo => "خیر";
  @override
  String get labelLibrary => "کتابخانه";
  @override
  String get labelCreate => "ایجاد";
  @override
  String get labelPlaylists => "فهرست‌های پخش";
  @override
  String get labelQuality => "کیفیت";
  @override
  String get labelSubscribe => "اشتراک";

  // Other Translations
  @override
  String get labelNoFavoriteVideos => 'ویدیوهای دلخواهی موجود نیست';
  @override
  String get labelNoFavoriteVideosDescription =>
      'ویدیوها را جستجو کنید و آن‌ها را به دلخواه‌ها اضافه کنید. آن‌ها اینجا نمایش داده خواهند شد';
  @override
  String get labelNoSubscriptions => 'اشتراک‌های موجود نیست';
  @override
  String get labelNoSubscriptionsDescription =>
      'روی دکمه بالا بزنید تا کانال‌های پیشنهادی نمایش داده شوند!';
  @override
  String get labelNoPlaylists => 'فهرست‌های پخشی موجود نیست';
  @override
  String get labelNoPlaylistsDescription =>
      'ویدیوها یا فهرست‌های پخش را جستجو کنید و ذخیره کنید. آن‌ها اینجا نمایش داده خواهند شد';
  @override
  String get labelSearch => 'جستجو';
  @override
  String get labelSubscriptions => 'اشتراک‌ها';
  @override
  String get labelNoDownloadsCanceled => 'دانلود لغو شده‌ای موجود نیست';
  @override
  String get labelNoDownloadsCanceledDescription =>
      'خبر خوب! اما اگر لغو کنید یا مشکلی در دانلود پیش بیاید، می‌توانید از اینجا بررسی کنید';
  @override
  String get labelNoDownloadsYet => 'دانلودی هنوز موجود نیست';
  @override
  String get labelNoDownloadsYetDescription =>
      'به خانه بروید، چیزی برای دانلود جستجو کنید یا منتظر صف باشید!';
  @override
  String get labelYourQueueIsEmpty => 'صف شما خالی است';
  @override
  String get labelYourQueueIsEmptyDescription =>
      'به خانه بروید و چیزی برای دانلود جستجو کنید!';
  @override
  String get labelQueue => 'صف';
  @override
  String get labelSearchDownloads => 'جستجوی دانلودها';
  @override
  String get labelWatchHistory => 'تاریخچه تماشا';
  @override
  String get labelWatchHistoryDescription =>
      'نگاهی به ویدیوهایی که دیده‌اید بیندازید';
  @override
  String get labelBackupAndRestore => 'پشتیبان‌گیری و بازیابی';
  @override
  String get labelBackupAndRestoreDescription =>
      'تمام داده‌های محلی خود را ذخیره کنید یا بازیابی کنید';
  @override
  String get labelSongtubeLink => 'لینک SongTube';
  @override
  String get labelSongtubeLinkDescription =>
      'اجازه دهید افزونه مرورگر SongTube این دستگاه را شناسایی کند، برای اطلاعات بیشتر فشار دهید';
  @override
  String get labelSupportDevelopment => 'حمایت از توسعه';
  @override
  String get labelSocialLinks => 'لینک‌های اجتماعی';
  @override
  String get labelSeeMore => 'بیشتر ببینید';
  @override
  String get labelMostPlayed => 'بیشترین پخش';
  @override
  String get labelNoPlaylistsYet => 'هنوز فهرست پخشی موجود نیست';
  @override
  String get labelNoPlaylistsYetDescription =>
      'می‌توانید یک فهرست پخش از آهنگ‌های اخیر، موسیقی‌ها، آلبوم‌ها یا هنرمندان خود ایجاد کنید';
  @override
  String get labelNoSearchResults => 'نتیجه جستجویی موجود نیست';
  @override
  String get labelSongResults => 'نتایج آهنگ';
  @override
  String get labelAlbumResults => 'نتایج آلبوم';
  @override
  String get labelArtistResults => 'نتایج هنرمند';
  @override
  String get labelSearchAnything => 'هر چیزی را جستجو کنید';
  @override
  String get labelRecents => 'اخیرها';
  @override
  String get labelFetchingSongs => 'در حال دریافت آهنگ‌ها';
  @override
  String get labelPleaseWaitAMoment => 'لطفاً یک لحظه صبر کنید';
  @override
  String get labelWeAreDone => 'کار ما تمام شد';
  @override
  String get labelEnjoyTheApp => 'از\nبرنامه لذت ببرید';
  @override
  String get labelSongtubeIsBackDescription =>
      'SongTube با ظاهری تمیزتر و مجموعه‌ای از ویژگی‌ها بازگشته است، از موسیقی خود لذت ببرید!';
  @override
  String get labelLetsGo => 'بزن بریم';
  @override
  String get labelPleaseWait => 'لطفاً صبر کنید';
  @override
  String get labelPoweredBy => 'قدرت گرفته از';
  @override
  String get labelGetStarted => 'شروع کنید';
  @override
  String get labelAllowUsToHave => 'اجازه دهید داشته باشیم';
  @override
  String get labelStorageRead => 'خواندن\nحافظه';
  @override
  String get labelStorageReadDescription =>
      'این عمل موسیقی‌های شما را اسکن می‌کند، آثار هنری با کیفیت بالا را استخراج می‌کند و به شما امکان شخصی‌سازی موسیقی‌هایتان را می‌دهد';
  @override
  String get labelContinue => 'ادامه';
  @override
  String get labelAllowStorageRead => 'اجازه به خواندن حافظه';
  @override
  String get labelSelectYourPreferred => 'ترجیح داده خود را انتخاب کنید';
  @override
  String get labelLight => 'روشن';
  @override
  String get labelDark => 'تیره';
  @override
  String get labelSimultaneousDownloads => 'دانلودهای همزمان';
  @override
  String get labelSimultaneousDownloadsDescription =>
      'تعیین کنید چند دانلود می‌تواند همزمان انجام شود';
  @override
  String get labelItems => 'موارد';
  @override
  String get labelInstantDownloadFormat => 'دانلود فوری';
  @override
  String get labelInstantDownloadFormatDescription =>
      'فرمت صوتی برای دانلودهای فوری را تغییر دهید';
  @override
  String get labelCurrent => 'فعلی';
  @override
  String get labelPauseWatchHistory => 'توقف تاریخچه تماشا';
  @override
  String get labelPauseWatchHistoryDescription =>
      'در حالی که متوقف است، ویدیوها به فهرست تاریخچه تماشا اضافه نمی‌شوند';
  @override
  String get labelLockNavigationBar => 'قفل کردن نوار ناوبری';
  @override
  String get labelLockNavigationBarDescription =>
      'قفل کردن نوار ناوبری از مخفی و نمایش خودکار در اسکرول';
  @override
  String get labelPictureInPicture => 'تصویر در تصویر';
  @override
  String get labelPictureInPictureDescription =>
      'به‌طور خودکار وارد حالت PiP می‌شود هنگام زدن دکمه خانه در حین مشاهده ویدیو';
  @override
  String get labelBackgroundPlaybackAlpha => 'پخش در پس‌زمینه (آلفا)';
  @override
  String get labelBackgroundPlaybackAlphaDescription =>
      'تغییر حالت پخش در پس‌زمینه. به دلیل محدودیت‌های افزونه، فقط ویدیوی فعلی می‌تواند در پس‌زمینه پخش شود';
  @override
  String get labelBlurBackgroundDescription => 'افزودن پس‌زمینه اثر هنری تاری';
  @override
  String get labelBlurIntensity => 'شدت تاری';
  @override
  String get labelBlurIntensityDescription =>
      'شدت تاری پس‌زمینه اثر هنری را تغییر دهید';
  @override
  String get labelBackdropOpacity => 'شفافیت پس‌زمینه';
  @override
  String get labelBackdropOpacityDescription =>
      'شفافیت پس‌زمینه رنگی را تغییر دهید';
  @override
  String get labelArtworkShadowOpacity => 'شفافیت سایه اثر هنری';
  @override
  String get labelArtworkShadowOpacityDescription =>
      'شدت سایه اثر هنری پخش‌کننده موسیقی را تغییر دهید';
  @override
  String get labelArtworkShadowRadius => 'شعاع سایه اثر هنری';
  @override
  String get labelArtworkShadowRadiusDescription =>
      'شعاع سایه اثر هنری پخش‌کننده موسیقی را تغییر دهید';
  @override
  String get labelArtworkScaling => 'مقیاس‌گذاری اثر هنری';
  @override
  String get labelArtworkScalingDescription =>
      'مقیاس‌بندی تصاویر پس‌زمینه و اثر هنری پخش‌کننده موسیقی';
  @override
  String get labelBackgroundParallax => 'پراکس زمینه';
  @override
  String get labelBackgroundParallaxDescription =>
      'فعال‌سازی/غیرفعال‌سازی اثر پراکس تصویر پس‌زمینه';
  @override
  String get labelRestoreThumbnails => 'بازگرداندن تصاویر بندانگشتی';
  @override
  String get labelRestoreThumbnailsDescription =>
      'فرآیند تولید تصاویر بندانگشتی و آثار هنری را مجدداً انجام دهید';
  @override
  String get labelRestoringArtworks => 'در حال بازگرداندن آثار هنری';
  @override
  String get labelRestoringArtworksDone => 'بازگرداندن آثار هنری تمام شد';
  @override
  String get labelHomeScreen => 'صفحه اصلی';
  @override
  String get labelHomeScreenDescription =>
      'تغییر صفحه پیش‌فرض زمانی که برنامه را باز می‌کنید';
  @override
  String get labelDefaultMusicPage => 'صفحه موسیقی پیش‌فرض';
  @override
  String get labelDefaultMusicPageDescription =>
      'صفحه پیش‌فرض برای صفحه موسیقی را تغییر دهید';
  @override
  String get labelAbout => 'درباره';
  @override
  String get labelConversionRequired => 'تبدیل لازم است';
  @override
  String get labelConversionRequiredDescription =>
      'فرمت این آهنگ با ویرایشگر برچسب‌های ID3 سازگار نیست. برنامه به‌طور خودکار این آهنگ را به فرمت AAC (m4a) تبدیل می‌کند تا این مشکل برطرف شود.';
  @override
  String get labelPermissionRequired => 'اجازه لازم است';
  @override
  String get labelPermissionRequiredDescription =>
      'دسترسی به همه فایل‌ها برای ویرایش آهنگ‌های شما در دستگاه لازم است';
  @override
  String get labelApplying => 'در حال اعمال';
  @override
  String get labelConvertingDescription =>
      'در حال بازکدگذاری این آهنگ به فرمت AAC (m4a)';
  @override
  String get labelWrittingTagsAndArtworkDescription =>
      'در حال اعمال برچسب‌های جدید به این آهنگ';
  @override
  String get labelApply => 'اعمال';
  @override
  String get labelSongs => 'آهنگ‌ها';
  @override
  String get labelPlayAll => 'پخش همه';
  @override
  String get labelPlaying => 'در حال پخش';
  @override
  String get labelPages => 'صفحات';
  @override
  String get labelMusicPlayer => 'پخش‌کننده موسیقی';
  @override
  String get labelClearWatchHistory => 'پاک کردن تاریخچه تماشا';
  @override
  String get labelClearWatchHistoryDescription =>
      'شما در حال حذف تمام ویدیوهای تاریخچه تماشای خود هستید، این عمل غیرقابل بازگشت است، ادامه دهید؟';
  @override
  String get labelDelete => 'حذف';
  @override
  String get labelAppUpdate => 'بروزرسانی برنامه';
  @override
  String get labelWhatsNew => 'چه چیز جدید است';
  @override
  String get labelLater => 'بعداً';
  @override
  String get labelUpdate => 'بروزرسانی';
  @override
  String get labelUnsubscribe => 'لغو اشتراک';
  @override
  String get labelAudioFeatures => 'ویژگی‌های صدا';
  @override
  String get labelVolumeBoost => 'تقویت صدا';
  @override
  String get labelNormalizeAudio => 'نرمال‌سازی صدا';
  @override
  String get labelSegmentedDownload => 'دانلود بخش‌بندی شده';
  @override
  String get labelEnableSegmentedDownload => 'فعال‌سازی دانلود بخش‌بندی شده';
  @override
  String get labelEnableSegmentedDownloadDescription =>
      'این عمل کل فایل صوتی را دانلود می‌کند و سپس آن را به بخش‌های مختلف (یا ترک‌های صوتی) از لیست زیر تقسیم می‌کند';
  @override
  String get labelCreateMusicPlaylist => 'ایجاد فهرست پخش موسیقی';
  @override
  String get labelCreateMusicPlaylistDescription =>
      'فهرست پخش موسیقی از تمام بخش‌های دانلود شده و ذخیره شده ایجاد کنید';
  @override
  String get labelApplyTags => 'اعمال برچسب‌ها';
  @override
  String get labelApplyTagsDescription =>
      'برچسب‌ها را از MusicBrainz برای همه بخش‌ها استخراج کنید';
  @override
  String get labelLoading => 'در حال بارگیری';
  @override
  String get labelMusicDownloadDescription =>
      'کیفیت را انتخاب کنید، تبدیل کنید و فقط صدا را دانلود کنید';
  @override
  String get labelVideoDownloadDescription =>
      'یک کیفیت ویدیو از لیست انتخاب کنید و آن را دانلود کنید';
  @override
  String get labelInstantDescription =>
      'بلافاصله شروع به دانلود به‌عنوان موسیقی کنید';
  @override
  String get labelInstant => 'بلافاصله';
  @override
  String get labelCurrentQuality => 'کیفیت فعلی';
  @override
  String get labelFastStreamingOptions => 'گزینه‌های پخش سریع';
  @override
  String get labelStreamingOptions => 'گزینه‌های پخش';
  @override
  String get labelComments => 'نظرات';
  @override
  String get labelPinned => 'پین شده';
  @override
  String get labelLikedByAuthor => 'پسندیده شده توسط نویسنده';
  @override
  String get labelDescription => 'توضیحات';
  @override
  String get labelViews => 'بازدیدها';
  @override
  String get labelPlayingNextIn => 'پخش بعدی در';
  @override
  String get labelPlayNow => 'هم اکنون پخش کنید';
  @override
  String get labelLoadingPlaylist => 'در حال بارگذاری فهرست پخش';
  @override
  String get labelPlaylistReachedTheEnd => 'فهرست پخش به پایان رسید';
  @override
  String get labelLiked => 'پسندیده شده';
  @override
  String get labelLike => 'پسندیدن';
  @override
  String get labelVideoRemovedFromFavorites => 'ویدیو از علاقه‌مندی‌ها حذف شد';
  @override
  String get labelVideoAddedToFavorites => 'ویدیو به علاقه‌مندی‌ها اضافه شد';
  @override
  String get labelPopupMode => 'حالت پاپ‌آپ';
  @override
  String get labelDownloaded => 'دانلود شده';
  @override
  String get labelShowPlaylist => 'نمایش فهرست پخش';
  @override
  String get labelCreatePlaylist => 'ایجاد فهرست پخش';
  @override
  String get labelAddVideoToPlaylist => 'افزودن ویدیو به فهرست پخش';
  @override
  String get labelBackupDescription =>
      'پشتیبان‌گیری از تمام داده‌های محلی خود را در یک فایل که می‌توان آن را بعداً بازیابی کرد انجام دهید';
  @override
  String get labelBackupCreated => 'پشتیبان‌گیری ایجاد شد';
  @override
  String get labelBackupRestored => 'پشتیبان‌گیری بازیابی شد';
  @override
  String get labelRestoreDescription =>
      'همه داده‌های خود را از یک فایل پشتیبان بازیابی کنید';
  @override
  String get labelChannelSuggestions => 'پیشنهادات کانال';
  @override
  String get labelFetchingChannels => 'در حال دریافت کانال‌ها';
  @override
  String get labelShareVideo => 'اشتراک ویدیو';
  @override
  String get labelShareDescription => 'اشتراک با دوستان یا پلتفرم‌های دیگر';
  @override
  String get labelRemoveFromPlaylists => 'حذف از فهرست پخش';
  @override
  String get labelThisActionCannotBeUndone => 'این عمل غیرقابل بازگشت است';
  @override
  String get labelAddVideoToPlaylistDescription =>
      'افزودن به فهرست پخش ویدیویی موجود یا جدید';
  @override
  String get labelAddToPlaylists => 'افزودن به فهرست‌های پخش';
  @override
  String get labelEditableOnceSaved => 'قابل ویرایش پس از ذخیره شدن';
  @override
  String get labelPlaylistRemoved => 'فهرست پخش حذف شد';
  @override
  String get labelPlaylistSaved => 'فهرست پخش ذخیره شد';
  @override
  String get labelRemoveFromFavorites => 'حذف از علاقه‌مندی‌ها';
  @override
  String get labelRemoveFromFavoritesDescription =>
      'این ویدیو را از علاقه‌مندی‌های خود حذف کنید';
  @override
  String get labelSaveToFavorites => 'ذخیره به علاقه‌مندی‌ها';
  @override
  String get labelSaveToFavoritesDescription =>
      'افزودن ویدیو به فهرست علاقه‌مندی‌های شما';
  @override
  String get labelSharePlaylist => 'اشتراک‌گذاری فهرست پخش';
  @override
  String get labelRemoveThisVideoFromThisList =>
      'این ویدیو را از این فهرست حذف کنید';
  @override
  String get labelEqualizer => 'اکولایزر';
  @override
  String get labelLoudnessEqualizationGain => 'تقویت تساوی صدا';
  @override
  String get labelSliders => 'لغزنده‌ها';
  @override
  String get labelSave => 'ذخیره';
  @override
  String get labelPlaylistName => 'نام فهرست پخش';
  @override
  String get labelCreateVideoPlaylist => 'ایجاد فهرست پخش ویدیو';
  @override
  String get labelSearchFilters => 'فیلترهای جستجو';
  @override
  String get labelAddToPlaylistDescription =>
      'افزودن به فهرست پخش موجود یا جدید';
  @override
  String get labelShareSong => 'اشتراک‌گذاری آهنگ';
  @override
  String get labelShareSongDescription => 'اشتراک با دوستان یا پلتفرم‌های دیگر';
  @override
  String get labelEditTagsDescription =>
      'باز کردن ویرایشگر برچسب‌های ID3 و اثر هنری';
  @override
  String get labelContains => 'شامل';
  @override
  String get labelPlaybackSpeed => 'سرعت پخش';
}
