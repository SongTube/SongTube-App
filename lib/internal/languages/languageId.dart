import 'package:songtube/internal/languages.dart';

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
}
