import 'package:songtube/languages/languages.dart';

class LanguageTr extends Languages {

  // Introduction Screens
  @override
  String get labelAppWelcome => "Hoşgeldiniz";
  @override
  String get labelStart => "Başlat";
  @override
  String get labelSkip => "Atla";
  @override
  String get labelNext => "Sonraki";
  @override
  String get labelExternalAccessJustification =>
    "Videolar ve müzikler indirebilmek için " +
    "depolama izni gerekli";
  @override
  String get labelAppCustomization => "Özelleştirmeler";
  @override
  String get labelSelectPreferred => "Tercihinizi seçin";
  @override
  String get labelConfigReady => "Yapılandırma hazır";
  @override
  String get labelIntroductionIsOver => "Herşey tamam";
  @override
  String get labelEnjoy => "Tadını çıkarın";
  @override 
  String get labelGoHome => "Ana Sayfaya git";

  // Bottom Navigation Bar
  @override
  String get labelHome => "Ana Sayfa";
  @override
  String get labelDownloads => "İndirilenler";
  @override
  String get labelMedia => "Medya";
  @override
  String get labelYouTube => "YouTube";
  @override
  String get labelMore => "Daha fazla";

  // Home Screen
  @override
  String get labelQuickSearch => "Hızlı arama...";
  @override
  String get labelTagsEditor => "Etiketleri\ndüzenle";
  @override
  String get labelEditArtwork => "Görseli\ndüzenle";
  @override
  String get labelDownloadAll => "Hepsini indir";
  @override 
  String get labelLoadingVideos => "Videolar yükleniyor...";
  @override
  String get labelHomePage => "Ana Sayfa";
  @override
  String get labelTrending => "Trendler";
  @override
  String get labelFavorites => "Favoriler";
  @override
  String get labelWatchLater => "Sonra izle";

  // Video Options Menu
  @override
  String get labelCopyLink => "Bağlantıyı kopyala";
  @override
  String get labelAddToFavorites => "Favorilere ekle";
  @override
  String get labelAddToWatchLater => "Sonra izle";
  @override
  String get labelAddToPlaylist => "Oynatma listesine ekle";

  // Downloads Screen
  @override
  String get labelQueued => "Sıraya alındı";
  @override
  String get labelDownloading => "İndiriliyor";
  @override
  String get labelConverting => "Dönüştürülüyor";
  @override
  String get labelCancelled => "İptal edildi";
  @override
  String get labelCompleted => "Tamamlandı";

  // Download Status/Error Messages
  @override
  String get labelDownloadQueued => "İndirme sıraya alındı";
  @override
  String get labelDownloadAcesssDenied => "İzin reddedildi";
  @override
  String get labelClearingExistingMetadata => "Zaten varolan meta veri siliniyor...";
  @override
  String get labelWrittingTagsAndArtwork => "Etiketler & görsel uygulanıyor...";
  @override
  String get labelSavingFile => "Dosya kaydediliyor...";
  @override
  String get labelAndroid11FixNeeded => "Hata, Android 11 için ek düzeltme gerekli, Ayarları kontrol edin";
  @override
  String get labelErrorSavingDownload => "Dosya kaydedilemedi, uygulama izinlerini kontrol edin";
  @override
  String get labelDownloadingVideo => "Video indiriliyor...";
  @override
  String get labelDownloadingAudio => "Ses indiriliyor...";
  @override
  String get labelGettingAudioStream => "Ses akışı indiriliyor...";
  @override
  String get labelAudioNoDataRecieved => "Ses akışı alınamadı";
  @override
  String get labelDownloadStarting => "İndirme başlatılıyor...";
  @override
  String get labelDownloadCancelled => "İndirme iptal edildi";
  @override
  String get labelAnIssueOcurredConvertingAudio => "Dönüştürme başarısız oldu";
  @override
  String get labelPatchingAudio => "Ses yamalanıyor...";

  // Download Menu
  @override
  String get labelEnableAudioConversion => "Ses dönüşümünü etkinleştir";
  @override
  String get labelGainControls => "Frekans kontrolleri";
  @override
  String get labelVolume => "Ses";
  @override
  String get labelBassGain => "Bass yüksekliği";
  @override
  String get labelTrebleGain => "Tiz yüksekliği";
  @override
  String get labelSelectVideo => "Video seç";
  @override
  String get labelSelectAudio => "Ses seç";
  @override
  String get labelGlobalParameters => "Genel Ayarlamalar";

