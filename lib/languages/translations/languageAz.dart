import 'package:songtube/languages/languages.dart';

class LanguageAz extends Languages {
  // Introduction Screens
  @override
  String get labelAppWelcome => "Xoş gəldiniz";
  @override
  String get labelStart => "Başla";
  @override
  String get labelSkip => "Keç";
  @override
  String get labelNext => "Növbəti";
  @override
  String get labelExternalAccessJustification =>
      "Yükləmək üçün video və musiqi saxlama icazəsi tələb olunur";
  @override
  String get labelAppCustomization => "Xüsusiyyətlər";
  @override
  String get labelSelectPreferred => "Tərəfinizi seçin";
  @override
  String get labelConfigReady => "Konfiqurasiya hazır";
  @override
  String get labelIntroductionIsOver => "Təqdimat bitdi";
  @override
  String get labelEnjoy => "Zövq alın";
  @override
  String get labelGoHome => "Əsas səhifəyə get";

  // Bottom Navigation Bar
  @override
  String get labelHome => "Əsas səhifə";
  @override
  String get labelDownloads => "Yükləmələr";
  @override
  String get labelMedia => "Medya";
  @override
  String get labelYouTube => "YouTube";
  @override
  String get labelMore => "Daha çox";

  // Home Screen
  @override
  String get labelQuickSearch => "Sürətli axtarış...";
  @override
  String get labelTagsEditor => "Etiketləri\nredaktə et";
  @override
  String get labelEditArtwork => "Şəkli\nredaktə et";
  @override
  String get labelDownloadAll => "Hamısını yüklə";
  @override
  String get labelLoadingVideos => "Videolar yüklənir...";
  @override
  String get labelHomePage => "Əsas səhifə";
  @override
  String get labelTrending => "Trendlər";
  @override
  String get labelFavorites => "Sevimlilər";
  @override
  String get labelWatchLater => "Daha sonra izlə";

  // Video Options Menu
  @override
  String get labelCopyLink => "Linki kopyala";
  @override
  String get labelAddToFavorites => "Sevimlilərə əlavə et";
  @override
  String get labelAddToWatchLater => "Daha sonra izləməyə əlavə et";
  @override
  String get labelAddToPlaylist => "Oynatma siyahısına əlavə et";

  // Downloads Screen
  @override
  String get labelQueued => "Sıraya alındı";
  @override
  String get labelDownloading => "Yüklənir";
  @override
  String get labelConverting => "Dönüşdürülür";
  @override
  String get labelCancelled => "Ləğv edildi";
  @override
  String get labelCompleted => "Tamamlandı";

  // Download Status/Error Messages
  @override
  String get labelDownloadQueued => "Yükləmə sıraya alındı";
  @override
  String get labelDownloadAcesssDenied => "Giriş icazəsi rədd edildi";
  @override
  String get labelClearingExistingMetadata =>
      "Mövcud meta verilənləri silinir...";
  @override
  String get labelWrittingTagsAndArtwork => "Etiketlər və görsel yazılır...";
  @override
  String get labelSavingFile => "Fayl qeydə alınıyor...";
  @override
  String get labelAndroid11FixNeeded =>
      "Səhv, Android 11 düzəltməsi tələb olunur, Ayarları yoxlayın";
  @override
  String get labelErrorSavingDownload =>
      "Fayl qeydə alınamadı, tətbiq icazələrini yoxlayın";
  @override
  String get labelDownloadingVideo => "Video yüklənir...";
  @override
  String get labelDownloadingAudio => "Səs yüklənir...";
  @override
  String get labelGettingAudioStream => "Səs axını alınıyor...";
  @override
  String get labelAudioNoDataRecieved => "Səs məlumatı alınmadı";
  @override
  String get labelDownloadStarting => "Yükləmə başlanır...";
  @override
  String get labelDownloadCancelled => "Yükləmə ləğv edildi";
  @override
  String get labelAnIssueOcurredConvertingAudio =>
      "Səs dönüşdürməsi zamanı səhv baş verdi";
  @override
  String get labelPatchingAudio => "Səs təmir edilir...";

  // Download Menu
  @override
  String get labelEnableAudioConversion => "Səs dönüşümünü aktivləşdir";
  @override
  String get labelGainControls => "Gəlir idarələri";
  @override
  String get labelVolume => "Səs";
  @override
  String get labelBassGain => "Bas gəliri";
  @override
  String get labelTrebleGain => "Tiz gəliri";
  @override
  String get labelSelectVideo => "Video seçin";
  @override
  String get labelSelectAudio => "Səs seçin";
  @override
  String get labelGlobalParameters => "Ümumi parametrlər";

