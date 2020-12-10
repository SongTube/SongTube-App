import 'package:songtube/internal/languages.dart';

class LanguageTr extends Languages {

  // Introduction Screens
  @override
  String get labelAppWelcome => "'ye hoşgeldiniz";
  @override
  String get labelStart => "Başlat";
  @override
  String get labelSkip => "Atla";
  @override
  String get labelNext => "Sıradaki";
  @override
  String get labelExternalAccessJustification =>
    "Kaydetmek için depolamaya izne ihtiyacı var " +
    "Videolar ve müzikler";
  @override
  String get labelAppCustomization => "Özelleştirmeler";
  @override
  String get labelSelectPreferred => "Tercih ettiğinizi seçin";
  @override
  String get labelConfigReady => "Yapılandırma hazır";
  @override
  String get labelIntroductionIsOver => "Giriş bitti";
  @override
  String get labelEnjoy => "Zevk alın";
  @override 
  String get labelGoHome => "Ana Sayfaya Git";

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
  String get labelMore => "Daha Fazla";

  // Home Screen
  @override
  String get labelQuickSearch => "Hızlı Arama...";
  @override
  String get labelTagsEditor => "Tagları\nDüzenle";
  @override
  String get labelEditArtwork => "Resmi\nDüzenle";
  @override
  String get labelDownloadAll => "Hepsini İndir";
  @override 
  String get labelLoadingVideos => "Videolar Yükleniyor...";

  // Downloads Screen
  @override
  String get labelQueued => "Sıraya Alındı";
  @override
  String get labelDownloading => "İndiriliyor";
  @override
  String get labelConverting => "Çevriliyor";
  @override
  String get labelCancelled => "İptal Edildi";
  @override
  String get labelCompleted => "Tamamlandı";

  // Download Status/Error Messages
  @override
  String get labelDownloadQueued => "İndirme Sıraya Alındı";
  @override
  String get labelDownloadAcesssDenied => "İzin reddedildi";
  @override
  String get labelClearingExistingMetadata => "Zaten varolan Metadata siliniyor...";
  @override
  String get labelWrittingTagsAndArtwork => "Taglar & Resim uygulanıyor...";
  @override
  String get labelSavingFile => "Dosya Kaydediliyor...";
  @override
  String get labelAndroid11FixNeeded => "Hata, Android 11 düzeltmesi gerekli, Ayarları kontrol edin";
  @override
  String get labelErrorSavingDownload => "Dosya kaydedilemedi, uygulama için izinleri kontrol edin";
  @override
  String get labelDownloadingVideo => "Video İndiriliyor...";
  @override
  String get labelDownloadingAudio => "Ses İndiriliyor...";
  @override
  String get labelGettingAudioStream => "Ses Yayını İndiriliyor...";
  @override
  String get labelAudioNoDataRecieved => "Ses Yayın bulunamadı";
  @override
  String get labelDownloadStarting => "İndirme Başlatılıyor...";
  @override
  String get labelDownloadCancelled => "İndirme İptal Edildi";
  @override
  String get labelAnIssueOcurredConvertingAudio => "Çevirme başarısız oldu";
  @override
  String get labelPatchingAudio => "Ses yamalanıyor...";

  // Download Menu
  @override
  String get labelEnableAudioConversion => "Ses Çevirmesini Aç";
  @override
  String get labelGainControls => "Yükseklik Ayarları";
  @override
  String get labelVolume => "Ses";
  @override
  String get labelBassGain => "Bass Yüksekliği";
  @override
  String get labelTrebleGain => "Tiz Yüksekliği";
  @override
  String get labelSelectVideo => "Video Seç";
  @override
  String get labelSelectAudio => "Ses Seç";

  // Media Screen
  @override
  String get labelMusic => "Muzik";
  @override
  String get labelVideos => "Videolar";
  @override
  String get labelNoMediaYet => "Şu Anlık Medya Yok";
  @override
  String get labelNoMediaYetJustification => "Tüm medya dosyalarınız" +
    "burada gösterilecektir";
  @override
  String get labelSearchMedia => "Medya Ara...";
  @override
  String get labelDeleteSong => "Şarkıyı Sil";
  @override
  String get labelNoPermissionJustification => "Medyaya Şu İzni Vererek Bakınız" + "\n" +
    "Hafızaya Erişim İzni";
  @override
  String get labelGettingYourMedia => "Medya Yükleniyor...";