  // Media Screen
  @override
  String get labelMusic => "Müzik";
  @override
  String get labelVideos => "Videolar";
  @override
  String get labelNoMediaYet => "Henüz burası boş";
  @override
  String get labelNoMediaYetJustification => "Tüm medya dosyalarınız " +
    "burada gösterilir";
  @override
  String get labelSearchMedia => "Medyalarda ara...";
  @override
  String get labelDeleteSong => "Şarkıyı sil";
  @override
  String get labelNoPermissionJustification => "Depolama izni vererek" + "\n" +
    "medyalarınızı görüntüleyin";
  @override
  String get labelGettingYourMedia => "Medya yükleniyor...";
  @override
  String get labelEditTags => "Etiketleri düzenle";

  // Navigate Screen
  @override
  String get labelSearchYoutube => "Youtube'da ara...";

  // More Screen
  @override
  String get labelSettings => "Ayarlar";
  @override
  String get labelDonate => "Bağış Yap";
  @override
  String get labelLicenses => "Lisanslar";
  @override
  String get labelChooseColor => "Renk seç";
  @override
  String get labelTheme => "Tema";
  @override
  String get labelUseSystemTheme => "Sistem temasını kullan";
  @override
  String get labelUseSystemThemeJustification =>
    "Otomatik temayı aç/kapat";
  @override
  String get labelEnableDarkTheme => "Koyu temayı aç";
  @override
  String get labelEnableDarkThemeJustification =>
    "Varsayılan olarak koyu temayı kullan";
  @override
  String get labelEnableBlackTheme => "Siyah temayı aç";
  @override
  String get labelEnableBlackThemeJustification =>
    "Saf siyah temayı etkinleştir";
  @override
  String get labelAccentColor => "Varsayılan renk";
  @override
  String get labelAccentColorJustification => "Varsayılan rengi özelleştir";
  @override
  String get labelAudioFolder => "Ses klasörü";
  @override
  String get labelAudioFolderJustification => "İndirilen ses dosyaları için " +
    "klasör seç";
  @override
  String get labelVideoFolder => "Video klasörü";
  @override
  String get labelVideoFolderJustification => "İndirilen video dosyaları için " +
    "klasör seç";
  @override
  String get labelAlbumFolder => "Albüm Klasörü";
  @override
  String get labelAlbumFolderJustification => "Her albüm için bir klasör oluştur";
  @override
  String get labelDeleteCache => "Önbelleği temizle";
  @override
  String get labelDeleteCacheJustification => "SongTube önbelleğini temizle";
  @override
  String get labelAndroid11Fix => "Android 11 ek düzeltmesi";
  @override
  String get labelAndroid11FixJustification => "Android 10 & 11 versiyonları için indirme " +
    "sorunlarını düzeltir";
  @override
  String get labelBackup => "Yedekle";
  @override
  String get labelBackupJustification => "Medya kütüphanesini yedekle";
  @override
  String get labelRestore => "Geri yükle";
  @override
  String get labelRestoreJustification => "Medya kütüphanesini geri yükle";
  @override
  String get labelBackupLibraryEmpty => "Kütüphaneniz boş";
  @override
  String get labelBackupCompleted => "Yedekleme tamamlandı";
  @override
  String get labelRestoreNotFound => "Geri yükleme dosyası bulunamadı";
  @override
  String get labelRestoreCompleted => "Geri yükleme tamamlandı";
  @override
  String get labelCacheIsEmpty => "Önbellek boş";
  @override
  String get labelYouAreAboutToClear => "Dikkat! Temizleme işlemini başlatmak üzeresin";

  // Tags Editor TextFields
  @override
  String get labelEditorTitle => "Ad";
  @override
  String get labelEditorArtist => "Sanatçı";
  @override
  String get labelEditorGenre => "Tür";
  @override
  String get labelEditorDisc => "Disk";
  @override
  String get labelEditorTrack => "Parça";
  @override
  String get labelEditorDate => "Tarih";
  @override
  String get labelEditorAlbum => "Albüm";

