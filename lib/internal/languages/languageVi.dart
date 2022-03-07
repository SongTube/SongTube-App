import 'package:songtube/internal/languages.dart';

class LanguageVi extends Languages {

  // Introduction Screens
  @override
  String get labelAppWelcome => "Chào mừng";
  @override
  String get labelStart => "Bắt đầu";
  @override
  String get labelSkip => "Bỏ qua";
  @override
  String get labelNext => "Tiếp tục";
  @override
  String get labelExternalAccessJustification =>
    "Cần Quyền truy cập vào Bộ nhớ ngoài của bạn để lưu " +
    "Video và nhạc";
  @override
  String get labelAppCustomization => "Tuỳ chọn";
  @override
  String get labelSelectPreferred => "Chọn ưu tiên";
  @override
  String get labelConfigReady => "Đã cấu hình";
  @override
  String get labelIntroductionIsOver => "Kết thúc giới thiệu";
  @override
  String get labelEnjoy => "Tân hưởng";
  @override 
  String get labelGoHome => "Về trang chủ";

  // Bottom Navigation Bar
  @override
  String get labelHome => "Trang chủ";
  @override
  String get labelDownloads => "Tải";
  @override
  String get labelMedia => "Media";
  @override
  String get labelYouTube => "YouTube";
  @override
  String get labelMore => "Nhiều hơn";

  // Home Screen
  @override
  String get labelQuickSearch => "Tìm kiếm nhanh...";
  @override
  String get labelTagsEditor => "Thẻ\nBiên tập viên";
  @override
  String get labelEditArtwork => "Sửa\nẢnh minh họa";
  @override
  String get labelDownloadAll => "Tải xuống tất cả";
  @override 
  String get labelLoadingVideos => "Đang tải video...";
  @override
  String get labelHomePage => "Trang chủ";
  @override
  String get labelTrending => "Xu hướng";
  @override
  String get labelFavorites => "Yêu thích";
  @override
  String get labelWatchLater => "Xem sau";

  // Video Options Menu
  @override
  String get labelCopyLink => "Sao chép đường dẫn";
  @override
  String get labelAddToFavorites => "Thêm vào mục yêu thích";
  @override
  String get labelAddToWatchLater => "Thêm vào Xem sau";
  @override
  String get labelAddToPlaylist => "Thêm vào danh sách phát";

  // Downloads Screen
  @override
  String get labelQueued => "Đã thêm vào hàng đợi";
  @override
  String get labelDownloading => "Đang tải xuống";
  @override
  String get labelConverting => "Đang chuyển đổi";
  @override
  String get labelCancelled => "Đã hủy";
  @override
  String get labelCompleted => "Đã hoàn thành";

  // Download Status/Error Messages
  @override
  String get labelDownloadQueued => "Tải xuống được xếp hàng đợi";
  @override
  String get labelDownloadAcesssDenied => "Quyền truy cập bị Từ chối";
  @override
  String get labelClearingExistingMetadata => "Xóa dữ liệu hiện có...";
  @override
  String get labelWrittingTagsAndArtwork => "Viết thẻ & ảnh minh hoạ...";
  @override
  String get labelSavingFile => "Lưu file...";
  @override
  String get labelAndroid11FixNeeded => "Lỗi, cần sửa Android 11, kiểm tra Cài đặt";
  @override
  String get labelErrorSavingDownload => "Không thể tải xuống, xin hãy kiểm tra Quyền";
  @override
  String get labelDownloadingVideo => "Tải xuống Video...";
  @override
  String get labelDownloadingAudio => "Tải xuống âm thanh...";
  @override
  String get labelGettingAudioStream => "Tải Audio Stream...";
  @override
  String get labelAudioNoDataRecieved => "Không thể tải Audio Stream";
  @override
  String get labelDownloadStarting => "Bắt đầu tải xuống...";
  @override
  String get labelDownloadCancelled => "Tải xuống đã bị hủy";
  @override
  String get labelAnIssueOcurredConvertingAudio => "Quá trình chuyển đổi không thành công";
  @override
  String get labelPatchingAudio => "Vá âm thanh...";

