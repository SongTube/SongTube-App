import 'package:songtube/internal/languages.dart';

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
}