  // Android 10 or 11 Detected Dialog
  @override
  String get labelAndroid11Detected => "Android 10 ya da 11 algılandı";
  @override
  String get labelAndroid11DetectedJustification => "Bu uygulamada indirme işleminin doğru çalışması için " +
    "Android 10 ve 11'de Dosya Erişim iznine gereksinim duyar, " +
    "bu geçici bir çözümdür ve gelecek güncellemelerde bu tür bir izne gerek olmayacak. " +
    "Bu ek düzeltmeyi Ayarlar'dan da uygulayabilirsiniz.";

  // Music Player
  @override
  String get labelPlayerSettings => "Oynatıcı ayarları";
  @override
  String get labelExpandArtwork => "Görseli genişlet";
  @override
  String get labelArtworkRoundedCorners => "Kenarları yumuşatılmış kapak resmi";
  @override
  String get labelPlayingFrom => "Şuradan oynat";
  @override
  String get labelBlurBackground => "Arka plan bulanıklaştırma";

  // Video Page
  @override
  String get labelTags => "Etiketler";
  @override
  String get labelRelated => "Alakalı";
  @override
  String get labelAutoPlay => "Otomatik oynatma";

  // Tags Pages
  @override
  String get labelAudioFormatNotCompatible =>
    "Ses formatı uyumlu değil";
  @override
  String get labelNotSpecified => "Belirtilmemiş";
  @override
  String get labelPerformAutomaticTagging => 
    "Otomatik etiketle";
  @override
  String get labelSelectTagsfromMusicBrainz => 
    "MusicBrainz'den etiketleri al";
  @override
  String get labelSelectArtworkFromDevice =>
    "Cihazdan görsel seç";
  
  // Telegram Join Channel Dialog
  @override
  String get labelJoinTelegramChannel => "Telegram kanalına katıl!";
  @override
  String get labelJoinTelegramJustification =>
    "SongTube'u sevdiniz mi? Telegram Kanalımıza katılabilirsiniz! " +
    "Güncellemeler, bilgi, geliştirme, grup bağlantısı veya diğer sosyal medya bağlantılarını bulabilirsiniz." +
    "\n\n" +
    "Aklınıza takılan bir sorun veya harika bir öneriniz varsa lütfen kanaldaki grup bağlantısını " +
    "kullanarak grubumuza katılın ve yazın! Ancak yalnızca İngilizce konuşmanız gerektiğini unutmayın, " +
    "Şimdiden herşey için teşekkürler!";
  @override
  String get labelRemindLater => "Daha sonra hatırlat";

  // Common Words (One word labels)
  @override
  String get labelExit => "Çıkış";
  @override
  String get labelSystem => "Sistem";
  @override
  String get labelChannel => "Kanal";
  @override
  String get labelShare => "Paylaş";
  @override
  String get labelAudio => "Ses";
  @override
  String get labelVideo => "Video";
  @override
  String get labelDownload => "İndir";
  @override
  String get labelBest => "En İyi";
  @override
  String get labelPlaylist => "Oynatma listesi";
  @override
  String get labelVersion => "Sürüm";
  @override
  String get labelLanguage => "Dil";
  @override
  String get labelGrant => "İzin ver";
  @override
  String get labelAllow => "Kabul et";
  @override
  String get labelAccess => "İzin Ver";
  @override
  String get labelEmpty => "Boş";
  @override
  String get labelCalculating => "Hesaplanıyor";
  @override
  String get labelCleaning => "Temizleniyor";
  @override
  String get labelCancel => "İptal";
  @override
  String get labelGeneral => "Genel";
  @override
  String get labelRemove => "Kaldır";
  @override
  String get labelJoin => "Katıl";
  @override
  String get labelNo => "Hayır";
  @override
  String get labelLibrary => "Kütüphane";
  @override
  String get labelCreate => "Oluştur";
  @override
  String get labelPlaylists => "Oynatma Listeleri";
  @override
  String get labelQuality => "Kalite";
  @override
  String get labelSubscribe => "Abone ol";