  // Download Menu
  @override
  String get labelEnableAudioConversion => "Bật chuyển đổi âm thanh";
  @override
  String get labelGainControls => "Cài đặt kiểm soát";
  @override
  String get labelVolume => "Âm lượng";
  @override
  String get labelBassGain => "Tăng âm trầm";
  @override
  String get labelTrebleGain => "Tăng âm Treble";
  @override
  String get labelSelectVideo => "Chọn Video";
  @override
  String get labelSelectAudio => "Chọn âm thanh";
  @override
  String get labelGlobalParameters => "Tham số toàn cục";

  // Media Screen
  @override
  String get labelMusic => "Âm nhạc";
  @override
  String get labelVideos => "Videos";
  @override
  String get labelNoMediaYet => "Không có phương tiện truyền thông nào";
  @override
  String get labelNoMediaYetJustification => "Tất cả các phương tiện truyền thông của bạn " +
    "sẽ được hiển thị ở đây";
  @override
  String get labelSearchMedia => "Tìm kiếm phương tiện truyền thông...";
  @override
  String get labelDeleteSong => "Xóa bài hát";
  @override
  String get labelNoPermissionJustification => "Xem phương tiện truyền thông của bạn bằng cách" + "\n" +
    "Cấp quyền lưu trữ";
  @override
  String get labelGettingYourMedia => "Nhận phương tiện truyền thông của bạn...";
  @override
  String get labelEditTags => "Chỉnh sửa thẻ";

  // Navigate Screen
  @override
  String get labelSearchYoutube => "Tìm kiếm YouTube...";

  // More Screen
  @override
  String get labelSettings => "Cài đặt";
  @override
  String get labelDonate => "Quyên tặng";
  @override
  String get labelLicenses => "Giấy phép";
  @override
  String get labelChooseColor => "Chọn màu";
  @override
  String get labelTheme => "Chủ đề";
  @override
  String get labelUseSystemTheme => "Sử dụng chủ đề hệ thống";
  @override
  String get labelUseSystemThemeJustification =>
    "Bật/Tắt chủ đề tự động";
  @override
  String get labelEnableDarkTheme => "Bật Dark Mode";
  @override
  String get labelEnableDarkThemeJustification =>
    "Dùng Dark Mode mặc định";
  @override
  String get labelEnableBlackTheme => "Kích hoạt Dark Mode";
  @override
  String get labelEnableBlackThemeJustification =>
    "Kích hoạt chủ đề đen tinh khiết";
  @override
  String get labelAccentColor => "Màu accent";
  @override
  String get labelAccentColorJustification => "Tùy chỉnh màu accent.";
  @override
  String get labelAudioFolder => "Thư mục âm thanh";
  @override
  String get labelAudioFolderJustification => "Chọn một thư mục cho " +
    "Tải xuống âm thanh";
  @override
  String get labelVideoFolder => "Thư mục video.";
  @override
  String get labelVideoFolderJustification => "Chọn một thư mục cho " +
    "Tải video";
  @override
  String get labelAlbumFolder => "Thư mục album";
  @override
  String get labelAlbumFolderJustification => "Tạo một thư mục cho mỗi album bài hát";
  @override
  String get labelDeleteCache => "Xóa bộ nhớ cache";
  @override
  String get labelDeleteCacheJustification => "Xoá cache SongTube";
  @override
  String get labelAndroid11Fix => "Sửa Android 11";
  @override
  String get labelAndroid11FixJustification => "Sửa lỗi tải xuống " +
    "Android 10 & 11";
  @override
  String get labelBackup => "Sao lưu";
  @override
  String get labelBackupJustification => "Sao lưu thư viện phương tiện của bạn";
  @override
  String get labelRestore => "Khôi phục";
  @override
  String get labelRestoreJustification => "Khôi phục thư viện phương tiện của bạn";
  @override
  String get labelBackupLibraryEmpty => "Thư viện của bạn trống";
  @override
  String get labelBackupCompleted => "Sao lưu hoàn thành";
  @override
  String get labelRestoreNotFound => "Khôi phục không tìm thấy";
  @override
  String get labelRestoreCompleted => "Khôi phục hoàn thành";
  @override
  String get labelCacheIsEmpty => "Bộ nhớ cache trống";
  @override
  String get labelYouAreAboutToClear => "Bạn sắp xóa";