  // Media Screen
  @override
  String get labelMusic => "Musiqi";
  @override
  String get labelVideos => "Videolar";
  @override
  String get labelNoMediaYet => "Hələ kiçiklik yoxdur";
  @override
  String get labelNoMediaYetJustification =>
      "Bütün medya faylları " + "burada göstərilir";
  @override
  String get labelSearchMedia => "Medya axtar...";
  @override
  String get labelDeleteSong => "Mahnını sil";
  @override
  String get labelNoPermissionJustification =>
      "Medyalarınızı görmək üçün " + "\n" + "yaddaş icazəsi verin";
  @override
  String get labelGettingYourMedia => "Medya yüklənir...";
  @override
  String get labelEditTags => "Etiketləri düzəlt";

  // Navigate Screen
  @override
  String get labelSearchYoutube => "YouTube'da axtar...";

  // More Screen
  @override
  String get labelSettings => "Ayarlar";
  @override
  String get labelDonate => "Bağış Yap";
  @override
  String get labelLicenses => "Lisenziyalar";
  @override
  String get labelChooseColor => "Rəng seçin";
  @override
  String get labelTheme => "Tema";
  @override
  String get labelUseSystemTheme => "Sistem temasi istifadə et";
  @override
  String get labelUseSystemThemeJustification => "Avtomatik tema açıq/sondur";
  @override
  String get labelEnableDarkTheme => "Tünd temani aç";
  @override
  String get labelEnableDarkThemeJustification =>
      "Varsayılan olaraq tünd temani istifadə et";
  @override
  String get labelEnableBlackTheme => "Qara temani aç";
  @override
  String get labelEnableBlackThemeJustification =>
      "Saf qara temani aktivləşdir";
  @override
  String get labelAccentColor => "Əsas rəng";
  @override
  String get labelAccentColorJustification => "Əsas rəngi özəlləşdir";
  @override
  String get labelAudioFolder => "Səs qovluğu";
  @override
  String get labelAudioFolderJustification =>
      "Yüklənmiş səs faylları üçün " + "qovluq seçin";
  @override
  String get labelVideoFolder => "Video qovluğu";
  @override
  String get labelVideoFolderJustification =>
      "Yüklənmiş video faylları üçün " + "qovluq seçin";
  @override
  String get labelAlbumFolder => "Albom Qovluğu";
  @override
  String get labelAlbumFolderJustification =>
      "Hər albom üçün bir qovluq yaradın";
  @override
  String get labelDeleteCache => "Keşləri sil";
  @override
  String get labelDeleteCacheJustification => "SongTube keşlərini silin";
  @override
  String get labelAndroid11Fix => "Android 11 düzəltməsi";
  @override
  String get labelAndroid11FixJustification =>
      "Android 10 & 11 üçün yükləmə " + "problemələrini düzəldir";
  @override
  String get labelBackup => "Yedəklə";
  @override
  String get labelBackupJustification => "Media kitabxanasını yedəklə";
  @override
  String get labelRestore => "Bərpa et";
  @override
  String get labelRestoreJustification => "Media kitabxanasını bərpa et";
  @override
  String get labelBackupLibraryEmpty => "Kitabxananız boşdur";
  @override
  String get labelBackupCompleted => "Yedəkləmə tamamlandı";
  @override
  String get labelRestoreNotFound => "Bərpa faylı tapılmadı";
  @override
  String get labelRestoreCompleted => "Bərpa tamamlandı";
  @override
  String get labelCacheIsEmpty => "Keş boşdur";
  @override
  String get labelYouAreAboutToClear => "Diqqət! Silməyə hazırsınız";

  // Tags Editor TextFields
  @override
  String get labelEditorTitle => "Ad";
  @override
  String get labelEditorArtist => "İfaçı";
  @override
  String get labelEditorGenre => "Janr";
  @override
  String get labelEditorDisc => "Disk";
  @override
  String get labelEditorTrack => "Parça";
  @override
  String get labelEditorDate => "Tarix";
  @override
  String get labelEditorAlbum => "Albom";