  // Other Translations
  @override
  String get labelNoFavoriteVideos => 'Favorilerde Video Yok';
  @override
  String get labelNoFavoriteVideosDescription => 'Videoları aratın ve favorilere kaydedin. Burada gözükeceklerdir';
  @override
  String get labelNoSubscriptions => 'Abonelik Yok';
  @override
  String get labelNoSubscriptionsDescription => 'Önerilen kanalları göstermek için aşağıda ki butona tıklayın!';
  @override
  String get labelNoPlaylists => 'Oynatma Listesi Yok';
  @override
  String get labelNoPlaylistsDescription => 'Oynatma listesi ya da videoları aratın ve kaydedin. Burada gözükeceklerdir';
  @override
  String get labelSearch => 'Ara';
  @override
  String get labelSubscriptions => 'Abonelikler';
  @override
  String get labelNoDownloadsCanceled => 'Hiç Bir İndirme İptal Edilmedi';
  @override
  String get labelNoDownloadsCanceledDescription => 'Bu iyi haber demek! Herhangi bir İndrimeyi iptal ederseniz ya da bir şeyler yanlış giderse buradan kontrol edebilirsiniz';
  @override
  - [x] String get labelNoDownloadsYet => 'Herhangi Bir İndirme İşlemi Yok';
  @override
  String get labelNoDownloadsYetDescription => 'Ana Sayfaya gidin, ve indrimek için bir şeyler arayın ya da indirmelerin bitmesini bekleyin!';
  @override
  String get labelYourQueueIsEmpty => 'İndirme sıranız boş';
  @override
  String get labelYourQueueIsEmptyDescription => 'Ana sayfaya gidin ve indirmek için bir şeyler arayın!';
  @override
  String get labelQueue => 'İndrime Sırası';
  @override
  String get labelSearchDownloads => 'İndirilenleri Ara';
  @override
  String get labelWatchHistory => 'İzleme Geçmişi';
  @override
  String get labelWatchHistoryDescription => 'Hangi videoları gördüğünüze bakın';
  @override
  String get labelBackupAndRestore => 'Yedekle & Geri Yükle';
  @override
  String get labelBackupAndRestoreDescription => 'Cihazda ki verilerinizi yedekleyin ya da geri yükleyin';
  @override
  String get labelSongtubeLink => "SongTube'un Linki";
  @override
  String get labelSongtubeLinkDescription => 'SongTube tarayıcı eklentisinin bu cihazı görmesine izin verin, basılı tutarak ne olduğunu öğrenebilirsiniz';
  @override
  String get labelSupportDevelopment => 'Uygulamayı Destekle';
  @override
  String get labelSocialLinks => 'Sosyal Bağlantılar';
  @override
  String get labelSeeMore => 'Daha fazla';
  @override
  String get labelMostPlayed => 'En Çok Oynatılan';
  @override
  String get labelNoPlaylistsYet => 'Oynatma Listesi Yok';
  @override
  String get labelNoPlaylistsYetDescription => 'Son İzlediklerinizden, Müziklerden, Albümlerden ya da Sanatçılardan oynatma listeleri oluşturabilirsiniz';
  @override
  String get labelNoSearchResults => 'Aramanız için sonuç yok';
  @override
  String get labelSongResults => 'Şarkı Sonuçları';
  @override
  String get labelAlbumResults => 'Albüm Sonuçları';
  @override
  String get labelArtistResults => 'Sanatçı Sonuçları';
  @override
  String get labelSearchAnything => 'Herhangi bir şey arayın';
  @override
  String get labelRecents => 'En Son Oynatılanlar';
  @override
  String get labelFetchingSongs => 'Şarkı Eşleniyor';
  @override
  String get labelPleaseWaitAMoment => 'Lütfen bir süre bekleyin';
  @override
  String get labelWeAreDone => 'Tamamdır';
  @override
  String get labelEnjoyTheApp => 'Uygulamanın\nKeyfine Bakın';
  @override
  String get labelSongtubeIsBackDescription => 'SongTube güzel bir görünümle ve fiyakalı özelliklerle donatılmıştır, müziğinizin keyfini çıkarın!';
  @override
  String get labelLetsGo => 'Hadi\ başlayalım';
  @override
  String get labelPleaseWait => 'Lütfen bekleyin';
  @override
  String get labelPoweredBy => 'Altyapısıyla Desteklenir:';
  @override
  String get labelGetStarted => 'Hadi Başlayalım';
  @override
  String get labelAllowUsToHave => 'İzinleri sağlayın;';
  @override
  String get labelStorageRead => 'Depolamaya\nErişim';
  @override
  String get labelStorageReadDescription => 'Bu izinle müziklerinizi tarayacağız, yüksek kaliteli kapak fotoğraflarını önünüze sereceğiz ve size özel kişiselleştirilmiş bir müzik deneyimi sunacağız';
  @override
  String get labelContinue => 'Devam et';
  @override
  String get labelAllowStorageRead => 'Depolamaya Erişime İzin Ver';
  @override
  String get labelSelectYourPreferred => 'Tercihini seç';
  @override
  String get labelLight => 'Açık';
  @override
  String get labelDark => 'Koyu';
  @override
  String get labelSimultaneousDownloads => 'Eşzamanlı İndirme';
  @override
  String get labelSimultaneousDownloadsDescription => 'Aynı anda ne kadar indirme olacağını belirleyin';
  @override
  String get labelItems => 'Nesneler';
  @override
  String get labelInstantDownloadFormat => 'Anında İndirme';
  @override
  String get labelInstantDownloadFormatDescription => 'Anında indirmeler için ses formatını değiştirin';
  @override
  String get labelCurrent => 'Şu anda';
  @override
  String get labelPauseWatchHistory => 'İzleme Geçmişini Durdur';
  @override
  String get labelPauseWatchHistoryDescription => 'Aktif olduğunda videolar izleme geçmişine kaydedilmez';
  @override
  String get labelLockNavigationBar => 'Navigasyon Çubuğunu Kilitle';
  @override
  String get labelLockNavigationBarDescription => 'Kaydırmaya bağlı olarak otomatik olarak gizlenen ve gösterilen navigasyon çubuğunu sabitler';
  @override
  String get labelPictureInPicture => 'Resim içinde Resim';
  @override
  String get labelPictureInPictureDescription => 'Bir videoyu izlerken Ana Butona tıklarsanız otomatik olarak RiR (Resim içinde Resim) moduna girer';
  @override
  String get labelBackgroundPlaybackAlpha => 'Arkaplanda Oynatma (Deneysel)';
  @override
  String get labelBackgroundPlaybackAlphaDescription => 'Arkaplanda Oynatmayı etkinleştirir. Bazı kısıtlamalardan dolayı sadece şu an oynatılan video arkaplanda oynatılabilir';
  @override
  String get labelBlurBackgroundDescription => 'Arkaplana kapağın bulanıklaştırılmış halini ekle';
  @override
  String get labelBlurIntensity => 'Bulanıklaştırma Yoğunluğu';
  @override
  String get labelBlurIntensityDescription => 'Arkaplan kapağının bulanıklaştırma yoğunluğunu değiştir';
  @override
  String get labelBackdropOpacity => 'Arkaplan Saydamlığı';
  @override
  String get labelBackdropOpacityDescription => 'Renklendirilmiş arkaplan saydamlığını değiştirin';
  @override
  String get labelArtworkShadowOpacity => 'Kapak Fotoğrafının Gölgesinin Saydamlığı';
  @override
  String get labelArtworkShadowOpacityDescription => 'Müzik oynatıcının kapak fotoğrafı gösterme modülünün gölge eklentisinin yoğunluğunu değiştirin';
  @override
  String get labelArtworkShadowRadius => 'Kapak Fotoğrafının Gölgesinin Yarıçapı';
  @override
  String get labelArtworkShadowRadiusDescription => 'Müzik oynatıcının kapak fotoğrafı gösterme modülünün gölge eklentisinin yarıçapını değiştirin';
  @override
  String get labelArtworkScaling => 'Kapak Fotoğrafının Ölçeklendirmesi';
  @override
  String get labelArtworkScalingDescription => 'Müzik oynatıcının kapak fotoğrafı ve arkaplan modülünün ölçeklemesini değiştirin';
  @override
  String get labelBackgroundParallax => 'Arkaplan Paralaksı';
  @override
  String get labelBackgroundParallaxDescription =>  'Arkaplan resmindeki paralaks efektini Etkinleştir/Devre Dışı bırak';
  @override
  String get labelRestoreThumbnails => 'Küçük Resimleri Yenile';
  @override
  String get labelRestoreThumbnailsDescription => 'Küçük resimleri ve kapak resimlerini yenilemeye zorlar';
  @override
  String get labelRestoringArtworks => 'Kapak resimleri yenileniyor';
  @override
  String get labelRestoringArtworksDone => 'Kapak resimleri yenilendi';
  @override
  String get labelHomeScreen => 'Ana Ekran';
  @override
  String get labelHomeScreenDescription => 'Uygulamayı açtığınızda varsayılan açılış sayfasını değiştirin';
  @override
  String get labelDefaultMusicPage => 'Varsayılan Müzik Sayfası';
  @override
  String get labelDefaultMusicPageDescription => 'Müzik Sayfası için varsayılan sayfayı değiştirin';
  @override
  String get labelAbout => 'Hakkında';
  @override
  String get labelConversionRequired => 'Dönüştürme İşlemi Gerekli';
  @override
  String get labelConversionRequiredDescription =>  'Bu şarkının formatı ID3 etiket editörü ile uyumsuz. Uyumsuzluk sorununu gidermek maksadıyla bu şarkının formatını AAC (m4a) olarak formatlayacağız.';
  @override
  String get labelPermissionRequired => 'İzin Gerekli';
  @override
  String get labelPermissionRequiredDescription => "SongTube'un cihazınızda ki tüm şarkılara erişebilmesi ve düzenleyebilmesi için 'Tüm dosyalara erişim' izni gereklidir";
  @override
  String get labelApplying => 'Uygulanıyor';
  @override
  String get labelConvertingDescription => 'Şarkı AAC (m4a) olarak yeniden formatlanıyor';
  @override
  String get labelWrittingTagsAndArtworkDescription => 'Şarkıya yeni etiketler atanıyor';
  @override
  String get labelApply => 'Tamamla';
  @override
  String get labelSongs => 'Şarkılar';
  @override
  String get labelPlayAll => 'Hepsini Oynat';
  @override
  String get labelPlaying => 'Oynatılıyor';
  @override
  String get labelPages => 'Sayfalar';
  @override
  String get labelMusicPlayer => 'Müzik Oynatıcı';
  @override
  String get labelClearWatchHistory => 'İzleme Geçmişini Temizle';
  @override
  String get labelClearWatchHistoryDescription =>  'İzleme\ Geçmişinin tamamını silmek üzeresiniz, bu işlem geri alınamaz. Devam etmek istiyor musunuz?';
  @override
  String get labelDelete => 'Sil';
  @override
  String get labelAppUpdate => 'Uygulama Güncellemesi';
  @override
  String get labelWhatsNew => 'Neler\ Yeni';
  @override
  String get labelLater => 'Daha Sonra';
  @override
  String get labelUpdate => 'Güncelle';
  @override
  String get labelUnsubscribe => 'Abonelikten çık';
  @override
  String get labelAudioFeatures => 'Ses Özellikleri';
  @override
  String get labelVolumeBoost => 'Sesi Aşırt';
  @override
  String get labelNormalizeAudio => 'Sesi Normalleştir';
  @override
  String get labelSegmentedDownload => 'Parçacıklı İndirme';
  @override
  String get labelEnableSegmentedDownload => 'Parçacıklı İndirmeyi Aktifleştir';
  @override
  String get labelEnableSegmentedDownloadDescription => 'Bu işlev bir önizleme olarak şarkının bütününü indirir, daha sonra bunu rehber olarak kullanarak belli parçacıklara (ya da ses parçalarına) aşağıda ki listeyi kullanarak böler';
  @override
  String get labelCreateMusicPlaylist => 'Müzik Çalma Listesi Oluştur';
  @override
  String get labelCreateMusicPlaylistDescription => 'İndirilen ve kaydedilen tüm ses parçalarından bir müzik çalma listesi oluşturun';
  @override
  String get labelApplyTags => 'Etiketleri Onayla';
  @override
  String get labelApplyTagsDescription => 'MusicBrainz kullanarak tüm parçalar için etiketleri getir';
  @override
  String get labelLoading => 'Yükleniyor;
  @override
  String get labelMusicDownloadDescription => 'Kaliteyi seç, ve dönüştürüp sadece ses olarak indir';
  @override
  String get labelVideoDownloadDescription =>  'Aşağıda ki listeden kaliteyi seç ve indir';
  @override
  String get labelInstantDescription => 'İndirimeyi müzik varsayarak anında başlat';
  @override
  String get labelInstant => 'Anında';
  @override
  String get labelCurrentQuality => 'Seçili Kalite';
  @override
  String get labelFastStreamingOptions => 'Hızlı Akış Seçenekleri';
  @override
  String get labelStreamingOptions => 'Akış Seçenekleri';
  @override
  String get labelComments => 'Yorumlar';
  @override
  String get labelPinned => 'Sabitlenmiş';
  @override
  String get labelLikedByAuthor => 'Kanal Sahibi Tarafından Beğenilmiş';
  @override
  String get labelDescription => 'Açıklama';
  @override
  String get labelViews => 'İzlenmeler';
  @override
  String get labelPlayingNextIn => 'Bir sonraki oynatılacak:';
  @override
  String get labelPlayNow => 'Şimdi Oynat';
  @override
  String get labelLoadingPlaylist => 'Oynatma Listesi Yükleniyor';
  @override
  String get labelPlaylistReachedTheEnd => 'Oynatma Listesinin sonu';
  @override
  String get labelLiked => 'Beğenildi';
  @override
  String get labelLike => 'Beğen';
  @override
  String get labelVideoRemovedFromFavorites => 'Video favorilerden kaldırıldı';
  @override
  String get labelVideoAddedToFavorites => 'Video favorilere eklendi';
  @override
  String get labelPopupMode => 'Açılır Pencere Modu';
  @override
  String get labelDownloaded => 'İndirildi';
  @override
  String get labelShowPlaylist => 'Oynatma Listesini Göster';
  @override
  String get labelCreatePlaylist => 'Oynatma Listesi Oluştur';
  @override
  String get labelAddVideoToPlaylist => 'Oynatma Listesine video ekle';
  @override
  String get labelBackupDescription => 'Tüm uygulama verilerini tek bir dosyaya sonradan geri yüklemek maksadıyla yedekle';
  @override
  String get labelBackupCreated => 'Yedek Oluşturuldu';
  @override
  String get labelBackupRestored => 'Yedek Geri Yüklendi';
  @override
  String get labelRestoreDescription => 'Bir yedek dosyasından tüm verilerini geri yükle';
  @override
  String get labelChannelSuggestions => 'Kanal Önerileri';
  @override
  String get labelFetchingChannels => 'Kanallar Yükleniyor';
  @override
  String get labelShareVideo => 'Paylaşılan Video';
  @override
  String get labelShareDescription => 'Arkadaşlarınla ya da diğer platformlarda paylaş';
  @override
  String get labelRemoveFromPlaylists => 'Oynatma listesinden kaldır';
  @override
  String get labelThisActionCannotBeUndone => 'Bu işlem geri alınamaz';
  @override
  String get labelAddVideoToPlaylistDescription => 'Zaten olan ya da yeni oluşturacağın oynatma listesine ekle';
  @override
  String get labelAddToPlaylists => 'Oynatma listesine ekle';
  @override
  String get labelEditableOnceSaved => 'Kaydettikten sonra düzenleyebilirsiniz';
  @override
  String get labelPlaylistRemoved => 'Oynatma Listesi Silindi';
  @override
  String get labelPlaylistSaved => 'Oynatma Listesi Kaydedildi';
  @override
  String get labelRemoveFromFavorites => 'Favorilerden kaldır';
  @override
  String get labelRemoveFromFavoritesDescription => 'Bu videoyu favorilerden kaldırın';
  @override
  String get labelSaveToFavorites => 'Favorilere kaydet';
  @override
  String get labelSaveToFavoritesDescription => 'Favoriler listenize video ekleyin';
  @override
  String get labelSharePlaylist => 'Oynatma Listesini Paylaş';
  @override
  String get labelRemoveThisVideoFromThisList => 'Videoyu listeden kaldır';
  @override
  String get labelEqualizer => 'Frekans Düzenleyici';
  @override
  String get labelLoudnessEqualizationGain => 'Ses Yüksekliğindeki Frekansları Eşitle';
  @override
  String get labelSliders => 'Kaydırma Kontrolleri';
  @override
  String get labelSave => 'Kaydet';
  @override
  String get labelPlaylistName => 'Oynatma Listesi İsmi';
  @override
  String get labelCreateVideoPlaylist => 'Video Oynatma Listesi Oluştur';
  @override
  String get labelSearchFilters => 'Arama Filtreleri';
  @override
  String get labelAddToPlaylistDescription => 'Zaten olan ya da yeni oluşturacağınız oynatma listesine ekleyin';
  @override
  String get labelShareSong => 'Şarkıyı Paylaş';
  @override
  String get labelShareSongDescription => 'Arkadaşlarınızla ya da diğer platformlarda paylaşın';
  @override
  String get labelEditTagsDescription => 'ID3 etiketi ve kapak fotoğrafı düzenleyicisini açın';
  @override
  String get labelContains => 'İçerir';
}
