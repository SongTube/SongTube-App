import 'package:songtube/languages/languages.dart';

class LanguageId extends Languages {

  // Introduction Screens
  @override
  String get labelAppWelcome => "Selamat Datang di";
  @override
  String get labelStart => "Mulai";
  @override
  String get labelSkip => "Lewati";
  @override
  String get labelNext => "Berikutnya";
  @override
  String get labelExternalAccessJustification =>
    "Membutuhkan Akses ke Penyimpanan Eksternal anda untuk menyimpan semua " +
    "Video dan Musik anda";
  @override
  String get labelAppCustomization => "Kustomisasi";
  @override
  String get labelSelectPreferred => "Pilih kesukaan anda";
  @override
  String get labelConfigReady => "Konfigurasi Siap";
  @override
  String get labelIntroductionIsOver => "Pengantar sudah berakhir";
  @override
  String get labelEnjoy => "Nikmati";
  @override 
  String get labelGoHome => "Pergi Ke Beranda";

  // Bottom Navigation Bar
  @override
  String get labelHome => "Beranda";
  @override
  String get labelDownloads => "Unduhan";
  @override
  String get labelMedia => "Media";
  @override
  String get labelYouTube => "YouTube";
  @override
  String get labelMore => "Lebih";

  // Home Screen
  @override
  String get labelQuickSearch => "Pencarian Cepat...";
  @override
  String get labelTagsEditor => "Tag\nEditor";
  @override
  String get labelEditArtwork => "Edit\nArtwork";
  @override
  String get labelDownloadAll => "Unduh Semua";
  @override 
  String get labelLoadingVideos => "Memuat Video...";
  @override
  String get labelHomePage => "Halaman Beranda";
  @override
  String get labelTrending => "Trending";
  @override
  String get labelFavorites => "Favorit";
  @override
  String get labelWatchLater => "Tonton Nanti";

  // Video Options Menu
  @override
  String get labelCopyLink => "Salin Tautan";
  @override
  String get labelAddToFavorites => "Tambahkan ke Favorit";
  @override
  String get labelAddToWatchLater => "Tambahkan ke Tonton Nanti";
  @override
  String get labelAddToPlaylist => "Tambahkan ke Daftar Putar";

  // Downloads Screen
  @override
  String get labelQueued => "Dalam antrian";
  @override
  String get labelDownloading => "Mengunduh";
  @override
  String get labelConverting => "Mengonversi";
  @override
  String get labelCancelled => "Dibatalkan";
  @override
  String get labelCompleted => "Selesai";

  // Download Status/Error Messages
  @override
  String get labelDownloadQueued => "Unduhan Dalam Antrian";
  @override
  String get labelDownloadAcesssDenied => "Akses ditolak";
  @override
  String get labelClearingExistingMetadata => "Menghapus Metadata Yang Ada...";
  @override
  String get labelWrittingTagsAndArtwork => "Menulis Tag & Artwork...";
  @override
  String get labelSavingFile => "Menyimpan File...";
  @override
  String get labelAndroid11FixNeeded => "Kesalahan, Perlu Android 11 Fix, periksa Pengaturan";
  @override
  String get labelErrorSavingDownload => "Tidak dapat menyimpan Unduhan anda, periksa Izin";
  @override
  String get labelDownloadingVideo => "Mengunduh Video...";
  @override
  String get labelDownloadingAudio => "Mengunduh Audio...";
  @override
  String get labelGettingAudioStream => "Mendapatkan Audio Stream...";
  @override
  String get labelAudioNoDataRecieved => "Tidak bisa mendapatkan Audio Stream";
  @override
  String get labelDownloadStarting => "Unduhan Dimulai...";
  @override
  String get labelDownloadCancelled => "Unduhan Dibatalkan";
  @override
  String get labelAnIssueOcurredConvertingAudio => "Proses Yang Dikonversi Gagal";
  @override
  String get labelPatchingAudio => "Menambal Audio...";