  // Tags Editor TextFields
  @override
  String get labelEditorTitle => "Tên";
  @override
  String get labelEditorArtist => "Nghệ sĩ";
  @override
  String get labelEditorGenre => "Thể loại";
  @override
  String get labelEditorDisc => "Đĩa";
  @override
  String get labelEditorTrack => "Track";
  @override
  String get labelEditorDate => "Ngày";
  @override
  String get labelEditorAlbum => "Album";

  // Android 10 or 11 Detected Dialog
  @override
  String get labelAndroid11Detected => "Phát hiện Android 10 hoặc 11";
  @override
  String get labelAndroid11DetectedJustification => "Để đảm bảo đúng " +
    "hoạt động của chức năng tải xuống ứng dụng này, trên Android 10 và 11, truy cập vào tất cả " +
    "yêu cầu tập tin có thể cần thiết, đây sẽ là tạm thời và không bắt buộc " +
    "về các cập nhật trong tương lai. Bạn cũng có thể áp dụng bản sửa lỗi này trong Cài đặt.";

  // Music Player
  @override
  String get labelPlayerSettings => "Cài đặt người chơi";
  @override
  String get labelExpandArtwork => "Mở rộng tác phẩm nghệ thuật";
  @override
  String get labelArtworkRoundedCorners => "Tác phẩm nghệ thuật tròn góc.";
  @override
  String get labelPlayingFrom => "Chơi từ";
  @override
  String get labelBlurBackground => "Nền mờ";

  // Video Page
  @override
  String get labelTags => "Tags";
  @override
  String get labelRelated => "Có liên quan";
  @override
  String get labelAutoPlay => "Tự chạy";

  // Tags Pages
  @override
  String get labelAudioFormatNotCompatible =>
    "Định dạng âm thanh không tương thích";
  @override
  String get labelNotSpecified => "Không được chỉ định";
  @override
  String get labelPerformAutomaticTagging => 
    "Thực hiện gắn thẻ tự động";
  @override
  String get labelSelectTagsfromMusicBrainz => 
    "Chọn thẻ từ MusicBrainz";
  @override
  String get labelSelectArtworkFromDevice =>
    "Chọn tác phẩm nghệ thuật từ thiết bị";

  // Telegram Join Channel Dialog
  @override
  String get labelJoinTelegramChannel => "Tham gia kênh Telegram!";
  @override
  String get labelJoinTelegramJustification =>
    "Bạn có thích SongTube không? Vui lòng tham gia kênh Telegram! Bạn sẽ thấy " +
    "thông tin về cập nhật, phát triển, liên kết nhóm và các link social khác." +
    "\n\n" +
    "Trong trường hợp bạn có một vấn đề hoặc một khuyến nghị tuyệt vời trong tâm trí của bạn, " +
    "vui lòng tham gia nhóm và nhắn tin! Nhưng hãy nhớ rằng " +
    "bạn chỉ có thể nói bằng tiếng Anh, cảm ơn!";
  @override
  String get labelRemindLater => "Nhắc nhở sau";

  // Common Words (One word labels)
  @override
  String get labelExit => "Thoát";
  @override
  String get labelSystem => "Hệ thống";
  @override
  String get labelChannel => "Kênh";
  @override
  String get labelShare => "Chia sẻ";
  @override
  String get labelAudio => "Âm thanh";
  @override
  String get labelVideo => "Video";
  @override
  String get labelDownload => "Tải xuống";
  @override
  String get labelBest => "Tốt nhất";
  @override
  String get labelPlaylist => "Danh sách phát";
  @override
  String get labelVersion => "Phiên bản";
  @override
  String get labelLanguage => "Ngôn ngữ";
  @override
  String get labelGrant => "Cấp quyền";
  @override
  String get labelAllow => "Cho phép";
  @override
  String get labelAccess => "Truy cập";
  @override
  String get labelEmpty => "Trống";
  @override
  String get labelCalculating => "Tính toán";
  @override
  String get labelCleaning => "Làm sạch";
  @override
  String get labelCancel => "Hủy bỏ";
  @override
  String get labelGeneral => "Chung";
  @override
  String get labelRemove => "Xoá";
  @override
  String get labelJoin => "Tham gia";
  @override
  String get labelNo => "Không";
  @override
  String get labelLibrary => "Thư viện";
  @override
  String get labelCreate => "Tạo";
  @override
  String get labelPlaylists => "Danh sách phát";
  @override
  String get labelQuality => "Chất lượng";
  @override
  String get labelSubscribe => "Đặt mua";
}