  // Android 10 or 11 Detected Dialog
  @override
  String get labelAndroid11Detected => "Android 10 və ya 11 aşkarlandı";
  @override
  String get labelAndroid11DetectedJustification =>
      "Bu tətbiqində endirmə prosesinin düzgün işləməsi üçün " +
      "Android 10 və 11-də Fayl İstifadəsi icazəsinə ehtiyac var, " +
      "bu müvəqqəti bir düzəlişdir və gələcək yeniləmələrdə lazım olmayacaq. " +
      "Bu düzəlişi Ayarlardan da tətbiq edə bilərsiniz.";

  // Music Player
  @override
  String get labelPlayerSettings => "Oynatıcı ayarları";
  @override
  String get labelExpandArtwork => "Görseli genişlət";
  @override
  String get labelArtworkRoundedCorners => "Yuvanlaşdırılmış kənarlı görsəl";
  @override
  String get labelPlayingFrom => "Buradan oynatılır";
  @override
  String get labelBlurBackground => "Arxa fonu bulanıqlaşdır";

  // Video Page
  @override
  String get labelTags => "Etiketlər";
  @override
  String get labelRelated => "Əlaqəli";
  @override
  String get labelAutoPlay => "Avtomatik oynatma";

  // Tags Pages
  @override
  String get labelAudioFormatNotCompatible => "Səs formatı uyğun deyil";
  @override
  String get labelNotSpecified => "Təyin edilməyib";
  @override
  String get labelPerformAutomaticTagging =>
      "Avtomatik etiketləməni yerinə yetir";
  @override
  String get labelSelectTagsfromMusicBrainz => "Etiketləri MusicBrainz-dən seç";
  @override
  String get labelSelectArtworkFromDevice => "Qurğudan görsəli seç";

  // Telegram Join Channel Dialog
  @override
  String get labelJoinTelegramChannel => "Telegram kanalına qoşul!";
  @override
  String get labelJoinTelegramJustification =>
      "SongTube-u sevdinizmi? Telegram Kanalımıza qoşula bilərsiniz! " +
      "Yeniliklər, məlumatlar, inkişaf və ya digər sosial media əlaqələrini tapa bilərsiniz." +
      "\n\n" +
      "Sualınız və ya mükəmməl bir tövsiyəniz varsa, qrupumuza qoşularaq və yazaraq bildirə bilərsiniz! " +
      "Ancaq, yalnızca İngiliscə danışmağınızın tələb olunduğunu unutmayın. İndidən hamısına görə təşəkkür edirik!";
  @override
  String get labelRemindLater => "Daha sonra xatırlat";

  // Common Words (One word labels)
  @override
  String get labelExit => "Çıxış";
  @override
  String get labelSystem => "Sistem";
  @override
  String get labelChannel => "Kanal";
  @override
  String get labelShare => "Paylaş";
  @override
  String get labelAudio => "Səs";
  @override
  String get labelVideo => "Video";
  @override
  String get labelDownload => "Yüklə";
  @override
  String get labelBest => "Ən Yaxşı";
  @override
  String get labelPlaylist => "İzləmə listi";
  @override
  String get labelVersion => "Versiya";
  @override
  String get labelLanguage => "Dil";
  @override
  String get labelGrant => "İcazə ver";
  @override
  String get labelAllow => "İcazə ver";
  @override
  String get labelAccess => "Daxil ol";
  @override
  String get labelEmpty => "Boş";
  @override
  String get labelCalculating => "Hesablama";
  @override
  String get labelCleaning => "Təmizlənir";
  @override
  String get labelCancel => "Ləğv et";
  @override
  String get labelGeneral => "Ümumi";
  @override
  String get labelRemove => "Sil";
  @override
  String get labelJoin => "Qoşul";
  @override
  String get labelNo => "Xeyr";
  @override
  String get labelLibrary => "Kitabxana";
  @override
  String get labelCreate => "Yarat";
  @override
  String get labelPlaylists => "İzləmə listələri";
  @override
  String get labelQuality => "Keyfiyyət";
  @override
  String get labelSubscribe => "Abunə ol";

