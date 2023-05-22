import 'package:songtube/languages/languages.dart';

class LanguageZhCN extends Languages {

  // Introduction Screens
  @override
  String get labelAppWelcome => "欢迎来到";
  @override
  String get labelStart => "开始";
  @override
  String get labelSkip => "跳过";
  @override
  String get labelNext => "下一步";
  @override
  String get labelExternalAccessJustification =>
    "需要授权外部存储权限以保存 " +
    "你的视频与音乐";
  @override
  String get labelAppCustomization => "外观定制";
  @override
  String get labelSelectPreferred => "选择你喜欢的";
  @override
  String get labelConfigReady => "配置完成";
  @override
  String get labelIntroductionIsOver => "介绍到这路就结束了";
  @override
  String get labelEnjoy => "开始享受";
  @override 
  String get labelGoHome => "进入主页";

  // Bottom Navigation Bar
  @override
  String get labelHome => "主页";
  @override
  String get labelDownloads => "下载";
  @override
  String get labelMedia => "媒体";
  @override
  String get labelYouTube => "YouTube";
  @override
  String get labelMore => "更多";

  // Home Screen
  @override
  String get labelQuickSearch => "快速搜索...";
  @override
  String get labelTagsEditor => "编辑标签";
  @override
  String get labelEditArtwork => "编辑封面";
  @override
  String get labelDownloadAll => "下载全部";
  @override 
  String get labelLoadingVideos => "正在加载视频...";
  @override
  String get labelHomePage => "主页";
  @override
  String get labelTrending => "热门";
  @override
  String get labelFavorites => "收藏";
  @override
  String get labelWatchLater => "稍后观看";

  // Video Options Menu
  @override
  String get labelCopyLink => "复制链接";
  @override
  String get labelAddToFavorites => "添加至收藏";
  @override
  String get labelAddToWatchLater => "添加至稍后观看";
  @override
  String get labelAddToPlaylist => "添加至播放列表";

  // Downloads Screen
  @override
  String get labelQueued => "队列";
  @override
  String get labelDownloading => "下载中";
  @override
  String get labelConverting => "转换中";
  @override
  String get labelCancelled => "已取消";
  @override
  String get labelCompleted => "已完成";

  // Download Status/Error Messages
  @override
  String get labelDownloadQueued => "下载队列";
  @override
  String get labelDownloadAcesssDenied => "访问被拒绝";
  @override
  String get labelClearingExistingMetadata => "正在清除元数据...";
  @override
  String get labelWrittingTagsAndArtwork => "正在写入标签与封面...";
  @override
  String get labelSavingFile => "正在保存文件...";
  @override
  String get labelAndroid11FixNeeded => "错误，Android 11 需要修复，请检查设置";
  @override
  String get labelErrorSavingDownload => "不能保存已下载的文件，请检查权限";
  @override
  String get labelDownloadingVideo => "正在下载视频...";
  @override
  String get labelDownloadingAudio => "正在下载音频...";
  @override
  String get labelGettingAudioStream => "正在获取音频流...";
  @override
  String get labelAudioNoDataRecieved => "无法获取音频流";
  @override
  String get labelDownloadStarting => "开始下载...";
  @override
  String get labelDownloadCancelled => "下载已取消";
  @override
  String get labelAnIssueOcurredConvertingAudio => "转换失败";
  @override
  String get labelPatchingAudio => "正在应用音频补丁...";

  // Download Menu
  @override
  String get labelEnableAudioConversion => "启用音频转换";
  @override
  String get labelGainControls => "增益控制";
  @override
  String get labelVolume => "音量";
  @override
  String get labelBassGain => "低频增益";
  @override
  String get labelTrebleGain => "高频增益";
  @override
  String get labelSelectVideo => "选择视频";
  @override
  String get labelSelectAudio => "选择音频";
  @override
  String get labelGlobalParameters => "全局参数";

  // Media Screen
  @override
  String get labelMusic => "音乐";
  @override
  String get labelVideos => "视频";
  @override
  String get labelNoMediaYet => "还没有媒体";
  @override
  String get labelNoMediaYetJustification => "这里将显示你的所有媒体";
  @override
  String get labelSearchMedia => "搜索媒体...";
  @override
  String get labelDeleteSong => "删除歌曲";
  @override
  String get labelNoPermissionJustification => "授予权限以查看媒体";
  @override
  String get labelGettingYourMedia => "正在获取媒体...";
  @override
  String get labelEditTags => "编辑标签";

  // Navigate Screen
  @override
  String get labelSearchYoutube => "搜索 YouTube...";

