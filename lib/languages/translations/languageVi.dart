import 'package:songtube/languages/languages.dart';

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