  // Other Translations
  @override
  String get labelNoFavoriteVideos => 'Sevimli Videolar Yoxdur';
  @override
  String get labelNoFavoriteVideosDescription =>
      'Videoları axtarın və onları sevimli olaraq saxlayın. Onlar burada görünəcək';
  @override
  String get labelNoSubscriptions => 'Abunələr Yoxdur';
  @override
  String get labelNoSubscriptionsDescription =>
      'Təklif edilən Kanalları görmək üçün yuxarıdakı düyməni toxun!';
  @override
  String get labelNoPlaylists => 'İzləmə listələri Yoxdur';
  @override
  String get labelNoPlaylistsDescription =>
      'Videoları və ya əyləncə listələrini axtarın və onları saxlayın. Onlar burada görünəcək';
  @override
  String get labelSearch => 'Axtar';
  @override
  String get labelSubscriptions => 'Abunələr';
  @override
  String get labelNoDownloadsCanceled => 'İndirilmələr İmtina Edildi';
  @override
  String get labelNoDownloadsCanceledDescription =>
      'Xəbərdarlıq! Lakin yükləməni ləğv edirsinizsə və ya yükləmədə bir şeylər səhv gedirsə, onları buradan yoxlaya bilərsiniz';
  @override
  String get labelNoDownloadsYet => 'Hələ İndirilmə Yoxdur';
  @override
  String get labelNoDownloadsYetDescription =>
      'Evə get, bir şeyləri yükləmək üçün bir şey axtar və ya sırada gözlə!';
  @override
  String get labelYourQueueIsEmpty => 'Sıranız boşdur';
  @override
  String get labelYourQueueIsEmptyDescription =>
      'Evə get və yükləmək üçün bir şeyləri axtarın!';
  @override
  String get labelQueue => 'Sıra';
  @override
  String get labelSearchDownloads => 'Yükləmələri axtar';
  @override
  String get labelWatchHistory => 'İzləmə Tarixi';
  @override
  String get labelWatchHistoryDescription =>
      'Hangi videoları izlədiyinizi baxın';
  @override
  String get labelBackupAndRestore => 'Yedekləmə və Geriyə qaytar';
  @override
  String get labelBackupAndRestoreDescription =>
      'Bütün yerli məlumatlarınızı yaddaşda saxlayın və geriyə qaytarın';
  @override
  String get labelSongtubeLink => 'SongTube Link';
  @override
  String get labelSongtubeLinkDescription =>
      'SongTube brauzer əlavəsini bu cihazı aşkar etməyə icazə verin, daha çox məlumat almaq üçün uzun basın';
  @override
  String get labelSupportDevelopment => 'İnkişafı Dəstəklə';
  @override
  String get labelSocialLinks => 'Sosial Linklər';
  @override
  String get labelSeeMore => 'Daha çox gör';
  @override
  String get labelMostPlayed => 'Ən çox oynanan';
  @override
  String get labelNoPlaylistsYet => 'Hələ İzləmə listələri Yoxdur';
  @override
  String get labelNoPlaylistsYetDescription =>
      'Zəhmət olmasa, musiqi, albom və ya ifaçılardan bir oynatma siyahısı yarada bilərsiniz';
  @override
  String get labelNoSearchResults => 'Axtarış nəticəsi yoxdur';
  @override
  String get labelSongResults => 'Mahnı nəticələri';
  @override
  String get labelAlbumResults => 'Albom nəticələri';
  @override
  String get labelArtistResults => 'İfaçı nəticələri';
  @override
  String get labelSearchAnything => 'Hər hansı bir şey axtar';
  @override
  String get labelRecents => 'Sonuncular';
  @override
  String get labelFetchingSongs => 'Mahnılar alınıyor';
  @override
  String get labelPleaseWaitAMoment => 'Bir an gözləyin';
  @override
  String get labelWeAreDone => 'Biz hazırıq';
  @override
  String get labelEnjoyTheApp => 'Tətbiqə zövq alın';
  @override
  String get labelSongtubeIsBackDescription =>
      'SongTube daha təmiz bir görünüş və xüsusiyyət dəsti ilə qayıdır, musiqinizlə eğlənəsiniz!';
  @override
  String get labelLetsGo => 'Getmək';
  @override
  String get labelPleaseWait => 'Zəhmət olmasa gözləyin';
  @override
  String get labelPoweredBy => 'Tərəfindən təchiz edilib';
  @override
  String get labelGetStarted => 'Başlamaq';
  @override
  String get labelAllowUsToHave => 'İcazə verin bizə';
  @override
  String get labelStorageRead => 'Yaddaş\nOxu';
  @override
  String get labelStorageReadDescription =>
      'Bu məlumatlarınızı axtaracaq, yüksək keyfiyyətli illüstrasiyaları çıxaracaq və musiqinizi şəxsiyyətləndirə biləcəyiniz bir mənbədir';
  @override
  String get labelContinue => 'Davam et';
  @override
  String get labelAllowStorageRead => 'Yaddaş Oxumasına İcazə Ver';
  @override
  String get labelSelectYourPreferred => 'Tərəfinizi seçin';
  @override
  String get labelLight => 'Açıq';
  @override
  String get labelDark => 'Tünd';
  @override
  String get labelSimultaneousDownloads => 'Eyni zamanda Yükləmələr';
  @override
  String get labelSimultaneousDownloadsDescription =>
      'Eyni anda baş verə biləcək yükləmə sayını müəyyənləşdirin';
  @override
  String get labelItems => 'Elementlər';
  @override
  String get labelInstantDownloadFormat => 'Anında Yükləmə';
  @override
  String get labelInstantDownloadFormatDescription =>
      'Anında yükləmələr üçün səs formatını dəyişdirin';
  @override
  String get labelCurrent => 'Cari';
  @override
  String get labelPauseWatchHistory => 'İzləmə Tarixini Dayandır';
  @override
  String get labelPauseWatchHistoryDescription =>
      'Dayandırıldığı zaman videolar izləmə tarix listinə qeyd olunmur';
  @override
  String get labelLockNavigationBar => 'Naviqasiya Panelini Kilidlə';
  @override
  String get labelLockNavigationBarDescription =>
      'Naviqasiya panelinin sürüşmə ilə avtomatik olaraq gizlənməsini və göstərilməsini kilidləyir';
  @override
  String get labelPictureInPicture => 'Şəkil şəklində';
  @override
  String get labelPictureInPictureDescription =>
      'Videoları izləyərkən ev düyməsinə toxunduqda avtomatik olaraq ŞŞ rejiminə daxil olur';
  @override
  String get labelBackgroundPlaybackAlpha => 'Artqalan Qayıtdırma (Alpha)';
  @override
  String get labelBackgroundPlaybackAlphaDescription =>
      'Artqalan qayıtdırma funksiyasını aktivləşdirin. Plugin məhdudiyyətləri səbəbindən, yalnız cari video fonunda oynanacaq';
  @override
  String get labelBlurBackgroundDescription =>
      'Qarışıq əsərin fonunu əlavə edin';
  @override
  String get labelBlurIntensity => 'Qarışıqlıq Şiddəti';
  @override
  String get labelBlurIntensityDescription =>
      'Əsərin fonunun qarışıqlığı şiddətini dəyişdirin';
  @override
  String get labelBackdropOpacity => 'Arxa fonun şəffaflığı';
  @override
  String get labelBackdropOpacityDescription =>
      'Rəngli arxa fonun şəffaflığını dəyişdirin';
  @override
  String get labelArtworkShadowOpacity => 'Şəklin Gölge Şəffaflığı';
  @override
  String get labelArtworkShadowOpacityDescription =>
      'Musiqi oynatıcısının əsəb gölge intensivliyini dəyişdirin';
  @override
  String get labelArtworkShadowRadius => 'Əsəb Gölge Radiusu';
  @override
  String get labelArtworkShadowRadiusDescription =>
      'Musiqi oynatıcısının əsəb gölge radiusunu dəyişdirin';
  @override
  String get labelArtworkScaling => 'Əsəb Ölçüləndirməsi';
  @override
  String get labelArtworkScalingDescription =>
      'Musiqi oynatıcısının əsəb və fon şəkillərini ölçüləndirin';
  @override
  String get labelBackgroundParallax => 'Fon Paralaksı';
  @override
  String get labelBackgroundParallaxDescription =>
      'Fon şəkli paralaks effektini etkinləşdirin/söndürün';
  @override
  String get labelRestoreThumbnails => 'Təsdiqləyiciləri bərpa et';
  @override
  String get labelRestoreThumbnailsDescription =>
      'Təsdiqləyiciləri və əsəblər bərpa prosesini tətbiq edin';
  @override
  String get labelRestoringArtworks => 'Əsəbləri bərpa edir';
  @override
  String get labelRestoringArtworksDone => 'Əsəblər bərpa olundu';
  @override
  String get labelHomeScreen => 'Əsas Ekran';
  @override
  String get labelHomeScreenDescription =>
      'Proqramı açdıqda görünən əsas ekranı dəyişdirin';
  @override
  String get labelDefaultMusicPage => 'Əsas Musiqi Səhifəsi';
  @override
  String get labelDefaultMusicPageDescription =>
      'Musiqi səhifəsi üçün əsas səhifəni dəyişdirin';
  @override
  String get labelAbout => 'Haqqında';
  @override
  String get labelConversionRequired => 'Dəyişdirilmə tələb olunur';
  @override
  String get labelConversionRequiredDescription =>
      'Bu mahnı formatı ID3 etiketlər redaktoruna uyğun deyil. Proqram bu mahnını otomatik olaraq AAC (m4a) formatına çevirərək bu problemi həll edəcək.';
  @override
  String get labelPermissionRequired => 'İcazə tələb olunur';
  @override
  String get labelPermissionRequiredDescription =>
      'SongTube-un cihazınızdakı hər hansı bir mahnını düzəltməsi üçün bütün fayl giriş icazəsinə ehtiyacı var';
  @override
  String get labelApplying => 'Tətbiq edilir';
  @override
  String get labelConvertingDescription =>
      'Bu mahnını AAC (m4a) formatına yenidən kodla';
  @override
  String get labelWrittingTagsAndArtworkDescription =>
      'Bu mahnıya yeni etiketləri tətbiq edir';
  @override
  String get labelApply => 'Tətbiq et';
  @override
  String get labelSongs => 'Mahnılar';
  @override
  String get labelPlayAll => 'Hamısını oynat';
  @override
  String get labelPlaying => 'Oynanır';
  @override
  String get labelPages => 'Səhifələr';
  @override
  String get labelMusicPlayer => 'Musiqi Oynatıcı';
  @override
  String get labelClearWatchHistory => 'İzləmə Tarixini Təmizlə';
  @override
  String get labelClearWatchHistoryDescription =>
      'Bütün izləmə tarixinizi silmək üzərəsiniz, bu əməliyyat geri alınamaz, davam etmək istəyirsiniz?';
  @override
  String get labelDelete => 'Sil';
  @override
  String get labelAppUpdate => 'Tətbiqin Yenilənməsi';
  @override
  String get labelWhatsNew => 'Nə Yeni';
  @override
  String get labelLater => 'Daha sonra';
  @override
  String get labelUpdate => 'Yenilə';
  @override
  String get labelUnsubscribe => 'Abunəliyi Ləğv Et';
  @override
  String get labelAudioFeatures => 'Audio Xüsusiyyətləri';
  @override
  String get labelVolumeBoost => 'Səs Gücü';
  @override
  String get labelNormalizeAudio => 'Audio-nu Normalizə Et';
  @override
  String get labelSegmentedDownload => 'Bölümlərə ayrılmış yükləmə';
  @override
  String get labelEnableSegmentedDownload =>
      'Bölümlərə ayrılmış yükləməni aktivləşdir';
  @override
  String get labelEnableSegmentedDownloadDescription =>
      'Bu, bütün audio faylını yükləyəcək və daha sonra aşağıdakı siyahıda mövcud olan müxtəlif bölümlərə (və ya audio tracklərə) böləcəkdir';
  @override
  String get labelCreateMusicPlaylist => 'Musiqi Playlisti Yarat';
  @override
  String get labelCreateMusicPlaylistDescription =>
      'Yüklənmiş və saxlanılmış bütün audio bölümlərindən musiqi playlisti yaradın';
  @override
  String get labelApplyTags => 'Etiketləri Tətbiq Et';
  @override
  String get labelApplyTagsDescription =>
      'MusiqiBrainz-dən bütün bölümlər üçün etiketləri çıxarın';
  @override
  String get labelLoading => 'Yüklənir';
  @override
  String get labelMusicDownloadDescription =>
      'Keyfiyyəti seçin, konvertasiya edin və yalnız audio yükləyin';
  @override
  String get labelVideoDownloadDescription =>
      'Siyahıdan bir video keyfiyyəti seçin və yükləyin';
  @override
  String get labelInstantDescription => 'Dərhal musiqi kimi yükləməyə başlayın';
  @override
  String get labelInstant => 'Anında';
  @override
  String get labelCurrentQuality => 'Cari Keyfiyyət';
  @override
  String get labelFastStreamingOptions => 'Sürətli Yayım Seçimləri';
  @override
  String get labelStreamingOptions => 'Yayım Seçimləri';
  @override
  String get labelComments => 'Rəylər';
  @override
  String get labelPinned => 'Pinnələnib';
  @override
  String get labelLikedByAuthor => 'Yazıçı tərəfindən bəyənilib';
  @override
  String get labelDescription => 'Təsvir';
  @override
  String get labelViews => 'Baxışlar';
  @override
  String get labelPlayingNextIn => 'Növbəti oynanacaq';
  @override
  String get labelPlayNow => 'İndi Oyna';
  @override
  String get labelLoadingPlaylist => 'Playlist Yüklənir';
  @override
  String get labelPlaylistReachedTheEnd => 'Playlist sona çatıb';
  @override
  String get labelLiked => 'Bəyəndim';
  @override
  String get labelLike => 'Bəyən';
  @override
  String get labelVideoRemovedFromFavorites => 'Video seçilənlərdən silindi';
  @override
  String get labelVideoAddedToFavorites => 'Video seçilənlərə əlavə edildi';
  @override
  String get labelPopupMode => 'Popup Rejimi';
  @override
  String get labelDownloaded => 'Yüklənib';
  @override
  String get labelShowPlaylist => 'Playlisti Göstər';
  @override
  String get labelCreatePlaylist => 'Playlist Yarat';
  @override
  String get labelAddVideoToPlaylist => 'Videoni playlistə əlavə et';
  @override
  String get labelBackupDescription =>
      'Bütün yerli məlumatlarınızı bir fayla yedəkləyin və sonra bərpa etmək üçün istifadə edə bilərsiniz';
  @override
  String get labelBackupCreated => 'Yedəkləmə Yaradıldı';
  @override
  String get labelBackupRestored => 'Yedəkləmə Geri Qaytarıldı';
  @override
  String get labelRestoreDescription =>
      'Bütün məlumatlarınızı bir yedəkləmə fayldan bərpa edin';
  @override
  String get labelChannelSuggestions => 'Kanal Təklifləri';
  @override
  String get labelFetchingChannels => 'Kanallar Alınır';
  @override
  String get labelShareVideo => 'Videonu Paylaş';
  @override
  String get labelShareDescription =>
      'Dostlarınızla və ya digər platformalarla paylaşın';
  @override
  String get labelRemoveFromPlaylists => 'Playlistdən sil';
  @override
  String get labelThisActionCannotBeUndone => 'Bu əməliyyat geri alına bilməz';
  @override
  String get labelAddVideoToPlaylistDescription =>
      'Mövcud və ya yeni playlistə əlavə edin';
  @override
  String get labelAddToPlaylists => 'Playlistlərə əlavə et';
  @override
  String get labelEditableOnceSaved =>
      'Yadda saxlandıqdan sonra redaktə edilə bilər';
  @override
  String get labelPlaylistRemoved => 'Playlist Silindi';
  @override
  String get labelPlaylistSaved => 'Playlist Saxlandı';
  @override
  String get labelRemoveFromFavorites => 'Seçilənlərdən sil';
  @override
  String get labelRemoveFromFavoritesDescription =>
      'Bu videoyu seçilənlərinizdən silin';
  @override
  String get labelSaveToFavorites => 'Seçilənlərə əlavə et';
  @override
  String get labelSaveToFavoritesDescription =>
      'Videoyu seçilənləriniz siyahısına əlavə edin';
  @override
  String get labelSharePlaylist => 'Playlisti Paylaş';
  @override
  String get labelRemoveThisVideoFromThisList =>
      'Bu videonu bu siyahıdan silin';
  @override
  String get labelEqualizer => 'Eyniləyici';
  @override
  String get labelLoudnessEqualizationGain => 'Səs Uyğunlaşdırma Qazancı';
  @override
  String get labelSliders => 'Slayderlər';
  @override
  String get labelSave => 'Saxla';
  @override
  String get labelPlaylistName => 'Playlist Adı';
  @override
  String get labelCreateVideoPlaylist => 'Video Playlisti Yarat';
  @override
  String get labelSearchFilters => 'Axtarış Filterləri';
  @override
  String get labelAddToPlaylistDescription =>
      'Mövcud və ya yeni playlistə əlavə edin';
  @override
  String get labelShareSong => 'Mahnını Paylaş';
  @override
  String get labelShareSongDescription =>
      'Dostlarınızla və ya digər platformalarla paylaşın';
  @override
  String get labelEditTagsDescription => 'ID3 etiketlərini və iş banerini açın';
  @override
  String get labelContains => 'İçindən Keçir';
}