  // Navigate Screen
  @override
  String get labelSearchYoutube => "Youtube'da Ara...";

  // More Screen
  @override
  String get labelSettings => "Ayarlar";
  @override
  String get labelDonate => "Bağış Yap";
  @override
  String get labelLicenses => "Lisanslar";
  @override
  String get labelChooseColor => "Renk Seç";
  @override
  String get labelTheme => "Tema";
  @override
  String get labelUseSystemTheme => "Sistem Temasını Kullan";
  @override
  String get labelUseSystemThemeJustification =>
    "Otomatik temayı Aç/Kapat";
  @override
  String get labelEnableDarkTheme => "Karanlık Temayı Aç";
  @override
  String get labelEnableDarkThemeJustification =>
    "Karanlık Temayı Varsayılan Olarak Kullan";
  @override
  String get labelEnableBlackTheme => "Siyah Temayı Aç";
  @override
  String get labelEnableBlackThemeJustification =>
    "Saf Siyah Temayı Aç";
  @override
  String get labelAccentColor => "Varsayılan Renk";
  @override
  String get labelAccentColorJustification => "Varsayılan Rengi Özelleştir";
  @override
  String get labelAudioFolder => "Ses Klasörü";
  @override
  String get labelAudioFolderJustification => "Şunun için klasör seç " +
    "Ses İndirmeleri";
  @override
  String get labelVideoFolder => "Video Klasörü";
  @override
  String get labelVideoFolderJustification => "Şunun için klasör seç " +
    "Video İndirmeleri";
  @override
  String get labelAlbumFolder => "Album Klasörü";
  @override
  String get labelAlbumFolderJustification => "Her Albüm için bir klasör oluştur";
  @override
  String get labelDeleteCache => "Önbelleği Sil";
  @override
  String get labelDeleteCacheJustification => "SongTube'nin önbelleğini sil";
  @override
  String get labelAndroid11Fix => "Android 11 Düzeltmesi";
  @override
  String get labelAndroid11FixJustification => "Şu Android versiyonları için indirme sıkıntılarını düzeltir " +
    "Android 10 & 11";
  @override
  String get labelBackup => "Yedekle";
  @override
  String get labelBackupJustification => "Medya kütüphanesini yedekle";
  @override
  String get labelRestore => "Geri Yükle";
  @override
  String get labelRestoreJustification => "Medya kütüphanesini geri yükle";
  @override
  String get labelBackupLibraryEmpty => "Kütüphaneniz Boş";
  @override
  String get labelBackupCompleted => "Yedeklemr Tamamlandı";
  @override
  String get labelRestoreNotFound => "Geri Yükleme Dosyası Bulunamadı";
  @override
  String get labelRestoreCompleted => "Geri Yükleme Tamamlandı";
  @override
  String get labelCacheIsEmpty => "Önbellek Boş";
  @override
  String get labelYouAreAboutToClear => "Dikkat:Siliyorsunuz/Temizliyorsunuz";

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
  String get labelAndroid11Detected => "Android 10 ya da 11 Algılandı";
  @override
  String get labelAndroid11DetectedJustification => "Şunun çalıştıgından emin olmak için " +
    "bu uygulamadan indirilenler, Android 10 ve 11'de çalışması için " +
    "Hafızaya izin gerekebilir, bu kalıcı değildir ve gerekmez " +
    "ilerdeki güncellemeler için. Bu düzeltmeyi Ayarlardan da uygulayabilirsiniz.";

  // Common Words (One word labels)
  @override
  String get labelExit => "Çıkış";
  @override
  String get labelSystem => "Sistem";
  @override
  String get labelChannel => "Kanal/Grup";
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
  String get labelPlaylist => "Oynatma Listesk";
  @override
  String get labelVersion => "Sürüm";
  @override
  String get labelLanguage => "Dil";
  @override
  String get labelGrant => "İzin Ver";
  @override
  String get labelAllow => "Kabul Et";
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

}