  // Download Menu
  @override
  String get labelEnableAudioConversion => "Aktifkan Konversi Audio";
  @override
  String get labelGainControls => "Kontrol Penguat";
  @override
  String get labelVolume => "Volume";
  @override
  String get labelBassGain => "Penguatan Bass";
  @override
  String get labelTrebleGain => "Penguatan Treble";
  @override
  String get labelSelectVideo => "Pilih Video";
  @override
  String get labelSelectAudio => "Pilih Audio";
  @override
  String get labelGlobalParameters => "Parameter global";

  // Media Screen
  @override
  String get labelMusic => "Musik";
  @override
  String get labelVideos => "Video";
  @override
  String get labelNoMediaYet => "Belum Ada Media";
  @override
  String get labelNoMediaYetJustification => "Semua Media anda" +
    "akan ditampilkan di sini";
  @override
  String get labelSearchMedia => "Telusuri Media...";
  @override
  String get labelDeleteSong => "Hapus Lagu";
  @override
  String get labelNoPermissionJustification => "Lihat Media anda dengan" + "\n" +
    "Memberikan Izin Penyimpanan";
  @override
  String get labelGettingYourMedia => "Mendapatkan Media anda...";
  @override
  String get labelEditTags => "Edit Tag";

  // Navigate Screen
  @override
  String get labelSearchYoutube => "Telusuri YouTube...";

  // More Screen
  @override
  String get labelSettings => "Pengaturan";
  @override
  String get labelDonate => "Donasi";
  @override
  String get labelLicenses => "Lisensi";
  @override
  String get labelChooseColor => "Pilih Warna";
  @override
  String get labelTheme => "Tema";
  @override
  String get labelUseSystemTheme => "Gunakan Tema Sistem";
  @override
  String get labelUseSystemThemeJustification =>
    "Aktifkan/Nonaktifkan Tema otomatis";
  @override
  String get labelEnableDarkTheme => "Aktifkan Tema Gelap";
  @override
  String get labelEnableDarkThemeJustification =>
    "Gunakan Tema Gelap secara default";
  @override
  String get labelEnableBlackTheme => "Aktifkan Tema Hitam";
  @override
  String get labelEnableBlackThemeJustification =>
    "Aktifkan Tema Hitam Murni";
  @override
  String get labelAccentColor => "Aksen warna";
  @override
  String get labelAccentColorJustification => "Sesuaikan warna aksen";
  @override
  String get labelAudioFolder => "Folder Audio";
  @override
  String get labelAudioFolderJustification => "Pilih Folder untuk " +
    "Unduh Audio";
  @override
  String get labelVideoFolder => "Folder Video";
  @override
  String get labelVideoFolderJustification => "Pilih Folder untuk " +
    "Unduh Video";
  @override
  String get labelAlbumFolder => "Folder Album";
  @override
  String get labelAlbumFolderJustification => "Buat Folder untuk setiap Album Lagu";
  @override
  String get labelDeleteCache => "Hapus Cache";
  @override
  String get labelDeleteCacheJustification => "Hapus Cache SongTube";
  @override
  String get labelAndroid11Fix => "Perbaikan Android 11";
  @override
  String get labelAndroid11FixJustification => "Perbaikan Masalah unduhan di " +
    "Android 10 & 11";
  @override
  String get labelBackup => "Cadangan";
  @override
  String get labelBackupJustification => "Cadangkan perpustakaan media anda";
  @override
  String get labelRestore => "Pulihkan";
  @override
  String get labelRestoreJustification => "Pulihkan perpustakaan media anda";
  @override
  String get labelBackupLibraryEmpty => "Perpustakaan anda kosong";
  @override
  String get labelBackupCompleted => "Pencadangan Selesai";
  @override
  String get labelRestoreNotFound => "Pemulihan Tidak Ditemukan";
  @override
  String get labelRestoreCompleted => "Pulihkan Selesai";
  @override
  String get labelCacheIsEmpty => "Cache Kosong";
  @override
  String get labelYouAreAboutToClear => "Anda akan jelas";

  // Tags Editor TextFields
  @override
  String get labelEditorTitle => "Judul";
  @override
  String get labelEditorArtist => "Artis";
  @override
  String get labelEditorGenre => "Aliran";
  @override
  String get labelEditorDisc => "Disc";
  @override
  String get labelEditorTrack => "Track";
  @override
  String get labelEditorDate => "Tanggal";
  @override
  String get labelEditorAlbum => "Album";

