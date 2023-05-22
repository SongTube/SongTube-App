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
