import 'package:songtube/internal/languages.dart';

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
  String get labelGoHome => "Ana sayfaya git";

  // Bottom Navigation Bar
  @override
  String get labelHome => "Ana sayfa";
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
  String get labelHomePage => "Ana sayfa";
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
  String get labelAndroid11FixNeeded => "Hata, Android 11 düzeltmesi gerekli, Ayarları kontrol edin";
  @override
  String get labelErrorSavingDownload => "Dosya kaydedilemedi, uygulama izinlerini kontrol edin";
  @override
  String get labelDownloadingVideo => "Video indiriliyor...";
  @override
  String get labelDownloadingAudio => "Ses indiriliyor...";
  @override
  String get labelGettingAudioStream => "Ses yayını indiriliyor...";
  @override
  String get labelAudioNoDataRecieved => "Ses yayını alınamadı";
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
  String get labelGainControls => "Kazanç kontrolleri";
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
  String get labelGlobalParameters => "Genel parametreler";

  // Media Screen
  @override
  String get labelMusic => "Muzik";
  @override
  String get labelVideos => "Videolar";
  @override
  String get labelNoMediaYet => "Henüz burası boş";
  @override
  String get labelNoMediaYetJustification => "Tüm medya dosyalarınız " +
    "burada gösterilir";
  @override
  String get labelSearchMedia => "Medya ara...";
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
  String get labelAndroid11Fix => "Android 11 düzeltmesi";
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
  String get labelYouAreAboutToClear => "Dikkat! Temizlemek üzeresin";

  // Tags Editor TextFields
  @override
  String get labelEditorTitle => "Ad";
  @override
  String get labelEditorArtist => "Yapımcı";
  @override
  String get labelEditorGenre => "Tür";
  @override
  String get labelEditorDisc => "Disk";
  @override
  String get labelEditorTrack => "Track";
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
    "bu geçici bir çözüm ve gelecek güncellemelerde gerekli olmayacak. " +
    "Bu düzeltmeyi Ayarlar'dan da uygulayabilirsiniz.";

  // Music Player
  @override
  String get labelPlayerSettings => "Oynatıcı ayarları";
  @override
  String get labelExpandArtwork => "Görseli genişlet";
  @override
  String get labelArtworkRoundedCorners => "Kenerları yuvarlanmış görsel";
  @override
  String get labelPlayingFrom => "Şuradan oynat";
  @override
  String get labelBlurBackground => "Arka plan bulanıklaştırma";

  // Video Page
  @override
  String get labelTags => "Etiketler";
  @override
  String get labelRelated => "Alaka";
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
    "Aklınıza takılan bir sorun veya harika bir öneriniz varsa lütfen kanaldaki grub bağlantısını " +
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
  String get labelPlaylists => "Çalma listeleri";
  @override
  String get labelQuality => "Kalite";
  @override
  String get labelSubscribe => "Abone ol";
}