  // Android 10 or 11 Detected Dialog
  @override
  String get labelAndroid11Detected => "Android 10 atau 11 Terdeteksi";
  @override
  String get labelAndroid11DetectedJustification => "Untuk memastikan yang benar " +
    "fungsi dari aplikasi ini Download, di Android 10 dan 11, akses ke semua " +
    "Izin file mungkin diperlukan, ini bersifat sementara dan tidak diperlukan " +
    "tentang pembaruan di masa mendatang. Anda juga dapat menerapkan perbaikan ini di Pengaturan.";

  // Music Player
  @override
  String get labelPlayerSettings => "Pengaturan Player";
  @override
  String get labelExpandArtwork => "Perluas Artwork";
  @override
  String get labelArtworkRoundedCorners => "Sudut Bulat Artwork";
  @override
  String get labelPlayingFrom => "Memutar Dari";
  @override
  String get labelBlurBackground => "Latar Belakang Buram";

  // Video Page
  @override
  String get labelTags => "Tag";
  @override
  String get labelRelated => "Terkait";
  @override
  String get labelAutoPlay => "PutarOtomatis";

  // Tags Pages
  @override
  String get labelAudioFormatNotCompatible =>
    "Format audio tidak Kompatibel";
  @override
  String get labelNotSpecified => "Tidak Ditentukan";
  @override
  String get labelPerformAutomaticTagging => 
    "Melakukan Pemberian Tag Otomatis";
  @override
  String get labelSelectTagsfromMusicBrainz => 
    "Pilih Tag dari MusicBrainz";
  @override
  String get labelSelectArtworkFromDevice =>
    "Pilih Artwork dari Perangkat";

  // Telegram Join Channel Dialog
  @override
  String get labelJoinTelegramChannel => "Gabung Saluran Telegram!";
  @override
  String get labelJoinTelegramJustification =>
    "Apakah anda suka SongTube? Silakan bergabung dengan Saluran Telegram! Anda akan menemukan " +
    "Pembaruan, Informasi, Pengembangan, Tautan Grup, dan tautan Sosial lainnya." +
    "\n\n" +
    "Jika anda memiliki masalah atau rekomendasi yang bagus dalam pikiran anda, " +
    "silakan bergabung dengan Grup dari Saluran dan tuliskan! Tapi ingatlah " +
    "anda hanya dapat berbicara dalam bahasa Inggris, terima kasih!";
  @override
  String get labelRemindLater => "Ingatkan Nanti";

  // Common Words (One word labels)
  @override
  String get labelExit => "Keluar";
  @override
  String get labelSystem => "Sistem";
  @override
  String get labelChannel => "Saluran";
  @override
  String get labelShare => "Bagikan";
  @override
  String get labelAudio => "Audio";
  @override
  String get labelVideo => "Video";
  @override
  String get labelDownload => "Unduh";
  @override
  String get labelBest => "Terbaik";
  @override
  String get labelPlaylist => "Daftar Putar";
  @override
  String get labelVersion => "Versi";
  @override
  String get labelLanguage => "Bahasa";
  @override
  String get labelGrant => "Mengizinkan";
  @override
  String get labelAllow => "Mengizinkan";
  @override
  String get labelAccess => "Akses";
  @override
  String get labelEmpty => "Kosong";
  @override
  String get labelCalculating => "Menghitung";
  @override
  String get labelCleaning => "Pembersihan";
  @override
  String get labelCancel => "Batalkan";
  @override
  String get labelGeneral => "Umum";
  @override
  String get labelRemove => "Hapus";
  @override
  String get labelJoin => "Gabung";
  @override
  String get labelNo => "Tidak";
  @override
  String get labelLibrary => "Perpustakaan";
  @override
  String get labelCreate => "Membuat";
  @override
  String get labelPlaylists => "Daftar Putar";
  @override
  String get labelQuality => "Kualitas";
  @override
  String get labelSubscribe => "Langganan";

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