  // More Screen
  @override
  String get labelSettings => "设置";
  @override
  String get labelDonate => "捐赠";
  @override
  String get labelLicenses => "许可协议";
  @override
  String get labelChooseColor => "选择颜色";
  @override
  String get labelTheme => "主体";
  @override
  String get labelUseSystemTheme => "跟随系统";
  @override
  String get labelUseSystemThemeJustification =>
    "启用/禁用 跟随系统主题";
  @override
  String get labelEnableDarkTheme => "启用深色主题";
  @override
  String get labelEnableDarkThemeJustification =>
    "默认启用深色主题";
  @override
  String get labelEnableBlackTheme => "启用黑色主题";
  @override
  String get labelEnableBlackThemeJustification =>
    "启用纯黑色主题";
  @override
  String get labelAccentColor => "主色调";
  @override
  String get labelAccentColorJustification => "定制主色调";
  @override
  String get labelAudioFolder => "音频文件夹";
  @override
  String get labelAudioFolderJustification => "将下载的音频保存至";
  @override
  String get labelVideoFolder => "视频文件夹";
  @override
  String get labelVideoFolderJustification => "将下载的视频保存至";
  @override
  String get labelAlbumFolder => "专辑文件夹";
  @override
  String get labelAlbumFolderJustification => "为每个专辑创建独立的文件夹";
  @override
  String get labelDeleteCache => "清除缓存";
  @override
  String get labelDeleteCacheJustification => "清除 SongTube 缓存";
  @override
  String get labelAndroid11Fix => "Android 11 修复";
  @override
  String get labelAndroid11FixJustification => "修复 Android 10 & 11 的下载问题";
  @override
  String get labelBackup => "备份";
  @override
  String get labelBackupJustification => "备份你的媒体库";
  @override
  String get labelRestore => "回复";
  @override
  String get labelRestoreJustification => "恢复你的媒体库";
  @override
  String get labelBackupLibraryEmpty => "媒体库为空";
  @override
  String get labelBackupCompleted => "备份完成";
  @override
  String get labelRestoreNotFound => "找不到可恢复的备份";
  @override
  String get labelRestoreCompleted => "恢复完成";
  @override
  String get labelCacheIsEmpty => "缓存为空";
  @override
  String get labelYouAreAboutToClear => "即将清除";

  // Tags Editor TextFields
  @override
  String get labelEditorTitle => "标题";
  @override
  String get labelEditorArtist => "艺人";
  @override
  String get labelEditorGenre => "类型";
  @override
  String get labelEditorDisc => "唱片";
  @override
  String get labelEditorTrack => "曲目";
  @override
  String get labelEditorDate => "日期";
  @override
  String get labelEditorAlbum => "专辑";

  // Android 10 or 11 Detected Dialog
  @override
  String get labelAndroid11Detected => "检查到系统为 Android 10 或 11";
  @override
  String get labelAndroid11DetectedJustification => "为了确保本应用正常下载" +
    "需要请求访问所有文件夹的权限 " +
    "这将是暂时性的，可能会在未来的更新中修复 " +
    "你也可以在设置中应用此修复。";

  // Music Player
  @override
  String get labelPlayerSettings => "播放器设置";
  @override
  String get labelExpandArtwork => "展开封面图";
  @override
  String get labelArtworkRoundedCorners => "圆角封面图";
  @override
  String get labelPlayingFrom => "播放来自";
  @override
  String get labelBlurBackground => "模糊背景";

  // Video Page
  @override
  String get labelTags => "标签";
  @override
  String get labelRelated => "相关的";
  @override
  String get labelAutoPlay => "自动播放";

  // Tags Pages
  @override
  String get labelAudioFormatNotCompatible =>
    "不兼容此音频格式";
  @override
  String get labelNotSpecified => "未指定";
  @override
  String get labelPerformAutomaticTagging => 
    "执行自动标签";
  @override
  String get labelSelectTagsfromMusicBrainz => 
    "从MusicBrainz选择标签";
  @override
  String get labelSelectArtworkFromDevice =>
    "从设备中选择封面图";

  // Telegram Join Channel Dialog
  @override
  String get labelJoinTelegramChannel => "加入 Telegram 频道！";
  @override
  String get labelJoinTelegramJustification =>
    "你喜欢 SongTube吗？ 欢迎加入我们的 Telegram 频道！ 你可以在这里找到 " +
    "关于 更新，信息，开发，群组链接 以及其他资讯！" +
    "\n\n" +
    "如果你有任何问题，意见或建议 " +
    "请通过频道内的连接加入我们的群组，告诉我们！ " +
    "但请注意，只能通过英语交流，非常感谢！";
  @override
  String get labelRemindLater => "稍后提醒";

  // Common Words (One word labels)
  @override
  String get labelExit => "退出";
  @override
  String get labelSystem => "系统";
  @override
  String get labelChannel => "频道";
  @override
  String get labelShare => "分享";
  @override
  String get labelAudio => "音频";
  @override
  String get labelVideo => "视频";
  @override
  String get labelDownload => "下载";
  @override
  String get labelBest => "精选";
  @override
  String get labelPlaylist => "播放列表";
  @override
  String get labelVersion => "版本";
  @override
  String get labelLanguage => "语言";
  @override
  String get labelGrant => "授予";
  @override
  String get labelAllow => "允许";
  @override
  String get labelAccess => "访问";
  @override
  String get labelEmpty => "这里什么都没有";
  @override
  String get labelCalculating => "计算中";
  @override
  String get labelCleaning => "清理中";
  @override
  String get labelCancel => "取消";
  @override
  String get labelGeneral => "通用";
  @override
  String get labelRemove => "删除";
  @override
  String get labelJoin => "加入";
  @override
  String get labelNo => "不";
  @override
  String get labelLibrary => "库";
  @override
  String get labelCreate => "创建";
  @override
  String get labelPlaylists => "播放列表";
  @override
  String get labelQuality => "品质";
  @override
  String get labelSubscribe => "订阅";

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